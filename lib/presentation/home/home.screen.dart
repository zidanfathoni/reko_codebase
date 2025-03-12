import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reko_codebase/infrastructure/components/function/helper.dart';

import '../../infrastructure/components/atom/custom_appBar.dart';
import '../../infrastructure/components/atom/custom_button.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomAppBar(
          title: 'Home Screen',
          isBack: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, size: 22),
              onPressed: () {
                Helper.showDialog(title: 'Success');
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(child: Text('HomeScreen is working', style: TextStyle(fontSize: 20))),

              CustomButton(
                title: 'Get Zidanfath Projects',
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Helper.showDialog(title: 'Success');
                },
              ),
              // Helper().refreshWidget(
              //   key: controller.refreshKeyZidanfath,
              //   onRefresh: () async {
              //     controller.getZidanfathProjects();
              //   },
              //   child: GetBuilder<HomeController>(
              //     init: HomeController(),
              //     didUpdateWidget: (oldWidget, state) {
              //       controller.getZidanfathProjects();
              //     },
              //     initState: (state) {
              //       controller.getZidanfathProjects();
              //     },

              //     builder: (controller) {
              //       return MyWidgetsAnimator(
              //         apiCallStatus: controller.apiCallStatusZidanfath,
              //         loadingWidget: () {
              //           return const Center(child: CircularProgressIndicator());
              //         },
              //         errorWidget: () {
              //           return const Center(child: Text('Error'));
              //         },
              //         successWidget: () {
              //           return ListView.builder(
              //             shrinkWrap: true,
              //             itemCount: controller.zidanfathProjectsModels!.data.length,
              //             itemBuilder: (context, index) {
              //               return ListTile(
              //                 title: Text(
              //                   controller.zidanfathProjectsModels!.data[index].attributes?.title ??
              //                       '',
              //                 ),
              //                 subtitle: Text(
              //                   controller
              //                           .zidanfathProjectsModels!
              //                           .data[index]
              //                           .attributes
              //                           ?.description ??
              //                       '',
              //                 ),
              //               );
              //             },
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
