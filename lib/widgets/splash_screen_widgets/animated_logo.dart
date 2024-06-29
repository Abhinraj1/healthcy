import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthcy/controllers/splash_controller/splash_controller.dart';
import 'package:healthcy/manager/image_manager.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.put(SplashController());
    splashController.animateLogo();
    final theme = Theme.of(context);
    return Obx(() {
      return Stack(
        children: [
          Center(
            child: AnimatedOpacity(
              opacity: splashController.opacity.value,
              duration: const Duration(
                milliseconds: 500,
              ),
              child: Image.asset(
                logo,
                width: 40.w,
              ),
            ),
          ),
          Center(
            child: AnimatedPadding(
              padding: EdgeInsets.only(left: splashController.padding.value),
              duration: const Duration(milliseconds: 500),
              child: Image.asset(
                pin,
                width: 40.w,
              ),
            ),
          ),
          Center(
            child: AnimatedOpacity(
              opacity: splashController.opacity.value,
              duration: const Duration(
                milliseconds: 500,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: Text(
                  "Fitness",
                  style: theme.textTheme.labelMedium,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
