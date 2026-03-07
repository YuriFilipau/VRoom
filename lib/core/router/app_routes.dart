enum AppRoutes {
  splash('/splash', 'Splash'),
  login('/login', 'Login'),
  register('/register', 'Register'),
  home('/home', 'Home'),
  scanner('/scanner', 'Scanner'),
  profile('/profile', 'Profile');

  const AppRoutes(this.path, this.name);

  final String path;
  final String name;
}
