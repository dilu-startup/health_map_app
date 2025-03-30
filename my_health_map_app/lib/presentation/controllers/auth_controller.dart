import 'package:get/get.dart';
import 'package:my_health_map_app/domain/entities/user.dart';
import 'package:my_health_map_app/domain/repositories/auth_repository.dart';

import '../../core/routes/app_pages.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;


  AuthController(this._authRepository);

  final Rx<User?> _user = Rx<User?>(null);
  final RxBool _isLoading = false.obs;

  User? get user => _user.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _loadCurrentUser();
    super.onInit();
  }

  Future<void> _loadCurrentUser() async {
    _user.value = await _authRepository.getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading.value = true;  // Start loading
      _user.value = await _authRepository.login(email, password);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar('Login Error', e.toString());
    } finally {
      _isLoading.value = false;  // Stop loading
    }
  }

  Future<void> signup(
      String username,
      String email,
      String password, {
        required String dateOfBirth,
        required int age,
        required String phone,
        required String bloodGroup,
        required bool isBloodDonor,
        required String address,
      }) async {
    try {
      _isLoading.value = true;
      _user.value = await _authRepository.signup(
        username,
        email,
        password,
        dateOfBirth: dateOfBirth,
        age: age,
        phone: phone,
        bloodGroup: bloodGroup,
        isBloodDonor: isBloodDonor,
        address: address,
      );
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar('Signup Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _user.value = null;
    Get.offAllNamed(Routes.LOGIN);
  }
}