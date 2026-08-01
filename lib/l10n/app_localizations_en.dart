// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ali Baziar';

  @override
  String get navHome => 'Home';

  @override
  String get navAbout => 'About';

  @override
  String get navServices => 'Services';

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
  String get heroCtaServices => 'See Services';

  @override
  String get heroCtaContact => 'Discuss Your Project';

  @override
  String get heroAvailable => 'Available for freelance projects';

  @override
  String get sectionAbout => 'About Me';

  @override
  String get sectionAboutSubtitle =>
      'Business-focused Python developer for small teams and startups';

  @override
  String get sectionServices => 'Services';

  @override
  String get sectionServicesSubtitle =>
      'Fixed-scope packages for small businesses and startups';

  @override
  String get servicesCta => 'Discuss Your Project';

  @override
  String get sectionProjects => 'Business Projects';

  @override
  String get sectionProjectsSubtitle =>
      'Real systems built for real business problems';

  @override
  String get sectionSkills => 'Technologies I Use';

  @override
  String get sectionSkillsSubtitle =>
      'The stack behind the solutions — not the selling point';

  @override
  String get sectionExperience => 'Work Experience';

  @override
  String get sectionExperienceSubtitle =>
      'Production systems delivered for real companies';

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
  String get sectionContact => 'Start a Project';

  @override
  String get sectionContactSubtitle =>
      'Tell me about your workflow problem — I reply within 24 hours';

  @override
  String get contactEmail => 'Email';

  @override
  String get contactLocation => 'Location';

  @override
  String get contactResponseTime => 'Typical response time: within 24 hours';

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
  String get footerTagline => 'Open to small projects & long-term work';

  @override
  String get viewProject => 'View Case Study';

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
  String get caseChallenge => 'The Problem';

  @override
  String get caseSolution => 'What I Built';

  @override
  String get caseResults => 'Business Value & Results';

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

  @override
  String get mobileContactFab => 'Contact';
}
