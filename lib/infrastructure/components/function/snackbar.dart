import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_data.dart';

class Snackbar {
  Snackbar({Key? key}) : super();

  showSnackbar({
    required String status,
    required String message,
    required int duration,
    TextButton? button,
    String? title,
  }) {
    String titleBase = title ?? '';
    // Use this if you need best snackbar awwwwwww
    final Color success = ZFBaseColors.success;
    final Color error = ZFBaseColors.error;
    final Color info = ZFBaseColors.info;
    final Color successNoFound = ZFBaseColors.warning;
    final Color colors;
    if (status == "success") {
      colors = success;
      titleBase = 'Berhasil';
    } else if (status == "warning") {
      colors = successNoFound;
      titleBase = 'Peringatan';
    } else if (status == "info") {
      colors = info;
      titleBase = 'Informasi';
    } else {
      colors = error;
      titleBase = 'Error';
    }
    Get.snackbar(
      title ?? titleBase,
      message,
      colorText: ZFTextColors.textWhite,
      backgroundColor: colors,
      mainButton: button,
      duration: Duration(seconds: duration),
      icon: Icon(Icons.error, color: ZFTextColors.textWhite),
      animationDuration: const Duration(milliseconds: 1000),
    );
  }
}

class CustomSnackBar {
  static showCustomSnackBar({required String title, required String message, Duration? duration}) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      colorText: Colors.white,
      backgroundColor: Colors.green,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

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

  static showCustomToast({
    String? title,
    required String message,
    Color? color,
    Duration? duration,
  }) {
    Get.rawSnackbar(
      title: title,
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color ?? Colors.green,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
      message: message,
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
