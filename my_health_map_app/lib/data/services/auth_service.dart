import 'package:dio/dio.dart';
import '../models/user_model.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<UserModel> login(String email, String password) async {
    final response = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> signup(String name, String email, String password) async {
    final response = await dio.post(
      '/auth/signup',
      data: {'name': name, 'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data);
  }
}