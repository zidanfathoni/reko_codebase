import 'dart:convert';
import 'dart:io';

import 'package:card_loading/card_loading.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:reko_codebase/infrastructure/config/device_helper/device_config.dart';

import '../atom/FZ_Text.dart';
import 'base_data.dart';
import 'config.dart';

class Helper {
  Helper();

  String datePattern1 = 'dd MMM yyyy';
  String datePattern2 = 'dd MMM yyyy HH:mm:ss';
  String datePattern3 = 'dd MMM yyyy HH:mm';

  static const String appName = 'Fiberzone';

  static const Duration timeOutDuration = Duration(seconds: 60);

  DateFormat dateFormat = DateFormat('dd MMM yyyy');
  String customDateTime(String? pattern, String date) {
    return DateFormat(pattern ?? 'dd MMM yyyy').format(convertStringToDateTime(date).toLocal());
  }

  DateTime convertStringToDateTime(String date) {
    return DateTime.parse(date);
  }

  var logger = Logger(
    output: ConsoleOutput(),
    filter: ProductionFilter(),
    printer: PrettyPrinter(
      // methodCount: 0,
      errorMethodCount: 8,
      colors: true,
      printEmojis: true,
      levelColors: {
        Level.verbose: const AnsiColor.fg(8),
        Level.debug: const AnsiColor.fg(4),
        Level.info: const AnsiColor.fg(2),
        Level.warning: const AnsiColor.fg(3),
        Level.error: const AnsiColor.fg(1),
        Level.wtf: const AnsiColor.fg(5),
        Level.nothing: const AnsiColor.fg(0),
        Level.all: const AnsiColor.fg(7),
        Level.trace: const AnsiColor.fg(6),
        Level.fatal: const AnsiColor.fg(1),
        Level.off: const AnsiColor.fg(0),
      },
      lineLength: 110,
      dateTimeFormat: (time) {
        return DateTime.now().toIso8601String();
      },
      levelEmojis: {
        Level.trace: '📝',
        Level.debug: '🐛',
        Level.info: 'ℹ️',
        Level.warning: '⚠️',
        Level.error: '🚨',
        Level.fatal: '🤷‍♂️',
        Level.nothing: '🙈',
        Level.all: '🙌🏻',
        Level.verbose: '📣',
        Level.wtf: '🤯',
        Level.off: '🔇',
      },
    ),
  );

  Widget refreshPage({required Key key, required Function() onRefresh, required Widget child}) {
    return EasyRefresh(
      header: MaterialHeader(
        hitOver: isBlank,
        bezierBackgroundAnimation: true,
        safeArea: true,
        noMoreIcon: const Icon(Icons.sync),
        hapticFeedback: true,
        clamping: true,
        showBezierBackground: true,
        bezierBackgroundBounce: true,
        bezierBackgroundColor: ColorPalettes.primary,
        valueColor: AlwaysStoppedAnimation(ColorPalettes.primaryContainer),
        // semanticsLabel: ,
        triggerOffset: 50.0,
      ),
      onRefresh: () async {
        onRefresh();
      },
      key: key,
      child: child,
    );
  }

