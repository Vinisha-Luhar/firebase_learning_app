import 'package:firebase_learning_app/features/authentication/domain/repositories/auth_repository.dart';

import '../entities/app_user.dart';

class SignupUseCase{
  const SignupUseCase(this._authRepository);
  final AuthRepository _authRepository;

  Future<AppUser> call({
    required String name,
    required String email,
    required String password
  }){
    return _authRepository.signUp(name: name.trim(), email: email.trim(), password: password);
  }
}