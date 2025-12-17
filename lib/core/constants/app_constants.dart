class AppConstants {
  static const String appName = 'akalpit';

  // Onboarding Screen Constants
  static const List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Events and Competitions ',
      description:
          'Participate in new events or competitions near you loaction or be a part of audeience to enjoy the event.',
      imagePath: 'assets/images/onboarding1.jpg',
    ),
    OnboardingItem(
      title: 'Clubs and Councils',
      description:
          'Create a Club and manage team members. Assign tasks to your team and seek sponsorship for the new event.',
      imagePath: 'assets/images/onboarding2.jpg',
    ),
    OnboardingItem(
      title: 'Stories and memories',
      description: 'Share the unforgettable memories of your campus or clubs with your friends in the form of modern UI.',
      imagePath: 'assets/images/onboarding3.jpg',
    ),
  ];
}

class OnboardingItem {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
