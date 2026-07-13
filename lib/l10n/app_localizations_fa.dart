// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'پورتفولیو';

  @override
  String get navHome => 'خانه';

  @override
  String get navProjects => 'پروژه‌ها';

  @override
  String get navSkills => 'مهارت‌ها';

  @override
  String get navExperience => 'تجربه';

  @override
  String get navEducation => 'تحصیلات';

  @override
  String get navTestimonials => 'نظرات';

  @override
  String get navContact => 'تماس';

  @override
  String get heroGreeting => 'سلام، من';

  @override
  String get heroCtaProjects => 'مشاهده پروژه‌ها';

  @override
  String get heroCtaContact => 'ارتباط با من';

  @override
  String get heroAvailable => 'آماده همکاری';

  @override
  String get sectionProjects => 'کارهای منتخب';

  @override
  String get sectionProjectsSubtitle =>
      'پروژه‌هایی که مهارت من را نشان می‌دهند';

  @override
  String get sectionSkills => 'مهارت‌ها و ابزارها';

  @override
  String get sectionSkillsSubtitle =>
      'تکنولوژی‌هایی که هر روز با آن‌ها کار می‌کنم';

  @override
  String get sectionExperience => 'سوابق کاری';

  @override
  String get sectionExperienceSubtitle => 'مسیر حرفه‌ای من';

  @override
  String get sectionEducation => 'تحصیلات';

  @override
  String get sectionEducationSubtitle => 'سوابق تحصیلی من';

  @override
  String get educationThesisProject => 'پروژه پایان‌نامه';

  @override
  String get sectionTestimonials => 'نظرات';

  @override
  String get sectionTestimonialsSubtitle =>
      'آنچه دیگران درباره کار من می‌گویند';

  @override
  String get sectionContact => 'بیایید در ارتباط باشیم';

  @override
  String get sectionContactSubtitle =>
      'از طریق ایمیل یا شبکه‌های اجتماعی در ارتباط باشید';

  @override
  String get contactEmail => 'ایمیل';

  @override
  String get contactLocation => 'موقعیت';

  @override
  String get contactSendMessage => 'ارسال پیام';

  @override
  String get contactNameHint => 'نام شما';

  @override
  String get contactEmailHint => 'ایمیل شما';

  @override
  String get contactMessageHint => 'پیام شما';

  @override
  String get footerRights => 'تمامی حقوق محفوظ است.';

  @override
  String get viewProject => 'مشاهده پروژه';

  @override
  String get viewAllProjects => 'مشاهده همه';

  @override
  String viewMoreProjects(int count) {
    return 'مشاهده $count پروژه دیگر';
  }

  @override
  String get showLessProjects => 'نمایش کمتر';

  @override
  String get present => 'اکنون';

  @override
  String get languageToggle => 'EN';

  @override
  String get themeToggleDark => 'تیره';

  @override
  String get themeToggleLight => 'روشن';

  @override
  String get caseOverview => 'نمای کلی';

  @override
  String get caseChallenge => 'چالش';

  @override
  String get caseSolution => 'راه‌حل';

  @override
  String get caseResults => 'نتایج و تأثیر';

  @override
  String get projectDetails => 'جزئیات پروژه';

  @override
  String get detailRole => 'نقش';

  @override
  String get detailDuration => 'مدت';

  @override
  String get detailCategory => 'دسته';

  @override
  String get visitLiveSite => 'مشاهده سایت';

  @override
  String get projectGallery => 'تصاویر';

  @override
  String get previousProject => 'قبلی';

  @override
  String get nextProject => 'بعدی';

  @override
  String get skillsExploreHint => 'همه دسته‌ها را ببین — روی تب‌ها بزن';

  @override
  String skillsAlsoSee(String category) {
    return 'ببین: $category';
  }

  @override
  String skillsCount(int count) {
    return '$count مهارت';
  }
}
