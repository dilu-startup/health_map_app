import 'package:get_storage/get_storage.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;
  final GetStorage localStorage;

  AuthRepositoryImpl({
    required this.authService,
    required this.localStorage,
  });

  @override
  Future<User> login(String email, String password) async {
    try {
      final userModel = await authService.login(email, password);
      await _saveUserData(userModel);
      return userModel;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<User> signup(
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
      final userModel = await authService.signup(username, email, password);
      await _saveUserData(userModel);
      return userModel;
    } catch (e) {
      throw Exception('Signup failed: ${e.toString()}');
    }
  }

  Future<void> _saveUserData(UserModel user) async {
    await localStorage.write('user', user.toJson());
    await localStorage.write('token', user.token);
  }

  @override
  Future<void> logout() async {
    await localStorage.remove('user');
    await localStorage.remove('token');
  }

  @override
  Future<User?> getCurrentUser() async {
    final userJson = localStorage.read('user');
    if (userJson != null) {
      return UserModel.fromJson(userJson);
    }
    return null;
  }
}