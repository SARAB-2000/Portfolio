// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'علی بازیار';

  @override
  String get navHome => 'خانه';

  @override
  String get navAbout => 'درباره من';

  @override
  String get navServices => 'خدمات';

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
  String get heroCtaServices => 'مشاهده خدمات';

  @override
  String get heroCtaContact => 'شروع گفتگو';

  @override
  String get heroAvailable => 'آماده پروژه فریلنس';

  @override
  String get sectionAbout => 'درباره من';

  @override
  String get sectionAboutSubtitle =>
      'توسعه‌دهنده پایتون با نگاه کسب‌وکارمحور، برای تیم‌های کوچک و استارتاپ‌ها';

  @override
  String get sectionServices => 'خدمات';

  @override
  String get sectionServicesSubtitle =>
      'بسته‌های مشخص و قابل‌برآورد برای کسب‌وکارهای کوچک و استارتاپ‌ها';

  @override
  String get servicesCta => 'شروع گفتگو';

  @override
  String get sectionProjects => 'پروژه‌های کسب‌وکار';

  @override
  String get sectionProjectsSubtitle =>
      'سیستم‌های واقعی برای مشکلات واقعی کسب‌وکار';

  @override
  String get sectionSkills => 'تکنولوژی‌هایی که استفاده می‌کنم';

  @override
  String get sectionSkillsSubtitle => 'ابزار پشت راه‌حل — نه نقطه فروش';

  @override
  String get sectionExperience => 'سوابق کاری';

  @override
  String get sectionExperienceSubtitle =>
      'سیستم‌های عملیاتی تحویل‌شده برای شرکت‌های واقعی';

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
  String get sectionContact => 'شروع پروژه';

  @override
  String get sectionContactSubtitle =>
      'مشکل گردش کار خود را بگویید — ظرف ۲۴ ساعت پاسخ می‌دهم';

  @override
  String get contactEmail => 'ایمیل';

  @override
  String get contactLocation => 'موقعیت';

  @override
  String get contactResponseTime => 'زمان پاسخ معمول: ظرف ۲۴ ساعت';

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
  String get footerTagline => 'پذیرش پروژه‌های کوچک و همکاری بلندمدت';

  @override
  String get viewProject => 'مشاهده case study';

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
  String get caseChallenge => 'مشکل';

  @override
  String get caseSolution => 'آنچه ساختم';

  @override
  String get caseResults => 'ارزش و نتیجه کسب‌وکار';

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

  @override
  String get mobileContactFab => 'تماس';
}
