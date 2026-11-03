
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning_app/features/authentication/data/datasources/firebase_auth_data_source.dart';
import 'package:firebase_learning_app/features/authentication/data/repositories/firebase_auth_repository_impl.dart';
import 'package:firebase_learning_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:firebase_learning_app/features/authentication/domain/usecases/send_email_verification_usecase.dart';
import 'package:firebase_learning_app/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:firebase_learning_app/features/authentication/presentation/controllers/signup_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref){
  return FirebaseAuth.instance;
});

final firebaseAuthDataSourceProvider = Provider<FirebaseAuthDataSource>((ref){
  return FirebaseAuthDataSource(ref.watch(firebaseAuthProvider));
});

final firebaseAuthRepositoryProvider = Provider<AuthRepository>((ref){
  return FirebaseAuthRepositoryImpl(ref.watch(firebaseAuthDataSourceProvider));
});

final signUpUsecaseProvider = Provider<SignupUseCase>((ref){
  return SignupUseCase(ref.watch(firebaseAuthRepositoryProvider));
});

final sendEmailVerificationUsecaseProvider = Provider<SendEmailVerificationUsecase>((ref){
  return SendEmailVerificationUsecase(ref.watch(firebaseAuthRepositoryProvider));
});

final signUpControllerProvider =
    AsyncNotifierProvider<SignupController, void>(
  SignupController.new,
);