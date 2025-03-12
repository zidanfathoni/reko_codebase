import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reko_codebase/domain/core/api/zidanfath-projects.dart';

import '../../../domain/api_call_status.dart';
import '../../../domain/core/interfaces/zidanfath-projects-models.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  ZidanfathProjectsModels? zidanfathProjectsModels;

  final count = 0.obs;
  Key refreshKeyZidanfath = UniqueKey();
  ApiCallStatus apiCallStatusZidanfath = ApiCallStatus.loading;

  @override
  void onInit() {
    super.onInit();
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

  void getZidanfathProjects() {
    ApiZidanfathProjects apiZidanfathProjects = ApiZidanfathProjects();

    apiZidanfathProjects.get(
      onSuccess: (response) {
        print(response);

        ZidanfathProjectsModels.fromJson(response);
        zidanfathProjectsModels = ZidanfathProjectsModels.fromJson(response);
        update();

        // if response['data'] is empty
        if (zidanfathProjectsModels!.data.isEmpty) {
          apiCallStatusZidanfath = ApiCallStatus.empty;
        } else {
          apiCallStatusZidanfath = ApiCallStatus.success;
        }

        update();
      },
      onError: () {
        print('error');
      },
      apiCallStatus: apiCallStatusZidanfath,
      controller: this,
    );
  }
}
