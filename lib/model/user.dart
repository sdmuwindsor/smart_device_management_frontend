class User {
  final String imagePath;
  final String name;
  final String email;
  final String password;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.password,
    required this.isDarkMode,
    required obscuringCharacter,
  });
}
