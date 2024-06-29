import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:healthcy/controllers/theme_controller/theme_controller.dart';
import 'package:healthcy/manager/route_manager.dart';
import 'package:healthcy/manager/theme_manager.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemesController themeController = Get.put(ThemesController());
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: 'Health app',
        getPages: appRoute(),
        initialRoute: "/",
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: ThemeMode.system,
        // home: const HomeScreen(),
      );
    });
  }
}
