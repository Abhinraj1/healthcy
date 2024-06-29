import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashController extends GetxController {
  var opacity = 0.0.obs;
  var padding = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    _getPermission();
  }

  _getPermission() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();
  }

  animateLogo() {
    Future.delayed(const Duration(seconds:1)).then(
      (value) {
        padding.value = 22.w;
        opacity.value = 1.0;
        update();
        Future.delayed(const Duration(seconds: 3)).then(
          (value) {
            Get.toNamed("/home");
          },
        );
      },
    );
  }
}
