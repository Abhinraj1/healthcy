import 'package:get/get.dart';
import 'package:healthcy/presentation/home_screen.dart';
import 'package:healthcy/presentation/splash_screen.dart';


List<GetPage> appRoute() {
  return [
    GetPage(name: "/", page: () => const SplashScreen()),
    GetPage(name: "/home", page: () => const HomeScreen()),
  ];
}
