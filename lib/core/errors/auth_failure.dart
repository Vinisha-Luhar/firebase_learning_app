enum AuthFailureType{
  emailAlreadyInUse,
  invalidEmail,
  weakPassword,
  userDisabled,
  userNotFound,
  wrongPassword,
  invalidCredential,
  tooManyRequests,
  network,
  operationNotAllowed,
  unknown
}

class AuthFailure implements Exception {
  const AuthFailure(this.type);
  final AuthFailureType type;
}