  Widget refreshWidget({required Key key, required Function() onRefresh, required Widget child}) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      strokeWidth: 2.0,
      semanticsValue: 'Refresh',
      semanticsLabel: 'Refresh',
      backgroundColor: Colors.white,
      color: Colors.black,
      notificationPredicate: (notification) {
        return notification.depth == 0;
      },
      key: key,
      elevation: 0.0,
      edgeOffset: 0.0,
      displacement: 40.0,
      onRefresh: () async {
        onRefresh();
      },
      child: child,
    );
  }

  static void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static Future<T?> openBottomSheet<T>(
    Widget child, {
    Color? backgroundColor,
    bool isDismissible = true,
    ShapeBorder? shape,
  }) async => await Get.bottomSheet<T>(
    child,
    barrierColor: Colors.black.withOpacity(0.7),
    backgroundColor: backgroundColor,
    isDismissible: isDismissible,
    shape:
        shape ??
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
    isScrollControlled: true,
    settings: RouteSettings(name: 'bottomSheet'),
    enterBottomSheetDuration: const Duration(milliseconds: 300),
    exitBottomSheetDuration: const Duration(milliseconds: 300),
    clipBehavior: Clip.antiAlias,
    enableDrag: true,
    persistent: true,
  );

  /// Show error dialog from response model
  static Future<void> showInfoDialog(
    String message, [
    bool isSuccess = false,
    String? title,
  ]) async {
    await Get.dialog(
      CupertinoAlertDialog(
        title: Text(title ?? (isSuccess ? 'Success' : 'Error')),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: Get.back,
            isDefaultAction: true,
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  /// Show alert dialog
  static Future<void> showDialog({
    String? name,
    String? message,
    required String title,
    String? submitText,
    String? cancelText,
    Function()? onSubmit,
    Function()? onCancel,
    Color? submitColor,
    Color? cancelColor,
    bool barrierDismissible = true,
    Object? arguments,
    Widget? content,
    List<Widget>? actions,
  }) async {
    await Get.dialog(
      barrierDismissible: barrierDismissible,
      transitionCurve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 200),
      routeSettings: RouteSettings(name: 'alertDialog ${name ?? 'default'}'),
      name: 'alertDialog ${name ?? 'default'}',
      arguments: arguments,

      useSafeArea: true,

      Platform.isIOS
          ? CupertinoAlertDialog(
            title: Text('$title'),
            content: content ?? Text(message ?? ''),

            actions:
                actions ??
                <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: submitColor ?? ColorData.primary,
                      animationDuration: const Duration(milliseconds: 500),
                      shadowColor: submitColor ?? ColorData.primary,
                      splashFactory: InkRipple.splashFactory,
                      surfaceTintColor: submitColor ?? ColorData.primary,
                    ),

                    onPressed: () {
                      Get.back();
                      onSubmit;
                    },
                    child: Text(submitText ?? 'OK'),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: cancelColor ?? Colors.red,
                      animationDuration: const Duration(milliseconds: 500),
                      shadowColor: cancelColor ?? Colors.red,
                      splashFactory: InkRipple.splashFactory,
                      surfaceTintColor: cancelColor ?? Colors.red,
                    ),
                    onPressed: () {
                      Get.back();
                      onCancel;
                    },
                    child: Text(cancelText ?? 'Cancel'),
                  ),
                ],
          )
          : AlertDialog(
            title: Text('$title'),
            content: content ?? Text(message ?? ''),
            scrollable: true,
            clipBehavior: Clip.antiAlias,
            semanticLabel: 'Alert Dialog ${name ?? 'default'}',

            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: submitColor ?? ColorData.primary,
                  animationDuration: const Duration(milliseconds: 500),
                  shadowColor: submitColor ?? ColorData.primary,
                  splashFactory: InkRipple.splashFactory,
                  surfaceTintColor: submitColor ?? ColorData.primary,
                ),

                onPressed: () {
                  Get.back();
                  onSubmit;
                },
                child: Text(submitText ?? 'OK'),
              ),

              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: cancelColor ?? Colors.red,
                  animationDuration: const Duration(milliseconds: 500),
                  shadowColor: cancelColor ?? Colors.red,
                  splashFactory: InkRipple.splashFactory,
                  surfaceTintColor: cancelColor ?? Colors.red,
                ),
                onPressed: () {
                  Get.back();
                  onCancel;
                },
                child: Text(cancelText ?? 'Cancel'),
              ),
            ],
          ),
    );
  }

  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  /// Close any open snackbar
  static void closeSnackbar() {
    if (Get.isSnackbarOpen) Get.back<void>();
  }

  /// Show a message to the user.
  ///
  /// [message] : Message you need to show to the user.
  /// [type] : Type of the message for different background color.
  /// [onTap] : An event for onTap.
  /// [actionName] : The name for the action.

  static void unfocusKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void updateLater(VoidCallback callback, [bool addDelay = true]) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(addDelay ? const Duration(milliseconds: 10) : Duration.zero, () {
        callback();
      });
    });
  }

  /// this is for change encoded string to decode string
  static String decodeString(String value) {
    try {
      return utf8.fuse(base64).decode(value);
    } catch (e) {
      return value;
    }
  }

  /// this is for change decode string to encode string
  static String encodeString(String value) => utf8.fuse(base64).encode(value);

  Future<void> openSettings({
    required String label,
    required String message,
    Function()? afterCreateUpdate,
  }) async {
    await Get.dialog(
      transitionCurve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 200),
      routeSettings: RouteSettings(name: 'openSettings $label'),
      name: 'openSettings $label',

      useSafeArea: true,

      Platform.isIOS
          ? CupertinoAlertDialog(
            title: Text('Permission $label', style: TextStyle(fontSize: 20)),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              textBaseline: TextBaseline.alphabetic,
              children: [Text('$message. Please go to settings to enable $label')],
            ),

            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: ColorData.primary,
                  animationDuration: const Duration(milliseconds: 500),
                  shadowColor: ColorData.primary,
                  splashFactory: InkRipple.splashFactory,
                  surfaceTintColor: ColorData.primary,
                ),

                onPressed: () {
                  Get.back();
                  afterCreateUpdate;
                },
                child: const Text('Setting'),
              ),

              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  animationDuration: const Duration(milliseconds: 500),
                  shadowColor: Colors.red,
                  splashFactory: InkRipple.splashFactory,
                  surfaceTintColor: Colors.red,
                ),
                onPressed: Get.back,
                child: const Text('Cancel'),
              ),
            ],
          )
          : AlertDialog(
            title: Text('Permission $label', style: TextStyle(fontSize: 20)),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('$message'), Text('Please go to settings to enable $label')],
            ),
            scrollable: true,
            clipBehavior: Clip.antiAlias,
            semanticLabel: 'Open Setting $label',

            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: ColorData.primary,
                  animationDuration: const Duration(milliseconds: 500),
                  shadowColor: ColorData.primary,
                  splashFactory: InkRipple.splashFactory,
                  surfaceTintColor: ColorData.primary,
                ),

                onPressed: () {
                  Get.back();
                  afterCreateUpdate;
                },
                child: const Text('Setting'),
              ),

              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  animationDuration: const Duration(milliseconds: 500),
                  shadowColor: Colors.red,
                  splashFactory: InkRipple.splashFactory,
                  surfaceTintColor: Colors.red,
                ),
                onPressed: Get.back,
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }
}

