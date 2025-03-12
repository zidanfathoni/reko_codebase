import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../infrastructure/components/function/helper.dart';
import '../infrastructure/components/function/snackbar.dart';
import 'api_call_status.dart';
import 'api_exception.dart';

enum RequestType { get, post, put, patch, delete }

class BaseClient {
  static final Dio _dio = Dio(
      BaseOptions(headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}),
    )
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            var log = {
              'REQUEST ${options.method}': options.method,
              'PATH': options.path,
              'HEADERS': options.headers,
              'DATA': options.data,
            };
            Helper().logger.t(log, stackTrace: StackTrace.current, time: DateTime.now());
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            var log = {
              'RESPONSE ${response.statusCode}': response.statusCode,
              'PATH': response.requestOptions.path,
              'HEADERS': response.headers,
              'DATA': response.data,
            };
            Helper().logger.t(log, stackTrace: StackTrace.current, time: DateTime.now());
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            var log = {
              'ERROR ${e.response?.statusCode}': e.response?.statusCode,
              'PATH': e.requestOptions.path,
              'HEADERS': e.response?.headers,
              'DATA': e.response?.data,
            };
            Helper().logger.e(log, stackTrace: StackTrace.current, time: DateTime.now());
          }
          return handler.next(e);
        },
      ),
    );
  // ..interceptors.add(
  //   TalkerDioLogger(
  //     settings: TalkerDioLoggerSettings(
  //       printRequestHeaders: true,
  //       printResponseHeaders: true,
  //       printResponseMessage: true,
  //       responseFilter: (response) => response.statusCode != 200,
  //       printErrorData: true,
  //       printErrorMessage: true,
  //     ),
  //   ),
  // );

  // request timeout (default 10 seconds)
  // static const int _timeoutInSeconds = 60;
  // request timeout duration
  static Duration timeout = const Duration(minutes: 1);

  /// dio getter (used for testing)
  static get dio => _dio;

  /// perform safe api request
  static safeApiCall(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function(Response response)? onErrorMessage,
    Function(int value, int progress)? onReceiveProgress,
    Function(int total, int progress)? onSendProgress, // while sending (uploading) progress
    String? loadingMessage,
    required Function(ApiCallStatus) apiCallStatus,
    bool? startLoading,
    dynamic data,
  }) async {
    try {
      if (kDebugMode) {
        Helper().logger.t(
          'Api Call: $url \n Api Query: $queryParameters \n Api Data: $data \n Api Headers: $headers',
        );
      }
      // 1) indicate loading state
      apiCallStatus(ApiCallStatus.loading);
      startLoading == false
          ? null
          : EasyLoading.show(
            status: loadingMessage ?? 'loading...',
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true,
          );
      // 2) try to perform http request
      Response? response;
      if (requestType == RequestType.get) {
        response = await _dio.get(
          url,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else if (requestType == RequestType.post) {
        response = await _dio.post(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else if (requestType == RequestType.put) {
        response = await _dio.put(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else if (requestType == RequestType.patch) {
        response = await _dio.patch(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else {
        response = await _dio.delete(
          url,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      }
      // 3) return response (api done successfully)
      EasyLoading.dismiss();
      apiCallStatus(ApiCallStatus.success);
      await onSuccess(response);
    } on DioException catch (error) {
      EasyLoading.dismiss();
      // dio error (api reach the server but not performed successfully
      onErrorMessage?.call(error.response!);
      _handleDioError(error: error, url: url, onError: onError);
      apiCallStatus(ApiCallStatus.error);
    } on SocketException {
      EasyLoading.dismiss();
      apiCallStatus(ApiCallStatus.error);
      // No internet connection
      _handleSocketException(url: url, onError: onError);
    } on TimeoutException {
      EasyLoading.dismiss();
      apiCallStatus(ApiCallStatus.error);
      // Api call went out of time
      _handleTimeoutException(url: url, onError: onError);
    } catch (error, stackTrace) {
      EasyLoading.dismiss();
      apiCallStatus(ApiCallStatus.error);
      // print the line of code that throw unexpected exception
      Helper().logger.e(stackTrace);
      // unexpected error for example (parsing json error)
      _handleUnexpectedException(url: url, onError: onError, error: error);
    }
  }

  /// download file
  static download({
    required String url, // file url
    required String savePath, // where to save file
    Function(ApiException)? onError,
    Function(int value, int progress)? onReceiveProgress,
    required Function onSuccess,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        options: Options(receiveTimeout: timeout, sendTimeout: timeout),
        onReceiveProgress: onReceiveProgress,
      );
      onSuccess();
    } catch (error) {
      var exception = ApiException(url: url, message: error.toString());
      onError?.call(exception) ?? _handleError(error.toString());
    }
  }

  /// handle unexpected error
  static _handleUnexpectedException({
    Function(ApiException)? onError,
    required String url,
    required Object error,
  }) {
    if (onError != null) {
      onError(ApiException(message: error.toString(), url: url));
    } else {
      _handleError(error.toString());
    }
  }

  /// handle timeout exception
  static _handleTimeoutException({Function(ApiException)? onError, required String url}) {
    if (onError != null) {
      onError(ApiException(message: 'server not responding', url: url));
    } else {
      _handleError('server not responding');
    }
  }

  /// handle timeout exception
  static _handleSocketException({Function(ApiException)? onError, required String url}) {
    if (onError != null) {
      onError(ApiException(message: 'no internet connection', url: url));
    } else {
      _handleError('no internet connection');
    }
  }

  /// handle Dio error
  static _handleDioError({
    required DioException error,
    Function(ApiException)? onError,
    required String url,
  }) {
    // no internet connection
    if (error.type == DioExceptionType.connectionError) {
      return _handleSocketException(url: url, onError: onError);
    }

    // 400 error
    if (error.response?.statusCode == 400) {
      if (onError != null) {
        return onError(
          ApiException(
            message: error.response?.data['message'] ?? 'bad request',
            url: url,
            statusCode: 400,
          ),
        );
      } else {
        return _handleError('bad request');
      }
    }

    // 404 error
    if (error.response?.statusCode == 404) {
      if (onError != null) {
        return onError(ApiException(message: 'Url not found', url: url, statusCode: 404));
      } else {
        return _handleError('Url not found');
      }
    }

    // no internet connection
    if (error.message != null && error.message!.toLowerCase().contains('socket')) {
      if (onError != null) {
        return onError(ApiException(message: 'no internet connection', url: url));
      } else {
        return _handleError('no internet connection');
      }
    }

    // check if the error is 500 (server problem)
    if (error.response?.statusCode == 500) {
      var exception = ApiException(
        message: error.response?.data['message'] ?? 'server error',
        url: url,
        statusCode: 500,
      );

      if (onError != null) {
        return onError(exception);
      } else {
        return handleApiError(exception);
      }
    }

    // check if the error is 502 (bad gateway)
    if (error.response?.statusCode == 502) {
      var exception = ApiException(
        message: error.response?.data['message'] ?? 'bad gateway',
        url: url,
        statusCode: 502,
      );

      if (onError != null) {
        return onError(exception);
      } else {
        return handleApiError(exception);
      }
    }

    var exception = ApiException(
      url: url,
      message: error.message ?? 'Un Expected Api Error!',
      response: error.response,
      statusCode: error.response?.statusCode,
    );
    if (onError != null) {
      return onError(exception);
    } else {
      return handleApiError(exception);
    }
  }

  /// handle error automaticly (if user didnt pass onError) method
  /// it will try to show the message from api if there is no message
  /// from api it will show the reason (the dio message)
  static handleApiError(ApiException apiException) {
    String msg = apiException.toString();
    CustomSnackBar.showCustomErrorToast(message: msg);
    Helper().logger.e(msg);
  }

  static handleApiErrorWithCustomMessage(String customMessage) {
    CustomSnackBar.showCustomErrorToast(message: customMessage);
    Helper().logger.e(customMessage);
  }

  /// handle errors without response (500, out of time, no internet,..etc)
  static _handleError(String msg) {
    CustomSnackBar.showCustomErrorToast(message: msg);
    Helper().logger.e(msg);
  }
}
