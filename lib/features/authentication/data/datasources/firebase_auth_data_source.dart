
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDataSource {

  const FirebaseAuthDataSource(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Future<User> createAccount({
    required String name,
    required String email,
    required String password
  }) async{

    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password);

    final user = credential.user;

    if(user == null){
      throw StateError("Firebase did not return a User after registration");
    }

    await user.updateDisplayName(name.trim());
    await user.reload();

    final updatedUser = _firebaseAuth.currentUser;

    if(updatedUser == null){
      throw StateError("The User profile could not be reloaded");
    }

    return updatedUser;
  }


  Future<void> sendEmailVerification() async {

    final user = _firebaseAuth.currentUser;
    if(user == null){
      throw StateError("No Authenticated User Found");
    }

    if(user.emailVerified){
      return; 
    }

    await user.sendEmailVerification();
  }

}