Widget loadingBar({
  required double height,
  required double width,
  required double radius,
  Color? color,
}) {
  return CardLoading(
    cardLoadingTheme: CardLoadingTheme(
      colorOne: color ?? const Color.fromARGB(255, 240, 240, 240),
      colorTwo:
          color?.withOpacity(0.5) ?? const Color.fromARGB(255, 240, 240, 240).withOpacity(0.5),
    ),
    height: height,
    width: width,
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    margin: const EdgeInsets.only(bottom: 10),
  );
}

const kartu3 = CardLoading(height: 160);
const kartu2 = CardLoading(borderRadius: BorderRadius.all(Radius.circular(30)), height: 50);

const kartu = CardLoading(
  height: 10,
  width: 200,
  borderRadius: BorderRadius.all(Radius.circular(10)),
  margin: EdgeInsets.only(bottom: 10),
);
final kartu4 = CardLoading(
  height: 22,
  curve: Curves.decelerate,
  cardLoadingTheme: CardLoadingTheme(
    colorOne: ZFOtherColors.silver,
    colorTwo: ZFOtherColors.silver.withOpacity(0.5),
  ),
  width: MediaQuery.of(Get.context!).size.width,
  borderRadius: const BorderRadius.all(Radius.circular(25)),
  margin: const EdgeInsets.only(bottom: 10),
);
final kartuSell = CardLoading(
  height: 60,
  curve: Curves.decelerate,
  cardLoadingTheme: CardLoadingTheme(
    colorOne: ZFOtherColors.silver,
    colorTwo: ZFOtherColors.silver.withOpacity(0.5),
  ),
  width: MediaQuery.of(Get.context!).size.width,
  borderRadius: const BorderRadius.all(Radius.circular(10)),
  margin: const EdgeInsets.only(bottom: 10),
);
final kartuLingkaran = CardLoading(
  height: 40,
  curve: Curves.decelerate,
  cardLoadingTheme: CardLoadingTheme(
    colorOne: ZFOtherColors.silver,
    colorTwo: ZFOtherColors.silver.withOpacity(0.5),
  ),
  width: MediaQuery.of(Get.context!).size.width,
  borderRadius: const BorderRadius.all(Radius.circular(40)),
  margin: const EdgeInsets.only(bottom: 10),
);

Map<String, dynamic> dataDummy = {"status": false, "message": "Loading", "data": []};
Future<void> betterShowMessage({
  required context,
  required String title,
  required Widget content,
  bool? isButton,
  required bool backButton,
  List<Widget>? buttons,
  Function()? onDefaultOK,
  IconData? icon,
  Function()? onBack,
}) {
  buttons ??= [
    TextButton(
      onPressed:
          onDefaultOK ??
          () {
            Navigator.pop(context);
          },
      child: const Text('OK'),
    ),
  ];

  return showDialog(
    context: context,
    // barrierDismissible: true, // user must tap button!
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Row(
              children: [
                backButton
                    ? IconButton(onPressed: onBack, icon: Icon(icon ?? Icons.abc))
                    : Container(),
                SizedBox(
                  width: Get.width / 2,
                  child: FZText(
                    text: title,
                    maxLines: 10,
                    fontType: FontType.titleMedium,
                    weight: FontWeight.bold,
                    textAlignment: MainAxisAlignment.start,
                    // colorText: ZFOtherColors.white,
                  ),
                ),
              ],
            ),
            content: content,
            // actions: isButton == false ? null : buttons,
          );
        },
      );
    },
  );
}

String getActualPassword(String? encoded64) {
  return utf8.decode(base64.decode(encoded64!));
}

Widget buildCupertinoPrivasiSyaratdanKetentuanModal(name, text) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    body: Column(
      children: [
        FZText(
          text: name,
          maxLines: 3,
          fontType: FontType.titleMedium,
          textAlignment: MainAxisAlignment.center,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                FZText(
                  text: text,
                  maxLines: 200,
                  fontType: FontType.bodyMedium,
                  textAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
