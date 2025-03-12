import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../infrastructure/components/function/base_data.dart';
import 'controllers/navigation_bar.controller.dart';

class NavigationBarScreen extends GetView<NavigationBarController> {
  const NavigationBarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavigationBarItems = [
      BottomNavigationBarItem(
        icon: const Icon(CupertinoIcons.home),
        label: "Home",
        backgroundColor: Colors.grey[100],
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        label: "Akun",
        backgroundColor: Colors.grey[100],
      ),
    ];

    onTap(index) {
      if (index == 0) {
        controller.selectedMenu.value = index;
      } else if (index == 1) {
        controller.selectedMenu.value = index;
      }
    }

    return Obx(
      () => Scaffold(
        bottomNavigationBar: ClipRRect(
          // borderRadius: const BorderRadius.only(
          //   topRight: Radius.circular(20),
          //   topLeft: Radius.circular(20),
          //   // bottomLeft: Radius.circular(40),
          //   // bottomRight: Radius.circular(40),
          // ),
          child:
              Platform.isIOS
                  ? CupertinoTabBar(
                    // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    items: bottomNavigationBarItems,
                    currentIndex: controller.selectedMenu.value,
                    onTap: (index) {
                      onTap(index);
                    },
                  )
                  : BottomNavigationBar(
                    elevation: 2,
                    // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    items: bottomNavigationBarItems,
                    type: BottomNavigationBarType.fixed,
                    fixedColor: ColorData.primary,
                    currentIndex: controller.selectedMenu.value,

                    selectedIconTheme: IconThemeData(color: ColorPalettes.primary),
                    unselectedIconTheme: IconThemeData(color: Colors.grey[300]),
                    onTap: (index) {
                      onTap(index);
                    },
                  ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
                  child: child,
                ),
              ),
            );
          },
          child: IndexedStack(
            key: ValueKey<int>(controller.selectedMenu.value),
            index: controller.selectedMenu.value,
            children: controller.screens,
          ),
        ),
      ),
    );
  }
}
