class AppStrings {
  // App
  static const String appTitle = 'Muhammad Moeez - Mobile App Developer';

  // Shared Labels
  static const String sectionPrefix = '## ';
  static const String subSectionPrefix = '### ';

  // Routes
  static const String routeHome = '/';
  static const String routeAbout = '/about';
  static const String routeContact = '/contact';

  // URL Fragments
  static const String fragmentWork = 'work';
  static const String fragmentServices = 'services';
  static const String fragmentContact = 'contact';

  // Section Ids
  static const String sectionIdHero = 'hero';
  static const String sectionIdProjects = 'projects';
  static const String sectionIdTrustedBy = 'trusted_by';
  static const String sectionIdAbout = 'about';
  static const String sectionIdTechStack = 'tech_stack';
  static const String sectionIdServices = 'services';
  static const String sectionIdContact = 'contact';

  // Navbar
  static const String workLink = 'Work';
  static const String aboutLink = 'About';
  static const String servicesLink = 'Services';
  static const String contactLink = 'Contact';
  static const String resumeLink = 'Resume';
  static const String resumeUrl =
      'https://www.canva.com/design/DAF1LSIbRrA/GQJJUHEX_HbZko-bHkYDOw/view?utm_content=DAF1LSIbRrA&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=h8a941f5d1f';
  static const String name = 'M Moeez';

  // Hero Section
  static const String heroTitle = 'Mobile App Developer';
  static const String heroSubTitle = 'Flutter • React Native • Android Native';
  static const String heroDescription =
      'Mobile Application Developer with 3+ years of experience building '
      'scalable apps using Flutter, React Native, and Android Native '
      '(Kotlin/Java). I specialize in clean architecture, API integrations, '
      'cross-platform delivery, and reliable kiosk systems for production '
      'workloads.';

  // Projects Section
  static const String projectsSectionTitle = 'Mobile Projects';
  static const String projectsSectionDescription =
      'Production and in-progress apps delivered across Flutter, React '
      'Native/Expo, and Android Native.';
  static const String projectsLoading = 'Loading projects...';
  static const String projectsLoadError = 'Unable to load projects right now.';
  static const String openAndroid = 'Open Android app';
  static const String openIos = 'Open iOS app';
  static const String singlePlatformTapHint = 'Tap card to open app listing';

  // Trusted By Section
  static const String trustedByTitle = 'Trusted by';
  static const List<String> trustedByCompanies = [
    'Code Upscale',
    'Skynet',
    'EvolversTech',
    'StartupX',
    'TechFlow',
  ];

  // About Section
  static const String aboutSectionTitle = 'About me';
  static const String aboutSectionDescription =
      'I am a mobile app engineer with 3+ years of hands-on experience '
      'building enterprise products and customer-facing apps. My stack '
      'includes Flutter, React Native, Kotlin, and Java, with strong focus '
      'on maintainable architecture and real-world product delivery.';
  static const List<String> aboutHighlights = [
    'Clean Architecture, MVVM, BLoC, and Riverpod',
    'API integrations with REST, Supabase, and Firebase',
    'Kiosk systems and enterprise-grade mobile workflows',
    'Domain experience in e-commerce, fitness, and logistics apps',
  ];
  static const String aboutProfileName = 'Muhammad Moeez';
  static const String aboutProfileLocation = 'Lahore, Pakistan';
  static const String aboutMoreButton = 'More about my work →';
  static const String aboutCallTitle = 'Core expertise';
  static const String aboutCallDescription =
      'From architecture planning to release management, I build reliable '
      'mobile solutions with performance, scalability, and maintainability in '
      'mind.';
  static const String aboutBookCallButton = 'Book a discovery call';

  // About Page
  static const String aboutPageHeading =
      'Engineering scalable mobile apps with clean architecture.';
  static const String aboutPageDescription =
      'I build and maintain production-ready mobile products using Flutter, '
      'React Native, Kotlin, and Java. My work covers enterprise apps, '
      'kiosk systems, logistics flows, e-commerce experiences, and fitness '
      'platforms with robust API integrations and optimized app performance.';

