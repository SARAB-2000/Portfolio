// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Portfolio';

  @override
  String get navHome => 'Home';

  @override
  String get navProjects => 'Projects';

  @override
  String get navSkills => 'Skills';

  @override
  String get navExperience => 'Experience';

  @override
  String get navEducation => 'Education';

  @override
  String get navTestimonials => 'Testimonials';

  @override
  String get navContact => 'Contact';

  @override
  String get heroGreeting => 'Hello, I\'m';

  @override
  String get heroCtaProjects => 'View Projects';

  @override
  String get heroCtaContact => 'Get in Touch';

  @override
  String get heroAvailable => 'Available for work';

  @override
  String get sectionProjects => 'Selected Work';

  @override
  String get sectionProjectsSubtitle => 'Projects that showcase my craft';

  @override
  String get sectionSkills => 'Skills & Tools';

  @override
  String get sectionSkillsSubtitle => 'Technologies I work with daily';

  @override
  String get sectionExperience => 'Work Experience';

  @override
  String get sectionExperienceSubtitle => 'My professional journey';

  @override
  String get sectionEducation => 'Education';

  @override
  String get sectionEducationSubtitle => 'My academic background';

  @override
  String get educationThesisProject => 'Thesis project';

  @override
  String get sectionTestimonials => 'Testimonials';

  @override
  String get sectionTestimonialsSubtitle => 'What people say about my work';

  @override
  String get sectionContact => 'Let\'s Connect';

  @override
  String get sectionContactSubtitle => 'Reach out via email or social media';

  @override
  String get contactEmail => 'Email';

  @override
  String get contactLocation => 'Location';

  @override
  String get contactSendMessage => 'Send Message';

  @override
  String get contactNameHint => 'Your name';

  @override
  String get contactEmailHint => 'Your email';

  @override
  String get contactMessageHint => 'Your message';

  @override
  String get footerRights => 'All rights reserved.';

  @override
  String get viewProject => 'View Project';

  @override
  String get viewAllProjects => 'View All';

  @override
  String viewMoreProjects(int count) {
    return 'View $count more projects';
  }

  @override
  String get showLessProjects => 'Show less';

  @override
  String get present => 'Present';

  @override
  String get languageToggle => 'FA';

  @override
  String get themeToggleDark => 'Dark';

  @override
  String get themeToggleLight => 'Light';

  @override
  String get caseOverview => 'Overview';

  @override
  String get caseChallenge => 'The Challenge';

  @override
  String get caseSolution => 'The Solution';

  @override
  String get caseResults => 'Results & Impact';

  @override
  String get projectDetails => 'Project Details';

  @override
  String get detailRole => 'Role';

  @override
  String get detailDuration => 'Duration';

  @override
  String get detailCategory => 'Category';

  @override
  String get visitLiveSite => 'Visit Live Site';

  @override
  String get projectGallery => 'Screenshots';

  @override
  String get previousProject => 'Previous';

  @override
  String get nextProject => 'Next';

  @override
  String get skillsExploreHint => 'Explore all categories — tap a tab above';

  @override
  String skillsAlsoSee(String category) {
    return 'Also see: $category';
  }

  @override
  String skillsCount(int count) {
    return '$count skills';
  }
}
