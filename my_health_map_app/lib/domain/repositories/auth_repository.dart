import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
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
      });
  Future<void> logout();
  Future<User?> getCurrentUser();
}