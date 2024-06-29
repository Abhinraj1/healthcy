import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthcy/controllers/home_controller/home_controller.dart';
import 'package:healthcy/widgets/home_screen_widgets/home_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 2.h),
          child: Obx(() {
            final isLoading = homeController.loadingData.value;
            final hasPermission = homeController.hasPermissions.value;
            final notSupported = homeController.notSupported.value;
            final stepsCount = homeController.steps.value;
            final calBurnt = homeController.calBurnt.value;
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (!hasPermission) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      notSupported
                          ? "Health Connect Not Supported"
                          : "Please allow permissions",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        homeController.retry();
                      },
                      child: Text(
                        "Retry",
                        style: theme.textTheme.titleMedium,
                      ))
                ],
              );
            }
            return ListView(
              children: [
                Text(
                  "Hi!",
                  style: theme.textTheme.titleMedium,
                ),
                // ...List.generate(
                //   homeController.healthData.length,
                //   (index) {
                //     final healthDataList = homeController.healthData.value;
                //     final HealthDataPoint HealthData = healthDataList[index];
                //     final isStep =
                //         healthDataList[index].type.toString().contains("STEPS");
                //     final data = HealthData.value.toJson()["numeric_value"];
                //     return HomeContainer(
                //       isStepsCount: isStep,
                //       data: data,
                //       goalData: isStep ? "25,000" : "27,000",
                //       goalDataAcheived: "0",
                //     );
                //   },
                // )

                HomeContainer(
                  isStepsCount: true,
                  data: stepsCount,
                  goalData: "12,000",
                  goalDataAcheived: "0",
                ),
                 HomeContainer(
                  isStepsCount: false,
                  data: calBurnt,
                  goalData: "27,000",
                  goalDataAcheived: "0",
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
