import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning_app/core/errors/auth_failure.dart';
import 'package:firebase_learning_app/features/authentication/data/datasources/firebase_auth_data_source.dart';
import 'package:firebase_learning_app/features/authentication/domain/entities/app_user.dart';
import 'package:firebase_learning_app/features/authentication/domain/repositories/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository{

  const FirebaseAuthRepositoryImpl(this._authDataSource);
  final FirebaseAuthDataSource _authDataSource;


  @override
  Future<AppUser> signUp({required String name,required String email, required String password}) async {
    try{
      final firebaseUser = await _authDataSource.createAccount(name: name, email: email, password: password);
    return AppUser(
      id: firebaseUser.uid, 
      email: firebaseUser.email ?? email.trim(), 
      displayName: firebaseUser.displayName,
      emailVerified: firebaseUser.emailVerified,
      );
    } on FirebaseAuthException catch(error){
      throw _mapFirebaseException(error);
    }
  }

  AuthFailure _mapFirebaseException(FirebaseAuthException error){
    switch(error.code){
      case 'email-already-in-use':
      return const AuthFailure(
        AuthFailureType.emailAlreadyInUse
      );
      case 'invalid-email':
      return const AuthFailure(
        AuthFailureType.invalidEmail
      );
      case 'weak-password':
      return const AuthFailure(
        AuthFailureType.weakPassword
      );
      case 'user-disabled':
      return const AuthFailure(
        AuthFailureType.userDisabled
      );
      case 'user-not-found':
      return const AuthFailure(
        AuthFailureType.userNotFound
      );
      case 'wrong-password':
      return const AuthFailure(
        AuthFailureType.wrongPassword
      );
      case 'invalid-credential':
      return const AuthFailure(
        AuthFailureType.invalidCredential
      );
      case 'too-many-requests':
        return const AuthFailure(
          AuthFailureType.tooManyRequests,
        );

      case 'network-request-failed':
        return const AuthFailure(
          AuthFailureType.network,
        );

      case 'operation-not-allowed':
        return const AuthFailure(
          AuthFailureType.operationNotAllowed,
        );
      default:
        return const AuthFailure(
          AuthFailureType.unknown,
        );
    }

  }

  @override
  Future<void> sendEmailVerification() async{
    try{
      await _authDataSource.sendEmailVerification();
    } on FirebaseAuthException catch(error){
      throw _mapFirebaseException(error);
    }
  }

}