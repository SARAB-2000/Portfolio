import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navProjects;

  /// No description provided for @navSkills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get navSkills;

  /// No description provided for @navExperience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get navExperience;

  /// No description provided for @navEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get navEducation;

  /// No description provided for @navTestimonials.
  ///
  /// In en, this message translates to:
  /// **'Testimonials'**
  String get navTestimonials;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @heroGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, I\'m'**
  String get heroGreeting;

  /// No description provided for @heroCtaProjects.
  ///
  /// In en, this message translates to:
  /// **'View Projects'**
  String get heroCtaProjects;

  /// No description provided for @heroCtaContact.
  ///
  /// In en, this message translates to:
  /// **'Get in Touch'**
  String get heroCtaContact;

  /// No description provided for @heroAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available for work'**
  String get heroAvailable;

  /// No description provided for @sectionProjects.
  ///
  /// In en, this message translates to:
  /// **'Selected Work'**
  String get sectionProjects;

  /// No description provided for @sectionProjectsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Projects that showcase my craft'**
  String get sectionProjectsSubtitle;

  /// No description provided for @sectionSkills.
  ///
  /// In en, this message translates to:
  /// **'Skills & Tools'**
  String get sectionSkills;

  /// No description provided for @sectionSkillsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Technologies I work with daily'**
  String get sectionSkillsSubtitle;

  /// No description provided for @sectionExperience.
  ///
  /// In en, this message translates to:
  /// **'Work Experience'**
  String get sectionExperience;

  /// No description provided for @sectionExperienceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'My professional journey'**
  String get sectionExperienceSubtitle;

  /// No description provided for @sectionEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get sectionEducation;

  /// No description provided for @sectionEducationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'My academic background'**
  String get sectionEducationSubtitle;

  /// No description provided for @educationThesisProject.
  ///
  /// In en, this message translates to:
  /// **'Thesis project'**
  String get educationThesisProject;

  /// No description provided for @sectionTestimonials.
  ///
  /// In en, this message translates to:
  /// **'Testimonials'**
  String get sectionTestimonials;

  /// No description provided for @sectionTestimonialsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What people say about my work'**
  String get sectionTestimonialsSubtitle;

  /// No description provided for @sectionContact.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Connect'**
  String get sectionContact;

  /// No description provided for @sectionContactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reach out via email or social media'**
  String get sectionContactSubtitle;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contactEmail;

  /// No description provided for @contactLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get contactLocation;

  /// No description provided for @contactSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get contactSendMessage;

  /// No description provided for @contactNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get contactNameHint;

  /// No description provided for @contactEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Your email'**
  String get contactEmailHint;

  /// No description provided for @contactMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Your message'**
  String get contactMessageHint;

  /// No description provided for @footerRights.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved.'**
  String get footerRights;

  /// No description provided for @viewProject.
  ///
  /// In en, this message translates to:
  /// **'View Project'**
  String get viewProject;

  /// No description provided for @viewAllProjects.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAllProjects;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// No description provided for @languageToggle.
  ///
  /// In en, this message translates to:
  /// **'FA'**
  String get languageToggle;

  /// No description provided for @themeToggleDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeToggleDark;

  /// No description provided for @themeToggleLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeToggleLight;

  /// No description provided for @caseOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get caseOverview;

  /// No description provided for @caseChallenge.
  ///
  /// In en, this message translates to:
  /// **'The Challenge'**
  String get caseChallenge;

  /// No description provided for @caseSolution.
  ///
  /// In en, this message translates to:
  /// **'The Solution'**
  String get caseSolution;

  /// No description provided for @caseResults.
  ///
  /// In en, this message translates to:
  /// **'Results & Impact'**
  String get caseResults;

  /// No description provided for @projectDetails.
  ///
  /// In en, this message translates to:
  /// **'Project Details'**
  String get projectDetails;

  /// No description provided for @detailRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get detailRole;

  /// No description provided for @detailDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get detailDuration;

  /// No description provided for @detailCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get detailCategory;

  /// No description provided for @visitLiveSite.
  ///
  /// In en, this message translates to:
  /// **'Visit Live Site'**
  String get visitLiveSite;

  /// No description provided for @projectGallery.
  ///
  /// In en, this message translates to:
  /// **'Screenshots'**
  String get projectGallery;

  /// No description provided for @previousProject.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previousProject;

  /// No description provided for @nextProject.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextProject;

  /// No description provided for @skillsExploreHint.
  ///
  /// In en, this message translates to:
  /// **'Explore all categories — tap a tab above'**
  String get skillsExploreHint;

  /// No description provided for @skillsAlsoSee.
  ///
  /// In en, this message translates to:
  /// **'Also see: {category}'**
  String skillsAlsoSee(String category);

  /// No description provided for @skillsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} skills'**
  String skillsCount(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
