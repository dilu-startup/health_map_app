import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../presentation/bindings/auth_binding.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/signup_page.dart';
import '../constants/paths.dart';
import 'app_pages.dart';

class AppRoutes {
  static const initial = Routes.LOGIN;

  static final pages = [
    // GetPage(
    //   name: Paths.initial,
    //   page: () => SplashScreen(),
    //   binding: SplashBinding(),
    // ),
    GetPage(
      name: Paths.login,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Paths.signup,
      page: () => SignupPage(),
      binding: AuthBinding(),
    ),
    // Add other pages here
  ];
}