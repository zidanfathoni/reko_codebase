import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../function/config.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.isBack,
    this.centerTitle,
    this.actions,
    this.bottom,
  });

  final String title;
  final bool? isBack;
  final bool? centerTitle;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
          middle: CustomText(text: title, fontType: FontType.titleLarge),
          leading:
              isBack == true
                  ? CupertinoNavigationBarBackButton(
                    onPressed: () {
                      Get.back();
                    },
                  )
                  : null,
          trailing: SizedBox(
            width: 100,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: actions ?? []),
          ),
        )
        : AppBar(
          title: CustomText(text: title, fontType: FontType.titleLarge),
          bottom: bottom,
          centerTitle: centerTitle ?? true,
          leading:
              isBack == true
                  ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  )
                  : null,
          actions: actions,
        );
  }
}
