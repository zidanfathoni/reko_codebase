import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reko_codebase/presentation/screens.dart';

class NavigationBarController extends GetxController {
  //TODO: Implement NavigationBarController

  final count = 0.obs;
  final selectedMenu = 0.obs;
  late List<Widget> screens;
  late HomeScreen homeScreen;
  late AccountScreen accountScreen;
  @override
  void onInit() {
    super.onInit();

    homeScreen = HomeScreen();
    accountScreen = AccountScreen();

    screens = [homeScreen, accountScreen];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
