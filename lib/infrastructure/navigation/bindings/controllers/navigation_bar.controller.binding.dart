import 'package:get/get.dart';

import '../../../../presentation/navigation_bar/controllers/navigation_bar.controller.dart';

class NavigationBarControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationBarController>(
      () => NavigationBarController(),
    );
  }
}
