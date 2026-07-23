import 'package:flutter/material.dart';

import 'localized_text.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  EDIT YOUR CONTENT HERE — all bilingual fields use L('English', 'فارسی')
// ─────────────────────────────────────────────────────────────────────────────

class PortfolioProfile {
  const PortfolioProfile({
    required this.name,
    required this.role,
    required this.tagline,
    required this.bio,
    required this.email,
    required this.location,
    required this.avatarAsset,
    required this.avatarUrl,
    required this.socialLinks,
  });

  final String name;
  final L role;
  final L tagline;
  final L bio;
  final String email;
  final L location;
  /// Local asset path, e.g. 'assets/images/profile.png'
  final String avatarAsset;
  /// Network URL fallback if asset is empty or missing
  final String avatarUrl;
  final List<SocialLink> socialLinks;
}

class SocialLink {
  const SocialLink({
    required this.label,
    required this.url,
    required this.icon,
  });

  final String label;
  final String url;
  final IconData icon;
}

class HeroStatItem {
  const HeroStatItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  final int value;
  final L label;
  final IconData icon;
}

class ProjectItem {
  const ProjectItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.color,
    required this.url,
    required this.overview,
    required this.challenge,
    required this.solution,
    required this.results,
    required this.myRole,
    required this.duration,
    this.imageAsset = '',
    this.galleryAssets = const [],
    this.isFeatured = false,
    this.portraitCover = false,
  });

  final String id;
  final L title;
  final L description;
  final L category;
  final List<String> tags;
  final Color color;
  final String url;
  final L overview;
  final L challenge;
  final L solution;
  final L results;
  final L myRole;
  final L duration;
  final String imageAsset;
  final List<String> galleryAssets;
  final bool isFeatured;
  /// Use for mobile/portrait screenshots — shows full image with letterboxing.
  final bool portraitCover;

  bool get hasLiveSite => url.trim().isNotEmpty;

  /// Cover image first, then gallery — deduplicated.
  List<String> get allImageAssets {
    final images = <String>[];
    if (imageAsset.isNotEmpty) images.add(imageAsset);
    for (final asset in galleryAssets) {
      if (asset.isNotEmpty && !images.contains(asset)) {
        images.add(asset);
      }
    }
    return images;
  }
}

class SkillGroup {
  const SkillGroup({
    required this.title,
    required this.skills,
  });

  final L title;
  final List<SkillItem> skills;
}

class SkillItem {
  const SkillItem({required this.name});

  final String name;
}

class ExperienceItem {
  const ExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    required this.isCurrent,
    this.relatedProjectIds = const [],
    this.websiteUrl,
  });

  final String company;
  final L role;
  final L period;
  final L description;
  final bool isCurrent;
  /// Project IDs from [PortfolioData.projects] — shown as tappable links in the UI.
  final List<String> relatedProjectIds;
  /// Optional company or product website (e.g. cipherland.ir).
  final String? websiteUrl;
}

class EducationItem {
  const EducationItem({
    required this.institution,
    required this.degree,
    required this.period,
    required this.description,
    this.relatedProjectIds = const [],
  });

  final String institution;
  final L degree;
  final L period;
  final L description;
  final List<String> relatedProjectIds;
}

class TestimonialItem {
  const TestimonialItem({
    required this.name,
    required this.role,
    required this.quote,
    required this.avatarInitials,
  });

  final String name;
  final L role;
  final L quote;
  final String avatarInitials;
}

class PortfolioData {
  static const profile = PortfolioProfile(
    name: 'Ali Baziar',
    role: L('Full-Stack Developer', 'توسعه‌دهنده فول‌استک'),
    tagline: L(
      'I build scalable web and mobile apps — from Django backends to Flutter & React frontends.',
      'اپلیکیشن‌های وب و موبایل مقیاس‌پذیر می‌سازم — از بک‌اند Django تا فرانت Flutter و React.',
    ),
    bio: L(
      'Passionate full-stack developer with experience building web and mobile applications using Python, Django, Flutter, and React. I enjoy turning complex problems into simple, elegant solutions — with clean code and user-centered design.',
      'توسعه‌دهنده فول‌استک با تجربه ساخت اپلیکیشن وب و موبایل با Python، Django، Flutter و React. از تبدیل مسائل پیچیده به راه‌حل‌های ساده و زیبا لذت می‌برم — با کد تمیز و طراحی کاربرمحور.',
    ),
    email: 'alibaziar1378@gmail.com',
    location: L('Iran', 'ایران'),
    avatarAsset: 'assets/images/profile.png',
    avatarUrl: '',
    socialLinks: [
      SocialLink(
        label: 'GitHub',
        url: 'https://github.com/sarab-2000',
        icon: Icons.code,
      ),
      SocialLink(
        label: 'LinkedIn',
        url: 'https://www.linkedin.com/in/ali-baziar-757697180/',
        icon: Icons.work_outline,
      ),
    ],
  );

  static const heroStats = [
    HeroStatItem(
      value: 7,
      label: L('Years Experience', 'سال تجربه'),
      icon: Icons.work_history_rounded,
    ),
    HeroStatItem(
      value: 13,
      label: L('Projects Completed', 'پروژه انجام‌شده'),
      icon: Icons.rocket_launch_rounded,
    ),
  ];

