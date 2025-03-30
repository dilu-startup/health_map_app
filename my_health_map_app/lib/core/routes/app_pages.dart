import 'package:get/get.dart';

import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/signup_page.dart';


abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.SIGNUP, page: () => SignupPage()),
    // GetPage(name: Routes.HOME, page: () => HomePage()),
  ];
}

abstract class Routes {
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const HOME = '/home';
}