  // Services Section
  static const String servicesSectionTitle = 'Services';
  static const String servicesSectionDescription =
      'Mobile engineering services aligned with real production experience.';
  static const List<ServiceItem> services = [
    ServiceItem(
      title: 'Cross-Platform App Development (Flutter & React Native)',
      description:
          'Build and scale cross-platform products with strong architecture and native-level UX.',
    ),
    ServiceItem(
      title: 'Android Native Development',
      description:
          'Develop Kotlin/Java Android apps with MVVM, modular structure, and maintainable code.',
    ),
    ServiceItem(
      title: 'Enterprise & Kiosk Applications',
      description:
          'Deliver robust enterprise and kiosk systems for high-availability real-world operations.',
    ),
    ServiceItem(
      title: 'API Integration & Backend Connectivity',
      description:
          'Integrate REST APIs, Supabase, and Firebase with resilient networking and data flows.',
    ),
    ServiceItem(
      title: 'App Performance Optimization',
      description:
          'Improve startup time, runtime smoothness, memory usage, and app responsiveness.',
    ),
    ServiceItem(
      title: 'App Maintenance & Bug Fixing',
      description:
          'Stabilize existing products, resolve critical issues, and improve release confidence.',
    ),
    ServiceItem(
      title: 'App Store Deployment (Play Store & App Store)',
      description:
          'Handle release pipelines, store listing readiness, and production deployment support.',
    ),
  ];

  // Tech Stack Section
  static const String techStackTitle = 'Tech stack';
  static const String techStackDescription =
      'Categorized stack used to build and scale mobile applications.';
  static const Map<String, List<String>> techStackCategories = {
    'Mobile': ['Flutter', 'React Native', 'Android Native'],
    'Languages': ['Dart', 'Kotlin', 'Java', 'TypeScript'],
    'Architecture': ['Clean Architecture', 'MVVM', 'MVC'],
    'State Management': ['BLoC', 'Riverpod', 'Redux'],
    'Backend & APIs': ['REST', 'Dio', 'Retrofit', 'Supabase', 'Firebase'],
    'Storage': ['Hive', 'Room', 'SharedPreferences', 'MMKV'],
    'Tools': ['Git', 'GitHub', 'Copilot', 'Cursor'],
  };

  // Contact / CTA Section
  static const String contactHeading = "Let's Build Your\nMobile App";
  static const String getInTouchButton = 'Start your app project';
  static const String contactPageHeading =
      "Let's Turn Your App Idea Into Reality";
  static const String contactPageDescription =
      'Need a new mobile app, feature expansion, or architecture cleanup? '
      'I can help you plan, build, and ship with confidence.';
  static const String contactNameLabel = "What's your name?";
  static const String contactEmailLabel = 'Email';
  static const String contactBudgetLabel = 'Budget range';
  static const String budgetUnder1k = r'Under $1k';
  static const String budget1kTo5k = r'$1k - $5k';
  static const String budget5kTo10k = r'$5k - $10k';
  static const String budget10kPlus = r'$10k+';
  static const List<String> contactBudgetOptions = [
    budgetUnder1k,
    budget1kTo5k,
    budget5kTo10k,
    budget10kPlus,
  ];
  static const String contactCurrentWebsiteLabel =
      'Do you have an existing app?';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String contactHelpLabel = 'What are you building?';
  static const String requiredError = 'Required';
  static const String sendButton = 'Send inquiry';

  // Footer
  static const String copyrightText = '© 2026 — All rights reserved.';
  static const String emailAddress = 'm.moeez8910@gmail.com';
  static const String linkedInLink = 'LinkedIn';
  static const String linkedInUrl =
      'https://www.linkedin.com/in/muhammad-moeez-81aa0119b';
  static const String madeInFlutter = 'Built with Flutter';

  // Experience Section
  static const String experienceTitle = 'Experience';
  static const List<String> experienceItems = [
    'Code Upscale LLC — Flutter & React Native (Nov 2024 - Present)',
    'EvolversTech — Android Native Compose (Jun 2024 - Oct 2024)',
    'Skynet Solutionz (Pvt.) Ltd. — Android Native (Jan 2023 - Apr 2024)',
    'RNDSOL (Pvt.) Ltd. — Internship (Jan 2023 - Apr 2024)',
  ];
}

class ServiceItem {
  final String title;
  final String description;

  const ServiceItem({required this.title, required this.description});
}
