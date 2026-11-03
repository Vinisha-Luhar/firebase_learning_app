

import 'dart:async';

import 'package:firebase_learning_app/features/authentication/domain/entities/app_user.dart';
import 'package:firebase_learning_app/features/authentication/presentation/providers/auth_dependencies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupController extends AsyncNotifier<void>{

  @override
  FutureOr<void> build() {
  }

  Future<AppUser?> signUp({
    required String name,
    required String email,
    required String password
  })async {

    state = const AsyncLoading();

    try{
      final user = await ref.read(signUpUsecaseProvider)(
        name: name,
        email: email,
        password: password
      );

      await ref.read(sendEmailVerificationUsecaseProvider)();

      state = const AsyncData(null);

      return user;
    }
    catch(error, stackTrace){
      state = AsyncError(error,stackTrace);
      return null;
    }

  }

}