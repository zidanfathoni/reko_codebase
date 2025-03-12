import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'infrastructure/components/atom/Custom_errorBuilder.dart';
import 'infrastructure/config/shared_pref_helper/shared_pref_helper.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'infrastructure/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initialRoute = await Routes.initialRoute;
  //init shared pref
  await MySharedPref.init();
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.config(
      enableLog: true,
      defaultTransition: Transition.fadeIn,
      defaultPopGesture: true,
      defaultDurationTransition: const Duration(milliseconds: 300),
      defaultGlobalState: true,
    );
    return ScreenUtilInit(
      // todo add your (Xd / Figma) artboard size
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      ensureScreenSize: false,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
          // todo add your app name
          title: "Receh Koding",
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(
            builder: (BuildContext context, Widget? widget) {
              bool themeIsLight = MySharedPref.getThemeIsLight();
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                return CustomErrorBuilder(errorDetails: errorDetails);
              };
              return Theme(
                data: themeIsLight ? RkTheme.light : RkTheme.dark,
                child: MediaQuery(
                  // prevent font from scalling (some people use big/small device fonts)
                  // but we want our app font to still the same and dont get affected
                  data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: widget!,
                ),
              );
            },
          ),
          initialRoute: initialRoute,
          getPages: Nav.routes,
          smartManagement: SmartManagement.full,
          opaqueRoute: Get.isOpaqueRouteDefault,
          popGesture: Get.isPopGestureEnable,
          defaultTransition: Get.defaultTransition,
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
          },
        );
      },
    );
  }
}
