import '../entities/app_user.dart';

abstract interface class AuthRepository {
  Future<AppUser> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> sendEmailVerification();
}