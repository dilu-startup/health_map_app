import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:my_health_map_app/data/repositories/auth_repository_impl.dart';
import 'package:my_health_map_app/data/services/auth_service.dart';

import '../../domain/repositories/auth_repository.dart';
import '../controllers/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetStorage());
    Get.lazyPut(() => Dio());
    Get.lazyPut(() => AuthService(Get.find<Dio>()));
    Get.lazyPut<AuthRepository>(
          () => AuthRepositoryImpl(
        authService: Get.find<AuthService>(),
        localStorage: Get.find<GetStorage>(),
      ),
    );
    Get.lazyPut(() => AuthController(Get.find<AuthRepository>())); // Add this line
  }
}