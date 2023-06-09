class Intro {
  final String title;
  final String? description;
  final String path;

  const Intro({required this.title, required this.path, this.description});
}

class OnboardingData {
  static List<Intro> intros = const [
    Intro(
      title: "Master English Communication",
      description:
          "Learn to speak English fluently with expert instructors and interactive courses",
      path: 'assets/speak.svg',
    ),
    Intro(
      title: "Join the English Speaking Community",
      description:
          "Connect with other English learners and practice speaking in group audio calls.",
      path: 'assets/call.svg',
    ),
    Intro(
      title: "Achieve Fluency Faster",
      description:
          "Accelerate your English language learning with personalized instruction and real-life practice.",
      path: 'assets/super_woman.svg',
    ),
  ];
}
