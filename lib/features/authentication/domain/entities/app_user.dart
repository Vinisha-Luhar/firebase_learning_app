class AppUser{

  const AppUser({
    required this.id,
    required this.email,
    this.displayName,
    required this.emailVerified
  });

  final String id;
  final String email;
  final String? displayName;
  final bool emailVerified;
}