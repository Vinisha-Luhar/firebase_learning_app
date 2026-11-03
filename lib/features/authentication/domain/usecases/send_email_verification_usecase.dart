
import 'package:firebase_learning_app/features/authentication/domain/repositories/auth_repository.dart';

class SendEmailVerificationUsecase {

  const SendEmailVerificationUsecase(this._authRepository);
  final AuthRepository _authRepository;

  Future<void> call(){
    return _authRepository.sendEmailVerification();
  }

}