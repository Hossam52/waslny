class OnBoardingModle {
  late final String title;
  late final String paraText;
  late final String image;
  OnBoardingModle({
    required this.title,
    required this.paraText,
    required this.image,
  });
}

List<OnBoardingModle> onboardingContents = [
  OnBoardingModle(
    title: 'Accept a JOB',
    paraText:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis tortor justo, volutpat ac lorem eget, ullamcorper sodales ante. Vivamus eleifend.',
    image: 'assets/images/onboarding.png',
  ),
  OnBoardingModle(
    title: 'Tracking RealTime',
    paraText:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis tortor justo, volutpat ac lorem eget, ullamcorper sodales ante. Vivamus eleifend2.',
    image: 'assets/images/onboarding.png',
  ),
  OnBoardingModle(
    title: 'Earn Money',
    paraText:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis tortor justo, volutpat ac lorem eget, ullamcorper sodales ante. Vivamus eleifend.3',
    image: 'assets/images/onboarding.png',
  ),
  OnBoardingModle(
    title: 'Enable Your Location',
    paraText: 'choose your location to start find the request\n around you',
    image: 'assets/images/onboarding.png',
  ),
];
