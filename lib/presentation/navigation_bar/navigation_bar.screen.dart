import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/navigation_bar.controller.dart';

class NavigationBarScreen extends GetView<NavigationBarController> {
  const NavigationBarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NavigationBarScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NavigationBarScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
