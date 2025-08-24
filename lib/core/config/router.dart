import 'routes.dart';
import 'package:get/route_manager.dart';
import '../../view/home_view.dart';
import '../../view/splash_view.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
    name: Routes.SPLASH,
    page: () => SplashView(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: Routes.HOME,
    page: () => HomeView(),
    transition: Transition.rightToLeft,
  ),
];