  static ProjectItem? projectById(String id) {
    try {
      return projects.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  static const projects = [
    ProjectItem(
      id: 'product-tracking',
      title: L('Product Tracking System', 'سامانه رهگیری محصولات'),
      description: L(
        'End-to-end barcode tracking from production line to warehouse, distribution, and returns — with full analytics.',
        'رهگیری end-to-end بارکد از خط تولید تا انبار، توزیع و مرجوعی — با آمارگیری کامل.',
      ),
      category: L('Enterprise Web App', 'سامانه وب سازمانی'),
      tags: ['Django', 'Redis', 'Celery', 'MySQL'],
      color: Color(0xFF0D9488),
      url: '',
      overview: L(
        'A comprehensive product traceability platform for manufacturing operations. The system generates unique 2D barcodes for each product unit based on product type and attributes, sends them to industrial Jet Printers for on-product labeling, and uses camera scanning on the production line. When the configured number of units per carton is reached, it automatically generates a unique master carton barcode and sends it to a label printer. Warehouse, distribution, and returns departments update product status by scanning these barcodes, with full reporting and analytics built in.',
        'پلتفرم جامع ردیابی محصول برای عملیات تولید. برای هر واحد محصول بر اساس نوع و مشخصات، بارکد دوبعدی یونیک تولید می‌کند و به Jet Printer صنعتی برای چاپ روی محصول ارسال می‌کند. با اسکن دوربین در خط تولید، وقتی به تعداد تعریف‌شده در هر کارتن رسید، بارکد مادر یونیک کارتن ساخته و به label printer داده می‌شود. بخش‌های انبار، توزیع و مرجوعی با اسکن بارکدها وضعیت را به‌روز می‌کنند و گزارش‌گیری و آمار کامل در دسترس است.',
      ),
      challenge: L(
        'Tracking products manually across production, packaging, warehouse, distribution, and returns caused labeling errors, lost inventory visibility, and no single source of truth for product status.',
        'رهگیری دستی محصول در تولید، بسته‌بندی، انبار، توزیع و مرجوعی باعث خطای لیبل، از دست رفتن دید موجودی و نبود منبع واحد برای وضعیت محصول می‌شد.',
      ),
      solution: L(
        'Built with Django, Redis, Celery, and MySQL — dynamic QR/barcode generation rules per product type, Jet Printer and label printer integrations, camera-based scanning workflows, automatic master carton barcode creation when unit count per carton is met, and status management modules for warehouse, distribution, and returns with comprehensive analytics dashboards.',
        'با Django، Redis، Celery و MySQL — قوانین پویا برای تولید QR/بارکد بر اساس نوع محصول، اتصال Jet Printer و label printer، گردش کار اسکن با دوربین، ساخت خودکار بارکد مادر کارتن در رسیدن به تعداد واحد، و ماژول‌های وضعیت برای انبار، توزیع و مرجوعی همراه داشبورد آمار.',
      ),
      results: L(
        'Full traceability from production to returns, automated unit and carton labeling, real-time status updates across departments, and complete reporting for operational decisions.',
        'ردیابی کامل از تولید تا مرجوعی، لیبل‌گذاری خودکار واحد و کارتن، به‌روزرسانی لحظه‌ای وضعیت بین بخش‌ها، و گزارش‌گیری کامل برای تصمیم‌گیری عملیاتی.',
      ),
      myRole: L('Full-Stack Developer', 'توسعه‌دهنده فول‌استک'),
      duration: L('Production system', 'سیستم عملیاتی'),
      imageAsset: 'assets/images/projects/tracking1.jpg',
      galleryAssets: [
        'assets/images/projects/tracking2.jpg',
        'assets/images/projects/tracking3.jpg',
        'assets/images/projects/tracking4.jpg',
      ],
      isFeatured: true,
    ),
    ProjectItem(
      id: 'ai-language-learning',
      title: L('AI Language Learning Platform', 'پلتفرم یادگیری زبان با هوش مصنوعی'),
      description: L(
        'Django backend for an AI-powered language learning app — custom courses, chat assistants, and creator monetization.',
        'بک‌اند Django برای اپ یادگیری زبان با AI — دوره سفارشی، دستیار چت و درآمدزایی برای سازندگان.',
      ),
      category: L('EdTech Platform', 'پلتفرم آموزشی'),
      tags: ['Django', 'AI APIs', 'REST API', 'MySQL'],
      color: Color(0xFF6366F1),
      url: '',
      overview: L(
        'Backend platform for an AI-driven language learning application. Users can create structured language courses — comprehensive programs, grammar, reading, and more — and attach intelligent assistants to each course. Assistant bots answer learner questions via chat about course content, while specialized teaching bots can drill vocabulary, grammar, and other skills. Other users discover and enroll in published courses and bots. The platform includes a monetization system so course and bot creators can earn revenue from their content.',
        'بک‌اند پلتفرم اپ یادگیری زبان مبتنی بر هوش مصنوعی. کاربران دوره‌های ساختاریافته می‌سازند — دوره جامع، گرامر، ریدینگ و ... — و به هر دوره دستیار هوشمند تعیین می‌کنند. ربات دستیار در قالب چت به سوالات یادگیرندگان درباره محتوای دوره پاسخ می‌دهد؛ ربات‌های آموزشی هم برای کار روی لغات، گرامر و مهارت‌های دیگر ساخته می‌شوند. سایر کاربران دوره‌ها و ربات‌ها را کشف و استفاده می‌کنند. سیستم درآمدزایی برای سازندگان دوره و ربات هم پیاده‌سازی شده است.',
      ),
      challenge: L(
        'Language learners needed personalized, interactive content beyond static lessons — and educators lacked a platform to build, share, and monetize AI-enhanced courses without building everything from scratch.',
        'زبان‌آموزان به محتوای تعاملی و شخصی‌سازی‌شده فراتر از درس‌های ثابت نیاز داشتند — و مدرسان پلتفرمی برای ساخت، اشتراک و درآمدزایی از دوره‌های AI-enhanced بدون ساخت همه‌چیز از صفر نداشتند.',
      ),
      solution: L(
        'Built the backend with Django and integrated AI APIs for conversational assistants and teaching bots. Implemented course creation workflows (comprehensive, grammar, reading, etc.), per-course chat assistants, specialized bots for vocabulary and grammar practice, user enrollment, and a creator monetization engine — enabling a marketplace-style learning ecosystem.',
        'بک‌اند با Django و یکپارچه‌سازی AI API برای دستیار مکالمه‌ای و ربات‌های آموزشی. گردش کار ساخت دوره (جامع، گرامر، ریدینگ و ...)، دستیار چت برای هر دوره، ربات‌های تخصصی لغت و گرامر، ثبت‌نام کاربران و موتور درآمدزایی سازندگان — اکوسیستم یادگیری شبیه marketplace.',
      ),
      results: L(
        'Creators can publish courses and bots, learners get AI-powered interactive tutoring, and the monetization layer supports sustainable content creation on the platform.',
        'سازندگان دوره و ربات منتشر می‌کنند، یادگیرندگان آموزش تعاملی با AI می‌گیرند و لایه درآمدزایی خلق محتوای پایدار را پشتیبانی می‌کند.',
      ),
      myRole: L('Backend Developer', 'توسعه‌دهنده بک‌اند'),
      duration: L('Multi-phase', 'چند فازی'),
      imageAsset: 'assets/images/projects/talkook1.png',
      galleryAssets: [
        'assets/images/projects/talkook2.png',
        'assets/images/projects/talkook3.png',
        'assets/images/projects/talkook4.png',
      ],
      isFeatured: true,
    ),
    ProjectItem(
      id: 'supishi-mission-forms',
      title: L('Supishi — Mission Form Digitization', 'Supishi — الکترونیکی‌سازی فرم مأموریت'),
      description: L(
        'Django web platform digitizing field mission forms — multi-step approval workflow with SMS notifications and full reporting.',
        'پلتفرم وب Django برای دیجیتالی‌سازی فرم مأموریت — گردش تأیید چندمرحله‌ای با SMS و گزارش‌گیری کامل.',
      ),
      category: L('Business Web App', 'سامانه وب سازمانی'),
      tags: ['Django', 'SMS API', 'Workflow', 'Reporting'],
      color: Color(0xFF8B5CF6),
      url: 'https://supishi.net',
      overview: L(
        'A Django-powered web platform that replaces paper-based mission forms for field operations. When company staff go on missions and inspect client equipment, they fill out digital forms for each device and submit them. An SMS is automatically sent to the client company manager with the form details for review and approval. Once approved, the form moves to the support manager to register and confirm costs. Finally, the department manager reviews all information and, if correct, gives final approval and archives the form. The system includes comprehensive reporting on forms, missions, companies, submitters, and more.',
        'پلتفرم وب Django که فرم‌های کاغذی مأموریت را در عملیات میدانی جایگزین می‌کند. وقتی نیروهای شرکت مأموریت می‌روند و تجهیزات مشتری را بازدید می‌کنند، فرم دیجیتال برای هر دستگاه پر و ثبت می‌کنند. پیامک خودکار به مسئول شرکت مشتری با جزئیات فرم ارسال می‌شود تا بخواند و تأیید کند. پس از تأیید، فرم به مسئول پشتیبانی می‌رود تا هزینه‌ها را ثبت و تأیید کند. در نهایت مدیر بخش همه اطلاعات را بررسی و در صورت صحت، تأیید نهایی و بایگانی می‌کند. گزارش‌گیری کامل از فرم‌ها، مأموریت‌ها، شرکت‌ها، ثبت‌کنندگان و ... وجود دارد.',
      ),
      challenge: L(
        'Paper mission forms caused delays, lost documents, no audit trail, and a slow multi-party approval chain between field staff, client managers, support, and department heads.',
        'فرم‌های کاغذی مأموریت باعث تأخیر، گم شدن مدارک، نبود audit trail و زنجیره تأیید کند بین نیروی میدانی، مدیر مشتری، پشتیبانی و مدیر بخش می‌شد.',
      ),
      solution: L(
        'Built with Django — digital form submission per device during missions, automated SMS notifications to client managers, staged approval workflow (client → support costs → department manager → archive), role-based access, and rich reporting dashboards filtered by forms, missions, companies, and staff.',
        'با Django — ثبت فرم دیجیتال برای هر دستگاه در مأموریت، اعلان SMS خودکار به مدیر مشتری، گردش تأیید مرحله‌ای (مشتری ← هزینه پشتیبانی ← مدیر بخش ← بایگانی)، دسترسی نقش‌محور و داشبورد گزارش بر اساس فرم، مأموریت، شرکت و پرسنل.',
      ),
      results: L(
        'Paperless mission documentation, faster approvals via SMS-triggered client sign-off, traceable workflow at every stage, and complete analytics for operations management.',
        'مستندسازی بدون کاغذ مأموریت، تأیید سریع‌تر با SMS مشتری، گردش کار قابل ردیابی در هر مرحله، و آمار کامل برای مدیریت عملیات.',
      ),
      myRole: L('Full-Stack Developer', 'توسعه‌دهنده فول‌استک'),
      duration: L('Production system', 'سیستم عملیاتی'),
      imageAsset: 'assets/images/projects/supishi1.png',
      galleryAssets: [
        'assets/images/projects/supishi2.png',
        'assets/images/projects/supishi3.png',
        'assets/images/projects/supishi4.png',
      ],
      isFeatured: true,
    ),
    ProjectItem(
      id: 'developer-portfolio',
      title: L('Developer Portfolio Website', 'وب‌سایت پورتفولیو شخصی'),
      description: L(
        'Bilingual Flutter web portfolio — project case studies, skills, experience, education, and contact in EN/FA with RTL support.',
        'پورتفولیو وب Flutter دوزبانه — case study پروژه‌ها، مهارت‌ها، تجربه، تحصیلات و تماس به فارسی و انگلیسی با پشتیبانی RTL.',
      ),
      category: L('Personal Web App', 'وب‌اپ شخصی'),
      tags: ['Flutter', 'Web', 'RTL', 'i18n', 'Provider'],
      color: Color(0xFF6366F1),
      url: '',
      overview: L(
        'A dynamic single-page developer portfolio built with Flutter for web. Showcases selected projects with full bilingual case study pages, grouped skills with brand icons, work experience and education timelines, and contact channels — all with smooth animations, dark/light theme toggle, and a developer-themed background. Deploy-ready for GitHub Pages and Firebase Hosting.',
        'پورتفولیو تک‌صفحه‌ای پویا با Flutter برای وب. نمایش پروژه‌های منتخب با صفحات case study دوزبانه، مهارت‌های گروه‌بندی‌شده با آیکون برند، timeline تجربه و تحصیلات، و راه‌های ارتباطی — همراه انیمیشن‌های روان، تم روشن/تیره و پس‌زمینه تم برنامه‌نویسی. آماده deploy روی GitHub Pages و Firebase Hosting.',
      ),
      challenge: L(
        'Needed a professional online presence that presents projects in depth, supports both English and Persian audiences, and clearly communicates full-stack skills — without relying on a generic template site builder.',
        'نیاز به حضور آنلاین حرفه‌ای برای نمایش عمیق پروژه‌ها، پشتیبانی از مخاطب فارسی و انگلیسی، و انتقال شفاف مهارت‌های فول‌استک — بدون وابستگی به سایت‌سازهای آماده.',
      ),
      solution: L(
        'Built with Flutter — modular section architecture, ARB-based localization with RTL layout, Provider for theme/locale state, routed project detail screens, Simple Icons CDN for skill branding, animated hero and skills UI, and CI deploy configs for GitHub Pages and Firebase.',
        'با Flutter — معماری ماژولار بخش‌ها، localization مبتنی بر ARB با layout RTL، Provider برای تم/زبان، صفحات جزئیات پروژه با routing، CDN Simple Icons برای برند مهارت‌ها، UI انیمیشن‌دار hero و skills، و تنظیمات CI برای GitHub Pages و Firebase.',
      ),
      results: L(
        'A polished, maintainable portfolio where all content lives in one editable data file — bilingual, responsive, and unmistakably built by a developer.',
        'پورتفولیوی حرفه‌ای و قابل نگهداری که تمام محتوا در یک فایل داده قابل ویرایش است — دوزبانه، واکنش‌گرا و کاملاً مشخص به‌عنوان خروجی یک برنامه‌نویس.',
      ),
      myRole: L('Full-Stack Developer & Designer', 'توسعه‌دهنده فول‌استک و طراح'),
      duration: L('Personal project', 'پروژه شخصی'),
      imageAsset: 'assets/images/projects/portfolio.png',
      isFeatured: true,
    ),
    ProjectItem(
      id: 'warehouse-management',
      title: L('Warehouse Management System', 'سامانه مدیریت انبار'),
      description: L(
        'Django REST API + Electron desktop app for multi-warehouse inventory — role-based access, barcode/Excel intake, and rich reporting.',
        'REST API جنگو + اپ دسکتاپ Electron برای موجودی چندانباره — دسترسی نقش‌محور، ورود با بارکد/اکسل و گزارش‌گیری.',
      ),
      category: L('Inventory System', 'سامانه انبارداری'),
      tags: ['Django', 'REST API', 'Electron.js', 'MySQL'],
      color: Color(0xFF059669),
      url: '',
      overview: L(
        'A full-stack warehouse management platform built with Django REST API and an Electron.js desktop client. The system supports multiple access levels, each with dedicated permissions. Users can add products to warehouses individually, via unique barcodes, or by uploading Excel files. Outbound operations — delivery to field experts or direct delivery to customers — and product returns are fully tracked. Administrators can set limits on the number of users and warehouses per account. Comprehensive reports include current stock levels, inbound/outbound activity within custom date ranges, and more.',
        'پلتفرم full-stack مدیریت انبار با Django REST API و کلاینت دسکتاپ Electron.js. سطح دسترسی‌های مختلف با مجوزهای اختصاصی. ورود محصول به انبار به صورت تکی، با بارکد یونیک، یا آپلود فایل Excel. ثبت خروج (تحویل به کارشناس یا مشتری) و مرجوعی. محدودیت تعداد کاربر و تعداد انبار قابل تنظیم است. گزارش‌ها: موجودی فعلی، ورود/خروج در بازه زمانی و موارد دیگر.',
      ),
      challenge: L(
        'Manual warehouse tracking with spreadsheets led to stock discrepancies, no barcode support, unclear permissions across teams, and no unified view of inbound, outbound, and return flows.',
        'ردیابی دستی انبار با Excel باعث مغایرت موجودی، نبود پشتیبانی بارکد، مجوزهای نامشخص بین تیم‌ها و نبود دید یکپارچه از ورود، خروج و مرجوعی می‌شد.',
      ),
      solution: L(
        'Developed Django REST API with granular role-based access control, Electron desktop UI for daily operations, triple product intake modes (manual, barcode scan, Excel bulk import), outbound workflows for expert and customer delivery, return registration, configurable user/warehouse quotas, and flexible reporting by stock, time range, and movement type.',
        'REST API جنگو با کنترل دسترسی نقش‌محور دقیق، UI دسکتاپ Electron برای عملیات روزانه، سه روش ورود (دستی، اسکن بارکد، import اکسل)، گردش خروج به کارشناس و مشتری، ثبت مرجوعی، سقف کاربر/انبار قابل تنظیم، و گزارش‌گیری انعطاف‌پذیر بر اساس موجودی، بازه زمانی و نوع حرکت.',
      ),
      results: L(
        'Accurate real-time inventory across multiple warehouses, faster intake with barcode and Excel, controlled access per role, and actionable reports for stock and movement analysis.',
        'موجودی لحظه‌ای دقیق در چند انبار، ورود سریع‌تر با بارکد و Excel، دسترسی کنترل‌شده بر اساس نقش، و گزارش‌های عملیاتی برای تحلیل موجودی و گردش کالا.',
      ),
      myRole: L('Full-Stack Developer', 'توسعه‌دهنده فول‌استک'),
      duration: L('Multi-phase', 'چند فازی'),
      imageAsset: 'assets/images/projects/warehouse1.png',
      galleryAssets: [
        'assets/images/projects/warehouse2.png',
        'assets/images/projects/warehouse3.png',
        'assets/images/projects/warehouse4.png',
        'assets/images/projects/warehouse5.png',
        'assets/images/projects/warehouse6.png',
      ],
      isFeatured: false,
    ),
    ProjectItem(
      id: 'rummy-dice-game',
      title: L('RamODis — Digital Board Game', 'بازی رام و دیس — پیاده‌سازی دیجیتال'),
      description: L(
        'Flutter implementation of RamODis — standalone local multiplayer or online play via Django REST Framework backend.',
        'پیاده‌سازی Flutter بازی رام و دیس — multiplayer محلی standalone یا آنلاین با بک‌اند Django REST Framework.',
      ),
      category: L('Mobile Game', 'بازی موبایل'),
      tags: ['Flutter', 'Django REST', 'Local Network', 'Multiplayer'],
      color: Color(0xFFF59E0B),
      url: '',
      overview: L(
        'A digital adaptation of RamODis, delivered in two architectures. Version 1 is fully built with Flutter — players can compete against an AI bot or friends over a local network. Version 2 uses Flutter for the frontend and Django REST Framework for the backend, enabling bot matches and friend-vs-friend games over a wider network beyond local LAN. Both versions preserve core game rules while adding smooth UI, turn management, and real-time multiplayer sync.',
        'نسخه دیجیتال بازی کلاسیک رام و دیس در دو معماری. نسخه ۱ کاملاً Flutter — بازی با ربات AI یا دوستان روی شبکه محلی. نسخه ۲ فرانت Flutter و بک‌اند Django REST Framework — بازی با ربات و دوستان روی شبکه گسترده‌تر از LAN. هر دو نسخه قوانین اصلی بازی را حفظ و UI روان، مدیریت نوبت و همگام‌سازی multiplayer را اضافه می‌کنند.',
      ),
      challenge: L(
        'The traditional board game needed a digital version that feels natural on mobile — with reliable multiplayer whether players are in the same room (local) or connecting remotely (online).',
        'بازی سنتی به نسخه دیجیتال طبیعی روی موبایل نیاز داشت — با multiplayer پایدار چه در یک اتاق (محلی) و چه از راه دور (آنلاین).',
      ),
      solution: L(
        'Built Version 1 entirely in Flutter with local network discovery for nearby friends and an AI bot opponent. Built Version 2 with Flutter client + Django DRF backend for scalable online matchmaking, game state sync, and remote friend play — giving users flexibility between offline-local and cloud-connected modes.',
        'نسخه ۱ کاملاً Flutter با کشف شبکه محلی برای دوستان نزدیک و ربات AI. نسخه ۲ کلاینت Flutter + Django DRF برای matchmaking آنلاین، همگام‌سازی state بازی و بازی از راه دور — انعطاف بین حالت محلی offline و متصل به cloud.',
      ),
      results: L(
        'Two production-ready game modes — quick local sessions with friends and scalable online play — bringing a beloved board game to mobile with modern UX.',
        'دو حالت بازی آماده — جلسات سریع محلی با دوستان و بازی آنلاین مقیاس‌پذیر — آوردن بازی محبوب به موبایل با UX مدرن.',
      ),
      myRole: L('Game Developer', 'توسعه‌دهنده بازی'),
      duration: L('Multi-phase', 'چند فازی'),
      imageAsset: 'assets/images/projects/ramodis1.png',
      galleryAssets: [
        'assets/images/projects/ramodis2.png',
        'assets/images/projects/ramodis3.png',
        'assets/images/projects/ramodis4.png',
      ],
      portraitCover: true,
      isFeatured: true,
    ),
    ProjectItem(
      id: 'flutter-music-player',
      title: L('Flutter Music Player', 'موزیک پلیر Flutter'),
      description: L(
        'Local music player for mobile — smart filtering, playlists, favorites, shuffle, and built-in equalizer.',
        'پخش‌کننده موسیقی محلی موبایل — فیلتر هوشمند، پلی‌لیست، علاقه‌مندی، shuffle و اکولایزر.',
      ),
      category: L('Mobile App', 'اپ موبایل'),
      tags: ['Flutter', 'Audio', 'Local Storage', 'Media'],
      color: Color(0xFFEC4899),
      url: '',
      overview: L(
        'A Flutter music player that scans and lists all songs on the device, sortable by date or name. Users can play tracks sequentially or in shuffle mode. Configurable filters exclude songs shorter than a set duration or below a minimum file size from the library and playback. Full playlist creation, favorite marking, and a built-in equalizer for custom audio tuning round out the experience.',
        'موزیک پلیر Flutter که آهنگ‌های دستگاه را اسکن و لیست می‌کند — مرتب‌سازی بر اساس زمان یا نام. پخش ترتیبی یا تصادفی (shuffle). فیلتر قابل تنظیم: حذف آهنگ‌های کوتاه‌تر از m دقیقه یا کوچک‌تر از n حجم از لیست و پخش. ساخت پلی‌لیست، favorite کردن آهنگ‌ها و اکولایزر داخلی برای تنظیم صدا.',
      ),
      challenge: L(
        'Default mobile music apps often lack fine-grained control — filtering short clips and small files, custom playlists, favorites, and equalizer settings in one lightweight local player.',
        'اپ‌های پیش‌فرض موسیقی موبایل کنترل دقیق ندارند — فیلتر کلیپ کوتاه و فایل کوچک، پلی‌لیست سفارشی، favorite و اکولایزر در یک پخش‌کننده سبک محلی.',
      ),
      solution: L(
        'Built with Flutter — device media library integration, sort by name or date, sequential and shuffle playback, threshold filters for minimum duration and file size, playlist CRUD, favorites system, and native-style equalizer presets and custom bands.',
        'با Flutter — اتصال به کتابخانه مدیا دستگاه، مرتب‌سازی نام/زمان، پخش ترتیبی و shuffle، فیلتر حداقل مدت و حجم فایل، CRUD پلی‌لیست، سیستم علاقه‌مندی و preset و band سفارشی اکولایزر.',
      ),
      results: L(
        'A polished offline music experience with smart library management, personal playlists, and full audio customization — no streaming dependency required.',
        'تجربه موسیقی offline با مدیریت هوشمند کتابخانه، پلی‌لیست شخصی و سفارشی‌سازی کامل صدا — بدون وابستگی به streaming.',
      ),
      myRole: L('Flutter Developer', 'توسعه‌دهنده Flutter'),
      duration: L('Personal project', 'پروژه شخصی'),
      imageAsset: 'assets/images/projects/music_player1.jpg',
      galleryAssets: [
        'assets/images/projects/music_player2.jpg',
      ],
      portraitCover: true,
      isFeatured: false,
    ),
    ProjectItem(
      id: 'clinic-appointment-booking',
      title: L('Online Clinic Appointment Booking', 'سامانه نوبت‌دهی آنلاین کلینیک'),
      description: L(
        'Django web app for clinics — managers publish available slots, patients book appointments online.',
        'وب‌اپ Django برای کلینیک — مدیر اسلات‌های خالی را تعریف می‌کند، بیماران آنلاین رزرو می‌کنند.',
      ),
      category: L('Healthcare Web App', 'سامانه وب درمانی'),
      tags: ['Django', 'Booking', 'Scheduling', 'MySQL'],
      color: Color(0xFF06B6D4),
      url: '',
      overview: L(
        'A Django-based online appointment scheduling platform for clinics. Clinic administrators define their available time slots on the website, and patients browse open appointments and reserve the time that suits them — replacing phone-based booking with a self-service digital flow.',
        'پلتفرم رزرو نوبت آنلاین مبتنی بر Django برای کلینیک‌ها. مسئول کلینیک نوبت‌های خالی را در سایت تعیین می‌کند و مشتریان/بیماران با توجه به زمان‌های آزاد، هر تایمی که بخواهند رزرو می‌کنند — جایگزین نوبت‌گیری تلفنی با جریان دیجیتال self-service.',
      ),
      challenge: L(
        'Phone-only appointment booking caused double bookings, staff overhead, and patients unable to see real-time availability outside business hours.',
        'نوبت‌گیری فقط تلفنی باعث رزرو تکراری، بار کاری پرسنل و ناتوانی بیماران در دیدن زمان‌های آزاد خارج از ساعات کاری می‌شد.',
      ),
      solution: L(
        'Built with Django — admin panel for clinic managers to create and manage available slots, public booking interface for patients to view open times and confirm reservations, with slot locking to prevent conflicts.',
        'با Django — پنل مدیریت برای تعریف و مدیریت اسلات‌های خالی، رابط عمومی برای مشاهده زمان‌های آزاد و تأیید رزرو، با قفل اسلات برای جلوگیری از تداخل.',
      ),
      results: L(
        'Streamlined clinic scheduling, reduced phone load, 24/7 self-service booking for patients, and clear visibility of available appointments.',
        'زمان‌بندی روان کلینیک، کاهش تماس تلفنی، رزرو self-service ۲۴/۷ برای بیماران و دید شفاف نوبت‌های خالی.',
      ),
      myRole: L('Full-Stack Developer', 'توسعه‌دهنده فول‌استک'),
      duration: L('Client project', 'پروژه مشتری'),
      imageAsset: 'assets/images/projects/clinic-booking.jpg',
      isFeatured: false,
    ),
    ProjectItem(
      id: 'iot-tracker-ionic',
      title: L('IoT Tracker & Alarm Control App', 'اپ کنترل ردیاب و دزدگیر IoT'),
      description: L(
        'Ionic frontend for an IoT platform — device pairing, remote configuration, tracking alerts via push notifications.',
        'فرانت Ionic برای پلتفرم IoT — اتصال دستگاه، تنظیمات از راه دور، هشدار ردیابی با push notification.',
      ),
      category: L('IoT Mobile App', 'اپ موبایل IoT'),
      tags: ['Ionic', 'IoT', 'Push Notifications', 'TypeScript'],
      color: Color(0xFF3B82F6),
      url: '',
      overview: L(
        'Frontend mobile application built with Ionic for an IoT security platform focused on alarm systems and GPS trackers. Users register devices in the app, connect to them over the network, and apply remote configuration settings. When a device detects a tracked event or trigger, it sends data to the backend server, which forwards real-time push notifications to the user\'s phone.',
        'اپ موبایل Ionic برای پلتفرم IoT امنیتی — دزدگیر و ردیاب GPS. کاربران دستگاه‌ها را در اپ تعریف، به آن‌ها متصل و تنظیمات از راه دور اعمال می‌کنند. وقتی دستگاه رویداد یا trigger ردیابی را تشخیص دهد، داده به سرور ارسال و سرور push notification لحظه‌ای به موبایل کاربر می‌فرستد.',
      ),
      challenge: L(
        'IoT device management required a cross-platform mobile UI for pairing, live configuration, and instant alerts — without users needing technical knowledge of each tracker or alarm model.',
        'مدیریت دستگاه IoT به UI موبایل cross-platform برای pairing، تنظیمات live و هشدار فوری نیاز داشت — بدون دانش فنی کاربر از هر مدل ردیاب یا دزدگیر.',
      ),
      solution: L(
        'Built the frontend with Ionic — device registration and connection flows, remote settings panels per device type, real-time sync with backend API, and push notification integration so users are instantly notified when tracking events occur.',
        'فرانت با Ionic — گردش ثبت و اتصال دستگاه، پنل تنظیمات از راه دور برای هر نوع دستگاه، همگام‌سازی لحظه‌ای با API بک‌اند و یکپارچه‌سازی push notification برای اعلان فوری رویدادهای ردیابی.',
      ),
      results: L(
        'Unified mobile control for alarms and trackers, remote device management from anywhere, and immediate push alerts when events are detected.',
        'کنترل یکپارچه موبایل دزدگیر و ردیاب، مدیریت از راه دور دستگاه از هر جا، و هشدار push فوری هنگام تشخیص رویداد.',
      ),
      myRole: L('Frontend Developer', 'توسعه‌دهنده فرانت‌اند'),
      duration: L('Client project', 'پروژه مشتری'),
      imageAsset: 'assets/images/projects/IOTTracker1.png',
      isFeatured: false,
    ),
    ProjectItem(
      id: 'gifted-students-admission',
      title: L('Gifted Students Admission Portal', 'سامانه پذیرش استعدادهای درخشان'),
      description: L(
        'Master\'s thesis project — Django DRF + React portal for managing gifted student applications at MSc and PhD levels.',
        'پروژه کارشناسی ارشد — پورتال Django DRF + React برای مدیریت درخواست و پذیرش استعدادهای درخشان کارشناسی ارشد و دکتری.',
      ),
      category: L('Academic Web App', 'سامانه وب دانشگاهی'),
      tags: ['Django', 'React', 'DRF', 'JWT'],
      color: Color(0xFF7C3AED),
      url: '',
      overview: L(
        'A full-stack web application developed as a master\'s degree thesis project. The platform manages application requests and admissions for gifted and outstanding students (استعدادهای درخشان) applying to MSc and PhD programs. Built with Django REST Framework on the backend and React on the frontend, it implements role-based access control across multiple user levels and secures all API endpoints with JWT authentication.',
        'اپ full-stack به عنوان پروژه کارشناسی ارشد. پلتفرم مدیریت درخواست‌ها و پذیرش دانشجویان استعدادهای درخشان در مقاطع کارشناسی ارشد و دکتری. بک‌اند Django REST Framework و فرانت React، کنترل دسترسی نقش‌محور در سطوح مختلف کاربر و امنیت API با JWT.',
      ),
      challenge: L(
        'The gifted student admission process involved paper forms, manual review chains, and no centralized system for applicants, reviewers, and administrators across MSc and PhD tracks.',
        'فرآیند پذیرش استعدادهای درخشان شامل فرم کاغذی، زنجیره بررسی دستی و نبود سامانه متمرکز برای متقاضی، داور و مدیر در مقاطع ارشد و دکتری بود.',
      ),
      solution: L(
        'Designed and built with Django DRF + React — multi-role access levels (applicant, reviewer, admin), JWT-secured REST APIs, application submission and tracking workflows, admission decision management, and a modern SPA frontend for a smooth user experience.',
        'طراحی و ساخت با Django DRF + React — سطوح دسترسی چندنقشی (متقاضی، داور، مدیر)، REST API امن با JWT، گردش ثبت و پیگیری درخواست، مدیریت تصمیم پذیرش و SPA مدرن برای تجربه کاربری روان.',
      ),
      results: L(
        'A complete thesis deliverable digitizing the gifted student admission pipeline — secure, role-aware, and ready for university-scale deployment.',
        'تحویل کامل پروژه پایان‌نامه — دیجیتالی‌سازی مسیر پذیرش استعدادهای درخشان، امن، نقش‌محور و آماده استقرار در مقیاس دانشگاه.',
      ),
      myRole: L('Full-Stack Developer (Thesis)', 'توسعه‌دهنده فول‌استک (پایان‌نامه)'),
      duration: L('Master\'s thesis', 'کارشناسی ارشد'),
      imageAsset: 'assets/images/projects/gifted-students.jpg',
      isFeatured: true,
    ),
    ProjectItem(
      id: 'yolo-license-plate',
      title: L('YOLO License Plate Detection', 'تشخیص پلاک خودرو با YOLO'),
      description: L(
        'Custom YOLO model training for automatic license plate detection in images and video streams.',
        'آموزش مدل YOLO سفارشی برای تشخیص خودکار پلاک خودرو در تصویر و ویدیو.',
      ),
      category: L('Computer Vision / ML', 'بینایی ماشین / ML'),
      tags: ['YOLO', 'Python', 'OpenCV', 'PyTorch'],
      color: Color(0xFFEF4444),
      url: '',
      overview: L(
        'A computer vision project focused on training a YOLO object detection model to identify and localize vehicle license plates. The workflow covers dataset preparation and labeling, model training and hyperparameter tuning, evaluation with precision/recall metrics, and inference on real-world images and video frames — enabling automated plate detection for traffic, parking, or security use cases.',
        'پروژه بینایی ماشین برای آموزش مدل تشخیص شیء YOLO جهت شناسایی و موقعیت‌یابی پلاک خودرو. شامل آماده‌سازی و label دیتاست، آموزش مدل و tuning، ارزیابی با precision/recall و inference روی تصویر و فریم ویدیو — برای کاربرد ترافیک، پارکینگ یا امنیت.',
      ),
      challenge: L(
        'Manual license plate reading does not scale for high-volume traffic monitoring — a reliable automated detector was needed that works across varied lighting, angles, and plate formats.',
        'خواندن دستی پلاک برای پایش پرترافیک مقیاس‌پذیر نیست — به detector خودکار پایدار نیاز بود که در نور، زاویه و فرمت پلاک مختلف کار کند.',
      ),
      solution: L(
        'Prepared a labeled dataset of vehicle images, trained a YOLO model with iterative fine-tuning, validated detection accuracy on held-out samples, and deployed inference pipeline using Python, OpenCV, and PyTorch/Ultralytics stack.',
        'دیتاست label‌شده تصاویر خودرو، آموزش YOLO با fine-tuning تکراری، اعتبارسنجی دقت روی نمونه‌های test و pipeline inference با Python، OpenCV و PyTorch/Ultralytics.',
      ),
      results: L(
        'A production-ready plate detection model capable of real-time inference — foundation for ANPR, parking systems, or traffic analytics pipelines.',
        'مدل تشخیص پلاک آماده inference لحظه‌ای — پایه برای ANPR، سیستم پارکینگ یا pipeline تحلیل ترافیک.',
      ),
      myRole: L('ML Engineer', 'مهندس یادگیری ماشین'),
      duration: L('Research project', 'پروژه تحقیقاتی'),
      imageAsset: 'assets/images/projects/plate_detection1.jpg',
      isFeatured: true,
    ),
    ProjectItem(
      id: 'jet-printer-excel-flutter',
      title: L('Jet Printer Excel & Scan Verification', 'چاپ Jet Printer از Excel و تأیید با اسکنر'),
      description: L(
        'Flutter desktop app — reads Excel files, sends print commands to industrial Jet Printers, and verifies output with a barcode scanner.',
        'اپ دسکتاپ Flutter — خواندن فایل Excel، ارسال دستور چاپ به Jet Printer صنعتی و بررسی صحت چاپ با اسکنر بارکد.',
      ),
      category: L('Industrial Desktop App', 'اپ دسکتاپ صنعتی'),
      tags: ['Flutter', 'Excel', 'Jet Printer', 'Barcode Scanner'],
      color: Color(0xFF14B8A6),
      url: '',
      overview: L(
        'A Flutter desktop application for production-line labeling workflows. Operators upload Excel files containing product data; the app parses rows and sends formatted print jobs to industrial Jet Printers. After printing, a barcode scanner verifies that the label was applied correctly — closing the loop between data import, print execution, and quality control.',
        'اپ دسکتاپ Flutter برای گردش کار لیبل‌گذاری خط تولید. اپراتور فایل Excel حاوی داده محصول را بارگذاری می‌کند؛ اپ سطرها را parse و دستور چاپ فرمت‌شده به Jet Printer صنعتی می‌فرستد. پس از چاپ، اسکنر بارکد صحت اعمال لیبل را بررسی می‌کند — بستن حلقه بین import داده، اجرای چاپ و کنترل کیفیت.',
      ),
      challenge: L(
        'Manual label printing from spreadsheets caused misprints, no verification step, and slow handoff between office data and the production floor.',
        'چاپ دستی لیبل از Excel باعث چاپ اشتباه، نبود مرحله تأیید و انتقال کند داده بین دفتر و خط تولید می‌شد.',
      ),
      solution: L(
        'Built with Flutter — Excel parsing and batch queue management, Jet Printer driver integration for industrial print commands, scanner input for post-print barcode verification, and operator-friendly UI for daily production use.',
        'با Flutter — parse و صف Excel، اتصال Jet Printer برای دستور چاپ صنعتی، ورودی اسکنر برای تأیید بارکد پس از چاپ، و UI مناسب اپراتور برای استفاده روزانه تولید.',
      ),
      results: L(
        'Automated Excel-to-printer pipeline, reduced labeling errors, and verified print quality on every unit before it leaves the line.',
        'خط لوله خودکار Excel تا پرینتر، کاهش خطای لیبل و تأیید کیفیت چاپ روی هر واحد قبل از خروج از خط.',
      ),
      myRole: L('Flutter Developer', 'توسعه‌دهنده Flutter'),
      duration: L('Production system', 'سیستم عملیاتی'),
      imageAsset: 'assets/images/projects/nitka1.png',
      galleryAssets: [
        'assets/images/projects/nitka2.png',
      ],
      isFeatured: false,
    ),
    ProjectItem(
      id: 'barcode-label-print-pyside',
      title: L('Barcode-Triggered Label Printer', 'چاپ لیبل با محرک بارکد'),
      description: L(
        'Python PySide desktop app — barcode scanner reads a code and the system sends user-configured label data to a printer.',
        'اپ دسکتاپ Python PySide — اسکنر بارکد را می‌خواند و سیستم اطلاعات از پیش تعیین‌شده کاربر را به پرینتر ارسال می‌کند.',
      ),
      category: L('Industrial Desktop App', 'اپ دسکتاپ صنعتی'),
      tags: ['Python', 'PySide', 'Barcode Scanner', 'Label Printer'],
      color: Color(0xFF64748B),
      url: '',
      overview: L(
        'A lightweight Python desktop utility built with PySide for warehouse and production environments. A barcode scanner reads product or batch codes; based on mappings the user configures in advance, the system automatically formats and sends the corresponding label content to a connected printer — no manual copy-paste between systems.',
        'ابزار دسکتاپ سبک Python با PySide برای انبار و تولید. اسکنر بارکد کد محصول یا batch را می‌خواند؛ بر اساس mapping از پیش تعریف‌شده توسط کاربر، سیستم خودکار محتوای لیبل را فرمت و به پرینتر متصل ارسال می‌کند — بدون copy-paste دستی بین سیستم‌ها.',
      ),
      challenge: L(
        'Operators had to look up barcode values manually and re-enter label text for every scan — slow, error-prone, and unsuitable for high-volume labeling.',
        'اپراتورها باید مقدار بارکد را دستی پیدا و متن لیبل را برای هر اسکن دوباره وارد می‌کردند — کند، خطاپذیر و نامناسب برای حجم بالای لیبل‌گذاری.',
      ),
      solution: L(
        'Built with Python and PySide — configurable barcode-to-label mapping table, real-time scanner input handling, print template engine, and direct printer dispatch so each scan triggers the correct label instantly.',
        'با Python و PySide — جدول mapping بارکد به لیبل قابل تنظیم، پردازش لحظه‌ای ورودی اسکنر، موتور template چاپ و ارسال مستقیم به پرینتر تا هر اسکن فوراً لیبل درست را چاپ کند.',
      ),
      results: L(
        'One-scan-one-label workflow, eliminated manual data entry, and faster throughput on the production floor.',
        'گردش یک اسکن — یک لیبل، حذف ورود دستی داده و throughput سریع‌تر در خط تولید.',
      ),
      myRole: L('Python Developer', 'توسعه‌دهنده Python'),
      duration: L('Production system', 'سیستم عملیاتی'),
      imageAsset: 'assets/images/projects/MardeKoohestan1.png',
      galleryAssets: [
        'assets/images/projects/MardeKoohestan2.png',
        'assets/images/projects/MardeKoohestan3.png',
      ],
      isFeatured: false,
    ),
  ];

  static const skillGroups = [
    SkillGroup(
      title: L('Backend & Database', 'بک‌اند و دیتابیس'),
      skills: [
        SkillItem(name: 'Python'),
        SkillItem(name: 'Django'),
        SkillItem(name: 'Django REST Framework'),
        SkillItem(name: 'Redis'),
        SkillItem(name: 'Celery'),
        SkillItem(name: 'MySQL'),
        SkillItem(name: 'PostgreSQL'),
        SkillItem(name: 'JWT'),
      ],
    ),
    SkillGroup(
      title: L('Frontend & Mobile', 'فرانت‌اند و موبایل'),
      skills: [
        SkillItem(name: 'JavaScript'),
        SkillItem(name: 'HTML'),
        SkillItem(name: 'CSS'),
        SkillItem(name: 'React'),
        SkillItem(name: 'Redux'),
        SkillItem(name: 'Flutter'),
        SkillItem(name: 'Dart'),
        SkillItem(name: 'Ionic'),
        SkillItem(name: 'TypeScript'),
        SkillItem(name: 'Electron.js'),
      ],
    ),
    SkillGroup(
      title: L('AI & Computer Vision', 'هوش مصنوعی و بینایی ماشین'),
      skills: [
        SkillItem(name: 'YOLO'),
        SkillItem(name: 'OpenCV'),
        SkillItem(name: 'PyTorch'),
        SkillItem(name: 'AI APIs'),
      ],
    ),
    SkillGroup(
      title: L('Tools', 'ابزارها'),
      skills: [
        SkillItem(name: 'Git'),
        SkillItem(name: 'Postman'),
        SkillItem(name: 'Docker'),
      ],
    ),
  ];

  static const experiences = [
    ExperienceItem(
      company: 'Supishi',
      role: L('Full-Stack Developer', 'توسعه‌دهنده فول‌استک'),
      period: L('Jul 2024 — Present', 'تیر ۱۴۰۳ — اکنون'),
      description: L(
        'Full-stack developer at Supishi (UK Domino\'s franchise). Built the product tracking and warehouse management platform, the mission form digitization web app (supishi.net), a Flutter app that reads Excel files and drives Jet Printers with scan verification, and a PySide desktop tool where barcode scans trigger predefined label prints.',
        'توسعه‌دهنده فول‌استک در سوپیشی (نمایندگی دومینوی انگلستان). ساخت سامانه رهگیری و مدیریت محصول، وب‌اپ دیجیتال‌سازی فرم مأموریت (supishi.net)، اپ Flutter برای خواندن Excel و چاپ Jet Printer با تأیید اسکنر، و ابزار دسکتاپ PySide که با اسکن بارکد، چاپ لیبل از پیش تعریف‌شده را اجرا می‌کند.',
      ),
      isCurrent: true,
      relatedProjectIds: [
        'product-tracking',
        'supishi-mission-forms',
        'jet-printer-excel-flutter',
        'barcode-label-print-pyside',
      ],
      websiteUrl: 'https://supishi.net',
    ),
    ExperienceItem(
      company: 'Shahid University ICT Research Institute',
      role: L('Frontend Developer (React)', 'توسعه‌دهنده فرانت‌اند (React)'),
      period: L('Oct — Dec 2023', 'مهر — آذر ۱۴۰۲'),
      description: L(
        'React frontend developer — contributed to building key sections of the cipherland.ir website as part of the university research institute team.',
        'توسعه‌دهنده فرانت React — مشارکت در توسعه بخش‌هایی از سایت cipherland.ir در تیم پژوهشکده ارتباطات و فناوری اطلاعات دانشگاه شاهد.',
      ),
      isCurrent: false,
      websiteUrl: 'https://cipherland.ir',
    ),
    ExperienceItem(
      company: 'Paya Communications Industries',
      role: L('Python Developer — Internship', 'برنامه‌نویس Python — کارآموزی'),
      period: L('May — Jul 2022', 'اردیبهشت — تیر ۱۴۰۱'),
      description: L(
        'University internship — Python development with Django and AI. Main deliverable: training and deploying a YOLO model for automatic license plate detection in images and video.',
        'دوره کارآموزی دانشگاه — توسعه Python با Django و هوش مصنوعی. دستاورد اصلی: آموزش و استقرار مدل YOLO برای تشخیص خودکار پلاک خودرو در تصویر و ویدیو.',
      ),
      isCurrent: false,
      relatedProjectIds: ['yolo-license-plate'],
    ),
    ExperienceItem(
      company: 'Tanco',
      role: L('JavaScript & Ionic Developer', 'برنامه‌نویس JavaScript و Ionic'),
      period: L('Jan 2019 — May 2020', 'بهمن ۱۳۹۷ — خرداد ۱۳۹۹'),
      description: L(
        'Mobile developer using JavaScript and Ionic — built the IoT tracker and alarm control app for device registration, remote configuration, and real-time push notifications when tracking events occur.',
        'توسعه‌دهنده موبایل با JavaScript و Ionic — ساخت اپ کنترل ردیاب و دزدگیر IoT برای ثبت دستگاه، تنظیمات از راه دور و push notification لحظه‌ای هنگام رویدادهای ردیابی.',
      ),
      isCurrent: false,
      relatedProjectIds: ['iot-tracker-ionic'],
    ),
  ];

  static const educations = [
    EducationItem(
      institution: 'Amirkabir University of Technology',
      degree: L('M.Sc. in E-Commerce', 'کارشناسی ارشد تجارت الکترونیک'),
      period: L('Tehran', 'تهران'),
      description: L(
        'Graduate degree in e-commerce from Amirkabir University of Technology (Tehran Polytechnic). Master\'s thesis: Gifted Students Admission Portal.',
        'کارشناسی ارشد تجارت الکترونیک از دانشگاه صنعتی امیرکبیر تهران. پایان‌نامه: سامانه پذیرش استعدادهای درخشان.',
      ),
      relatedProjectIds: ['gifted-students-admission'],
    ),
    EducationItem(
      institution: 'Khaje Nasir Toosi University of Technology',
      degree: L('B.Sc. in Computer Engineering', 'کارشناسی مهندسی کامپیوتر'),
      period: L('Tehran', 'تهران'),
      description: L(
        'Undergraduate degree in Computer Engineering from K.N. Toosi University of Technology, Tehran.',
        'کارشناسی مهندسی کامپیوتر از دانشگاه صنعتی خواجه نصیرالدین طوسی تهران.',
      ),
    ),
    EducationItem(
      institution: 'Gifted & Talented School',
      degree: L(
        'Middle School, High School & Pre-University',
        'راهنمایی، دبیرستان و پیش‌دانشگاهی',
      ),
      period: L('Iran', 'ایران'),
      description: L(
        'Completed middle school, high school, and pre-university at a gifted & talented school.',
        'تحصیل در مقاطع راهنمایی، دبیرستان و پیش‌دانشگاهی در مدرسه استعدادهای درخشان.',
      ),
    ),
  ];

  static const testimonials = [
    TestimonialItem(
      name: 'Sarah Johnson',
      role: L('Product Manager at TechCorp', 'مدیر محصول در TechCorp'),
      quote: L(
        'Exceptional work! Delivered ahead of schedule with pixel-perfect UI and smooth animations.',
        'کار فوق‌العاده! زودتر از موعد تحویل داد با UI بی‌نقص و انیمیشن‌های روان.',
      ),
      avatarInitials: 'SJ',
    ),
    TestimonialItem(
      name: 'Ali Rezaei',
      role: L('CEO at StartupHub', 'مدیرعامل StartupHub'),
      quote: L(
        'Transformed our vision into a stunning app. Highly recommend for any Flutter project.',
        'چشم‌انداز ما را به یک اپ خیره‌کننده تبدیل کرد. برای هر پروژه فلاتر توصیه می‌کنم.',
      ),
      avatarInitials: 'AR',
    ),
    TestimonialItem(
      name: 'Emily Chen',
      role: L('Design Lead at CreativeStudio', 'سرپرست طراحی CreativeStudio'),
      quote: L(
        'Great collaboration, attention to detail, and always open to feedback. A true professional.',
        'همکاری عالی، توجه به جزئیات و همیشه پذیرای بازخورد. یک حرفه‌ای واقعی.',
      ),
      avatarInitials: 'EC',
    ),
  ];

  static const techMarquee = [
    'Python',
    'Django',
    'DRF',
    'Flutter',
    'React',
    'YOLO',
    'OpenCV',
    'JavaScript',
    'Redis',
    'Celery',
    'MySQL',
    'PostgreSQL',
    'Ionic',
    'Docker',
    'Git',
  ];
}
