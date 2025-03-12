import 'package:get/get.dart';
import 'package:reko_codebase/domain/api_call_status.dart';

import '../../dio_api new.dart';
import '../../url.dart';

class ApiZidanfathProjects {
  ApiZidanfathProjects();

  get({
    Function(Map<String, dynamic>)? onSuccess,
    Function()? onError,
    required ApiCallStatus apiCallStatus,
    required GetxController controller,
  }) async {
    // *) perform api call
    await BaseClient.safeApiCall(
      '${URL.zidanfathProjects}', // url
      RequestType.get, // request type (get,post,delete,put)
      // *) request headers
      headers: {'Content-Type': 'application/json'},
      startLoading: false,

      apiCallStatus: (p0) {
        // *) indicate loading status
        apiCallStatus = p0;
        controller.update();
      },

      onSuccess: (responseMap) {
        Map<String, dynamic> responseMaps = responseMap.data;
        // api done successfully
        // responseData(responseMap);
        // EasyLoading.dismiss();
        var responseMapData = responseMaps;

        onSuccess != null ? onSuccess(responseMapData) : null;
        controller.update();
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error) {
        controller.update();
        // show error message to user
        BaseClient.handleApiError(error);
        // *) indicate error status
        apiCallStatus = ApiCallStatus.error;
        // error message
        controller.update();

        onError != null ? onError() : null;
        controller.update();
      },
    );
  }
}
