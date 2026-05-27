enum AppRoutes {
  splash('/splash', 'Splash'),
  onboarding('/onboarding', 'Onboarding'),
  login('/login', 'Login'),
  register('/register', 'Register'),
  home('/home', 'Home'),
  scanner('/scanner', 'Scanner'),
  ar('/ar', 'Ar'),
  questTest('/quests', 'QuestTest'),
  profile('/profile', 'Profile'),
  participantEvent('/events', 'ParticipantEvent'),
  organizerEvents('/organizer/events', 'OrganizerEvents'),
  organizerQuests('/organizer/events', 'OrganizerQuests');

  const AppRoutes(this.path, this.name);

  final String path;
  final String name;
}
