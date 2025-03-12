import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_data.dart';

// enum SnackPosition { TOP, BOTTOM }
enum SnackStatus { SUCCESS, ERROR, INFO, WARNING }

class Snackbar {
  Snackbar({Key? key}) : super();

  static show({
    required SnackStatus status,
    required String message,
    int? duration,
    TextButton? button,
    String? title,
    SnackPosition? position,
    SnackStyle? snackStyle,
    Function()? onTap,
    AnimationController? animationController,
  }) {
    Get.smartManagement;
    String titleBase = title ?? '';
    // Use this if you need best snackbar awwwwwww
    final Color success = ColorData.success;
    final Color error = ColorData.error;
    final Color info = ColorData.info;
    final Color successNoFound = ColorData.warning;
    final IconData icon;
    final Color colors;
    final Color textColor;
    if (status == SnackStatus.SUCCESS) {
      colors = success;
      icon = Icons.check_circle;
      titleBase = 'Berhasil';
      textColor = ZFTextColors.textWhite;
    } else if (status == SnackStatus.WARNING) {
      colors = successNoFound;
      icon = Icons.warning;
      titleBase = 'Peringatan';
      textColor = ZFTextColors.textWhite;
    } else if (status == SnackStatus.INFO) {
      colors = info;
      icon = Icons.info;
      titleBase = 'Informasi';
      textColor = ZFTextColors.textWhite;
    } else if (status == SnackStatus.ERROR) {
      colors = error;
      icon = Icons.error;
      titleBase = 'Error';
      textColor = ZFTextColors.textWhite;
    } else {
      colors = error;
      icon = Icons.error;
      titleBase = 'Error';
      textColor = ZFTextColors.textWhite;
    }

    position == SnackPosition.TOP
        ? Get.snackbar(
          title ?? titleBase,
          message,
          colorText: textColor,
          backgroundColor: colors,
          mainButton: button,
          duration: Duration(seconds: duration ?? 3),
          icon: Icon(icon, color: textColor),
          animationDuration: const Duration(milliseconds: 1000),
          dismissDirection: DismissDirection.up,
          snackStyle: snackStyle ?? SnackStyle.FLOATING,
          margin: EdgeInsets.all(snackStyle == SnackStyle.GROUNDED ? 0 : 10),
          borderRadius: snackStyle == SnackStyle.GROUNDED ? 0 : 20,
          onTap: (snack) {
            onTap != null ? onTap() : Get.closeAllSnackbars();
          },
        )
        : Get.rawSnackbar(
          title: title,
          message: message,
          showProgressIndicator: animationController != null ? true : false,
          progressIndicatorBackgroundColor: Colors.white,
          progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          progressIndicatorController: animationController,

          backgroundColor: colors,
          mainButton: button,
          duration: Duration(seconds: duration ?? 3),
          icon: Icon(icon, color: textColor),
          animationDuration: const Duration(milliseconds: 1000),
          dismissDirection: DismissDirection.down,
          snackStyle: snackStyle ?? SnackStyle.GROUNDED,
          margin: EdgeInsets.all(snackStyle == SnackStyle.FLOATING ? 10 : 0),
          borderRadius: snackStyle == SnackStyle.FLOATING ? 20 : 0,
          onTap: (snack) {
            onTap != null ? onTap() : Get.closeAllSnackbars();
          },
          //overlayBlur: 0.8,
        );
  }
}

class CustomSnackBar {
  static showCustomErrorSnackBar({
    required String title,
    required String message,
    Color? color,
    Duration? duration,
  }) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      colorText: Colors.white,
      backgroundColor: color ?? Colors.redAccent,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  static showCustomErrorToast({
    String? title,
    required String message,
    Color? color,
    Duration? duration,
  }) {
    Get.rawSnackbar(
      title: title,
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color ?? Colors.redAccent,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
      message: message,
    );
  }
}
