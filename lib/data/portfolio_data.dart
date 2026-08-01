import 'package:flutter/material.dart';

import 'localized_text.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  EDIT YOUR CONTENT HERE — all bilingual fields use L('English', 'فارسی')
// ─────────────────────────────────────────────────────────────────────────────

class PortfolioProfile {
  const PortfolioProfile({
    required this.name,
    required this.headline,
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
  final L headline;
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
    this.showPlus = true,
  });

  final int value;
  final L label;
  final IconData icon;
  final bool showPlus;
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

class ServiceItem {
  const ServiceItem({
    required this.title,
    required this.description,
    required this.problems,
    required this.icon,
    required this.color,
  });

  final L title;
  final L description;
  final List<L> problems;
  final IconData icon;
  final Color color;
}

class ClientProblemItem {
  const ClientProblemItem({
    required this.problem,
    required this.outcome,
    required this.icon,
    required this.color,
  });

  final L problem;
  final L outcome;
  final IconData icon;
  final Color color;
}

class PortfolioData {
  static const profile = PortfolioProfile(
    name: 'Ali Baziar',
    headline: L(
      'I help businesses stop wasting time on manual work',
      'به کسب‌وکارها کمک می‌کنم دیگر وقتشان را صرف کارهای دستی نکنند',
    ),
    role: L(
      'Python Automation & AI Solutions Developer',
      'توسعه‌دهنده راه‌حل‌های خودکارسازی پایتون و هوش مصنوعی',
    ),
    tagline: L(
      'I build Python automation tools, Django business apps, AI integrations, and workflow systems — with fixed scope, clear updates, and production-ready delivery.',
      'من ابزارهای خودکارسازی پایتون، وب‌اپ‌های جنگو، یکپارچه‌سازی هوش مصنوعی و سامانه‌های گردش کار می‌سازم؛ با محدوده مشخص، گزارش‌دهی شفاف و تحویل آماده بهره‌برداری.',
    ),
    bio: L(
      'I\'m Ali Baziar — I work with small business owners and startup founders who need reliable systems, not another developer who disappears mid-project.\n\nI\'ve delivered production systems for real companies: inventory tracking from factory to warehouse, digital approval workflows that replaced paper forms, AI-powered platforms, and desktop tools that connect Excel, scanners, and printers.\n\nBefore we start, you get a clear scope and fixed price. During the project, regular updates in plain English. After delivery, working code with documentation you can actually use.\n\nProjects from \$50 automation scripts to full business applications. If manual work is slowing your business down, let\'s talk.',
      'من علی بازیار هستم. با صاحبان کسب‌وکارهای کوچک و تیم‌های نوپا کار می‌کنم؛ کسانی که به سیستمی قابل اعتماد نیاز دارند، نه برنامه‌نویسی که وسط پروژه رها کند.\n\nبرای شرکت‌های واقعی سامانه‌های عملیاتی تحویل داده‌ام: رهگیری کالا از خط تولید تا انبار، جایگزینی فرم‌های کاغذی با گردش کار دیجیتال، پلتفرم‌های مبتنی بر هوش مصنوعی، و ابزارهایی که اکسل، بارکدخوان و چاپگر را به هم متصل می‌کنند.\n\nقبل از شروع، محدوده کار و قیمت را شفاف مشخص می‌کنیم. در طول پروژه، گزارش منظم و قابل فهم می‌دهم. بعد از تحویل، کد کاربردی همراه مستندات در اختیار شماست.\n\nاز اسکریپت‌های کوچک خودکارسازی تا اپلیکیشن‌های کامل. اگر کارهای دستی کسب‌وکار شما را کند کرده، بنویسید تا صحبت کنیم.',
    ),
    email: 'alibaziar1378@gmail.com',
    location: L('Iran · Remote worldwide', 'ایران · دورکاری بین‌المللی'),
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
      value: 13,
      label: L('Projects Delivered', 'پروژه تحویل‌داده‌شده'),
      icon: Icons.business_center_rounded,
    ),
    HeroStatItem(
      value: 6,
      label: L('Years Experience', 'سال تجربه'),
      icon: Icons.work_history_rounded,
    ),
    HeroStatItem(
      value: 24,
      label: L('Hour Reply Time', 'ساعت تا پاسخ'),
      icon: Icons.schedule_rounded,
      showPlus: false,
    ),
  ];

  static const heroTrustPoints = [
    L('Fixed price before we start', 'قیمت ثابت قبل از شروع'),
    L('Clear updates in plain English', 'گزارش‌دهی شفاف و قابل فهم'),
    L('Small projects from \$50', 'پروژه‌های کوچک هم پذیرفته می‌شود'),
  ];

  static const clientProblems = [
    ClientProblemItem(
      problem: L(
        'Your team lives in spreadsheets that keep breaking',
        'تیم شما در اکسل‌هایی گیر کرده که مدام به‌هم می‌ریزند',
      ),
      outcome: L(
        '→ Custom Django apps that replace Excel with reliable databases',
        'وب‌اپ جنگو که اکسل را با پایگاه داده پایدار جایگزین می‌کند',
      ),
      icon: Icons.table_chart_outlined,
      color: Color(0xFF059669),
    ),
    ClientProblemItem(
      problem: L(
        'Hours lost copying data between emails, files, and systems',
        'ساعت‌ها وقت صرف کپی اطلاعات بین ایمیل، فایل و سیستم‌ها',
      ),
      outcome: L(
        '→ Python scripts and API integrations that run automatically',
        'اسکریپت پایتون و اتصال API که خودکار اجرا می‌شود',
      ),
      icon: Icons.sync_alt_rounded,
      color: Color(0xFF0D9488),
    ),
    ClientProblemItem(
      problem: L(
        'Paper forms and email chains slowing approvals down',
        'فرم کاغذی و زنجیره ایمیل که تأییدها را کند می‌کند',
      ),
      outcome: L(
        '→ Digital workflows with SMS alerts and traceable sign-off',
        'گردش کار دیجیتال با پیامک و تأیید قابل ردیابی',
      ),
      icon: Icons.description_outlined,
      color: Color(0xFF8B5CF6),
    ),
    ClientProblemItem(
      problem: L(
        'No idea where products or stock actually are right now',
        'نمی‌دانید محصول یا موجودی الان دقیقاً کجاست',
      ),
      outcome: L(
        '→ Tracking and warehouse systems with barcode workflows',
        'سامانه رهگیری و انبار با گردش کار بارکد',
      ),
      icon: Icons.inventory_2_outlined,
      color: Color(0xFF6366F1),
    ),
    ClientProblemItem(
      problem: L(
        'Your tools don\'t talk to each other',
        'ابزارهای شما به هم وصل نیستند',
      ),
      outcome: L(
        '→ Connected workflows linking printers, CRMs, SMS, and databases',
        'گردش کار یکپارچه بین چاپگر، CRM، پیامک و پایگاه داده',
      ),
      icon: Icons.hub_outlined,
      color: Color(0xFFF59E0B),
    ),
    ClientProblemItem(
      problem: L(
        'You want AI in your business but don\'t know where to start',
        'هوش مصنوعی می‌خواهید اما نمی‌دانید از کجا شروع کنید',
      ),
      outcome: L(
        '→ Practical AI assistants and automations inside your existing apps',
        'دستیار هوش مصنوعی و خودکارسازی عملی داخل اپلیکیشن فعلی شما',
      ),
      icon: Icons.psychology_outlined,
      color: Color(0xFFEC4899),
    ),
  ];

  static const workHighlights = [
    L(
      'Fixed price agreed before any work starts',
      'قیمت ثابت قبل از شروع هر کاری',
    ),
    L(
      'Weekly progress updates you can actually understand',
      'گزارش پیشرفت هفتگی که واقعاً قابل فهم است',
    ),
    L(
      'Small projects welcome — automation from \$50',
      'پروژه‌های کوچک هم پذیرفته می‌شود',
    ),
  ];

  static const pricingNote = L(
    'Not sure which service fits? Describe your problem — I\'ll suggest the smallest solution that works. Starting from \$50.',
    'مطمئن نیستید کدام خدمت مناسب است؟ مشکل را بگویید تا کوچک‌ترین راه‌حل مؤثر را پیشنهاد دهم.',
  );

  static List<ProjectItem> get orderedProjects {
    const featuredOrder = [
      'ai-language-learning',
      'product-tracking',
      'warehouse-management',
      'business-automation-suite',
    ];
    final byId = {for (final p in projects) p.id: p};
    final ordered = <ProjectItem>[];
    for (final id in featuredOrder) {
      final project = byId[id];
      if (project != null) ordered.add(project);
    }
    for (final p in projects) {
      if (!featuredOrder.contains(p.id)) ordered.add(p);
    }
    return ordered;
  }

  static List<ProjectItem> get featuredProjects =>
      orderedProjects.where((p) => p.isFeatured).toList();

  static ProjectItem? projectById(String id) {
    try {
      return projects.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  static const projects = [
    ProjectItem(
      id: 'ai-language-learning',
      title: L('AI Language Learning Platform', 'پلتفرم یادگیری زبان با هوش مصنوعی'),
      description: L(
        'Educators wanted to sell interactive AI courses — without building the tech from scratch.',
        'مدرسان می‌خواستند دوره تعاملی مبتنی بر هوش مصنوعی بفروشند — بدون ساخت فنی از صفر.',
      ),
      category: L('AI Business Application', 'اپلیکیشن هوش مصنوعی برای کسب‌وکار'),
      tags: ['Django', 'AI APIs', 'REST API', 'MySQL'],
      color: Color(0xFF6366F1),
      url: '',
      overview: L(
        'Backend platform for an AI-driven language learning application. Educators build structured courses — comprehensive programs, grammar, reading, and more — and attach intelligent assistants to each course. Assistant bots answer learner questions via chat, while specialized teaching bots drill vocabulary and grammar. Learners discover and enroll in published courses. A monetization system lets creators earn revenue from their content.',
        'بک‌اند پلتفرم یادگیری زبان مبتنی بر هوش مصنوعی. مدرسان دوره‌های ساختاریافته می‌سازند و به هر دوره دستیار هوشمند اضافه می‌کنند. ربات دستیار در چت به پرسش‌ها پاسخ می‌دهد؛ ربات‌های آموزشی برای لغت و گرامر تمرین می‌دهند. کاربران دوره‌ها را پیدا می‌کنند و ثبت‌نام می‌کنند. سامانه درآمدزایی برای سازندگان محتوا پیاده‌سازی شده است.',
      ),
      challenge: L(
        'Language learners needed personalized, interactive practice beyond static lessons. Educators wanted to monetize AI-enhanced courses but lacked the technical infrastructure to build assistants, course structures, and payment flows from scratch.',
        'زبان‌آموزان به تمرین تعاملی و شخصی‌سازی‌شده فراتر از درس ثابت نیاز داشتند. مدرسان می‌خواستند از دوره‌های مبتنی بر هوش مصنوعی درآمد داشته باشند، اما زیرساخت فنی لازم را نداشتند.',
      ),
      solution: L(
        'Built the backend with Django and integrated AI APIs for conversational assistants and teaching bots. Implemented course creation workflows, per-course chat assistants, vocabulary and grammar bots, user enrollment, and a creator monetization engine — a marketplace-style learning ecosystem.',
        'بک‌اند با جنگو و یکپارچه‌سازی API هوش مصنوعی. گردش کار ساخت دوره، دستیار چت، ربات‌های آموزشی، ثبت‌نام کاربران و سامانه درآمدزایی برای سازندگان محتوا.',
      ),
      results: L(
        'Educators can launch and sell AI-enhanced courses without building infrastructure. Learners get 24/7 interactive tutoring. The monetization layer supports sustainable content creation.',
        'مدرسان بدون ساخت زیرساخت، دوره مبتنی بر هوش مصنوعی می‌فروشند. یادگیرندگان آموزش تعاملی شبانه‌روزی می‌گیرند. سامانه درآمدزایی، تولید محتوای پایدار را پشتیبانی می‌کند.',
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
      id: 'product-tracking',
      title: L('Product Tracking System', 'سامانه رهگیری محصولات'),
      description: L(
        'Manufacturing client couldn\'t track products after they left the factory floor.',
        'کارفرمای تولیدی بعد از خروج از خط، محصولاتش را ردیابی نمی‌کرد.',
      ),
      category: L('Inventory & Tracking System', 'سامانه رهگیری و موجودی'),
      tags: ['Django', 'Redis', 'Celery', 'MySQL'],
      color: Color(0xFF0D9488),
      url: '',
      overview: L(
        'A product traceability platform for a manufacturing business. The system generates unique 2D barcodes per unit, sends print jobs to industrial Jet Printers, scans units on the production line with cameras, auto-generates master carton barcodes when capacity is reached, and lets warehouse, distribution, and returns teams update status by scanning. Full reporting dashboard included.',
        'پلتفرم رهگیری محصول برای عملیات تولید. بارکد دوبعدی یکتا، اتصال به چاپگر صنعتی، اسکن خط تولید، ساخت خودکار بارکد کارتن و به‌روزرسانی وضعیت در انبار، توزیع و مرجوعی. داشبورد گزارش‌گیری کامل.',
      ),
      challenge: L(
        'The business tracked products manually across production, packaging, warehouse, distribution, and returns. Labeling errors, lost inventory visibility, and no single source of truth made it impossible to know where any unit was at any time.',
        'رهگیری دستی باعث خطای برچسب، از دست رفتن دید موجودی و نبود منبع واحد برای وضعیت محصول می‌شد.',
      ),
      solution: L(
        'Built with Django, Redis, Celery, and MySQL — dynamic barcode generation per product type, Jet Printer and label printer integrations, camera scanning workflows, automatic master carton barcode creation, and status modules for warehouse, distribution, and returns with analytics dashboards.',
        'با جنگو، Redis، Celery و MySQL — تولید بارکد پویا، اتصال چاپگر، اسکن با دوربین، ساخت خودکار بارکد کارتن و ماژول‌های وضعیت همراه داشبورد آماری.',
      ),
      results: L(
        'Full visibility from factory to customer return. Automated labeling eliminated manual errors. Real-time status updates replaced phone calls and spreadsheets. Operational reports enable data-driven decisions.',
        'دید کامل از کارخانه تا مرجوعی. برچسب‌گذاری خودکار خطای دستی را حذف کرد. به‌روزرسانی لحظه‌ای جای تماس تلفنی و اکسل را گرفت.',
      ),
      myRole: L('Python Developer', 'توسعه‌دهنده پایتون'),
      duration: L('Production system', 'سامانه عملیاتی'),
      imageAsset: 'assets/images/projects/tracking1.jpg',
      galleryAssets: [
        'assets/images/projects/tracking2.jpg',
        'assets/images/projects/tracking3.jpg',
        'assets/images/projects/tracking4.jpg',
      ],
      isFeatured: true,
    ),
    ProjectItem(
      id: 'warehouse-management',
      title: L('Warehouse Management System', 'سامانه مدیریت انبار'),
      description: L(
        'Warehouse team lost hours reconciling Excel sheets that never matched reality.',
        'تیم انبار ساعت‌ها وقت صرف تطبیق فایل‌های اکسلی می‌کرد که با واقعیت جور درنمی‌آمد.',
      ),
      category: L('Business Management System', 'سامانه مدیریت کسب‌وکار'),
      tags: ['Django', 'REST API', 'Electron.js', 'MySQL'],
      color: Color(0xFF059669),
      url: '',
      overview: L(
        'A warehouse management platform with Django REST API and an Electron desktop client for daily operations. Supports multi-warehouse setup, role-based permissions, three product intake methods (manual, barcode scan, Excel import), outbound workflows for field experts and customers, return registration, and flexible stock and movement reports.',
        'پلتفرم مدیریت انبار با REST API جنگو و کلاینت دسکتاپ Electron. پشتیبانی از چند انبار، دسترسی نقش‌محور، سه روش ورود کالا (دستی، اسکن بارکد، وارد کردن اکسل)، گردش خروج برای کارشناس میدانی و مشتری، ثبت مرجوعی و گزارش انعطاف‌پذیر موجودی و گردش کالا.',
      ),
      challenge: L(
        'The business managed warehouse stock in spreadsheets. Counts did not match reality, there was no barcode workflow, team permissions were unclear, and managers had no unified view of inbound, outbound, and return movements.',
        'مدیریت انبار با اکسل باعث مغایرت موجودی، نبود گردش کار بارکد، مجوزهای نامشخص و نبود دید یکپارچه از گردش کالا می‌شد.',
      ),
      solution: L(
        'Developed Django REST API with role-based access control, Electron desktop UI, triple intake modes (manual, barcode, Excel bulk import), outbound and return workflows, configurable user/warehouse limits, and reporting by stock, date range, and movement type.',
        'REST API با کنترل دسترسی، رابط Electron، سه روش ورود، گردش خروج و مرجوعی، سقف کاربر/انبار و گزارش‌گیری بر اساس موجودی، بازه زمانی و نوع گردش.',
      ),
      results: L(
        'Accurate real-time inventory across warehouses. Faster intake via barcode and Excel. Controlled access per role. Actionable reports replaced manual stock reconciliation.',
        'موجودی لحظه‌ای و دقیق در همه انبارها. ورود سریع‌تر با بارکد و اکسل. دسترسی کنترل‌شده بر اساس نقش. گزارش‌های عملیاتی جای تطبیق دستی را گرفت.',
      ),
      myRole: L('Python Developer', 'توسعه‌دهنده پایتون'),
      duration: L('Multi-phase', 'چند فازی'),
      imageAsset: 'assets/images/projects/warehouse1.png',
      galleryAssets: [
        'assets/images/projects/warehouse2.png',
        'assets/images/projects/warehouse3.png',
        'assets/images/projects/warehouse4.png',
        'assets/images/projects/warehouse5.png',
        'assets/images/projects/warehouse6.png',
      ],
      isFeatured: true,
    ),
    ProjectItem(
      id: 'business-automation-suite',
      title: L('Business Process Automation Suite', 'مجموعه خودکارسازی فرآیند کسب‌وکار'),
      description: L(
        'Field teams wasted days on paper forms, manual labeling, and Excel-to-printer copy-paste.',
        'تیم میدانی روزها وقت روی فرم کاغذی، برچسب‌گذاری دستی و کپی اکسل به چاپگر می‌گذاشت.',
      ),
      category: L('Workflow Automation', 'خودکارسازی گردش کار'),
      tags: ['Python', 'Django', 'Flutter', 'PySide', 'SMS API'],
      color: Color(0xFF8B5CF6),
      url: 'https://supishi.net',
      overview: L(
        'A suite of automation tools built for field operations and production lines:\n\n1. Mission Form Platform — Replaced paper mission forms with a Django web app. Field staff submit digital forms; SMS notifies client managers for approval; staged workflow through support and department heads to archive. Live at supishi.net.\n\n2. Excel-to-Jet-Printer App — Flutter desktop app reads Excel product data, sends print jobs to industrial Jet Printers, and verifies each label with a barcode scanner.\n\n3. Barcode-Triggered Label Printer — Python/PySide tool: scan a barcode → system instantly prints the pre-configured label.',
        'مجموعه ابزار خودکارسازی:\n\n۱. پلتفرم فرم مأموریت — جایگزین فرم کاغذی با وب‌اپ جنگو، تأیید با پیامک و گردش کار چندمرحله‌ای. در آدرس supishi.net\n\n۲. اپ اکسل به چاپگر صنعتی — خواندن اکسل، چاپ صنعتی و تأیید با اسکنر.\n\n۳. چاپ برچسب با محرک بارکد — پایتون/PySide: یک اسکن، یک برچسب.',
      ),
      challenge: L(
        'Small businesses lost hours on repetitive manual tasks: paper forms waiting for multi-party approval, copying Excel data to label printers, and re-typing barcode values for every label. Slow, error-prone, and impossible to scale.',
        'ساعت‌ها وقت روی کار تکراری: فرم کاغذی، کپی اکسل به چاپگر و ورود دستی بارکد — کند، خطاپذیر و غیرقابل گسترش.',
      ),
      solution: L(
        'Built three connected automation tools with Django, Flutter, and PySide — digital form submission with SMS-triggered approvals, Excel-to-printer pipeline with scan verification, and one-scan-one-label desktop workflow with configurable barcode mappings.',
        'سه ابزار با جنگو، Flutter و PySide — فرم دیجیتال با تأیید پیامکی، خط لوله اکسل تا چاپگر با تأیید اسکن، و گردش یک اسکن یک برچسب.',
      ),
      results: L(
        'Paperless mission documentation with faster client approvals. Automated labeling eliminated manual data entry. Verified print quality on every production unit. Traceable workflows at every approval stage.',
        'مستندسازی بدون کاغذ، تأیید سریع‌تر مشتری، حذف ورود دستی، تأیید کیفیت چاپ و گردش کار قابل ردیابی در هر مرحله.',
      ),
      myRole: L('Python Developer', 'توسعه‌دهنده پایتون'),
      duration: L('Production systems', 'سامانه‌های عملیاتی'),
      imageAsset: 'assets/images/projects/supishi1.png',
      galleryAssets: [
        'assets/images/projects/supishi2.png',
        'assets/images/projects/supishi3.png',
        'assets/images/projects/supishi4.png',
        'assets/images/projects/nitka1.png',
        'assets/images/projects/nitka2.png',
        'assets/images/projects/MardeKoohestan1.png',
        'assets/images/projects/MardeKoohestan2.png',
      ],
      isFeatured: true,
    ),
    ProjectItem(
      id: 'supishi-mission-forms',
      title: L('Supishi — Mission Form Digitization', 'Supishi — الکترونیکی‌سازی فرم مأموریت'),
      description: L(
        'Django web platform digitizing field mission forms — multi-step approval workflow with SMS notifications and full reporting.',
        'پلتفرم وب جنگو برای دیجیتالی‌سازی فرم مأموریت — گردش تأیید چندمرحله‌ای با پیامک و گزارش‌گیری کامل.',
      ),
      category: L('Business Web App', 'سامانه وب سازمانی'),
      tags: ['Django', 'SMS API', 'Workflow', 'Reporting'],
      color: Color(0xFF8B5CF6),
      url: 'https://supishi.net',
      overview: L(
        'A Django-powered web platform that replaces paper-based mission forms for field operations. When company staff go on missions and inspect client equipment, they fill out digital forms for each device and submit them. An SMS is automatically sent to the client company manager with the form details for review and approval. Once approved, the form moves to the support manager to register and confirm costs. Finally, the department manager reviews all information and, if correct, gives final approval and archives the form. The system includes comprehensive reporting on forms, missions, companies, submitters, and more.',
        'پلتفرم وب جنگو که فرم‌های کاغذی مأموریت را در عملیات میدانی جایگزین می‌کند. وقتی نیروهای شرکت مأموریت می‌روند و تجهیزات مشتری را بازدید می‌کنند، برای هر دستگاه فرم دیجیتال پر و ثبت می‌کنند. پیامک خودکار با جزئیات فرم برای مسئول شرکت مشتری ارسال می‌شود تا بخواند و تأیید کند. پس از تأیید، فرم به مسئول پشتیبانی می‌رود تا هزینه‌ها را ثبت و تأیید کند. در نهایت مدیر بخش همه اطلاعات را بررسی و در صورت صحت، تأیید نهایی و بایگانی می‌کند. گزارش‌گیری کامل از فرم‌ها، مأموریت‌ها، شرکت‌ها و ثبت‌کنندگان وجود دارد.',
      ),
      challenge: L(
        'Paper mission forms caused delays, lost documents, no audit trail, and a slow multi-party approval chain between field staff, client managers, support, and department heads.',
        'فرم‌های کاغذی مأموریت باعث تأخیر، گم شدن مدارک، نبود سابقه قابل ردیابی و زنجیره تأیید کند بین نیروی میدانی، مدیر مشتری، پشتیبانی و مدیر بخش می‌شد.',
      ),
      solution: L(
        'Built with Django — digital form submission per device during missions, automated SMS notifications to client managers, staged approval workflow (client → support costs → department manager → archive), role-based access, and rich reporting dashboards filtered by forms, missions, companies, and staff.',
        'با جنگو — ثبت فرم دیجیتال برای هر دستگاه در مأموریت، اعلان پیامکی خودکار به مدیر مشتری، گردش تأیید مرحله‌ای (مشتری ← پشتیبانی ← مدیر بخش ← بایگانی)، دسترسی نقش‌محور و داشبورد گزارش بر اساس فرم، مأموریت، شرکت و پرسنل.',
      ),
      results: L(
        'Paperless mission documentation, faster approvals via SMS-triggered client sign-off, traceable workflow at every stage, and complete analytics for operations management.',
        'مستندسازی بدون کاغذ، تأیید سریع‌تر با پیامک مشتری، گردش کار قابل ردیابی در هر مرحله و آمار کامل برای مدیریت عملیات.',
      ),
      myRole: L('Full-Stack Developer', 'توسعه‌دهنده فول‌استک'),
      duration: L('Production system', 'سامانه عملیاتی'),
      imageAsset: 'assets/images/projects/supishi1.png',
      galleryAssets: [
        'assets/images/projects/supishi2.png',
        'assets/images/projects/supishi3.png',
        'assets/images/projects/supishi4.png',
      ],
      isFeatured: false,
    ),
    ProjectItem(
      id: 'developer-portfolio',
      title: L('Developer Portfolio Website', 'وب‌سایت پورتفولیو شخصی'),
      description: L(
        'Bilingual Flutter web portfolio — project case studies, skills, experience, education, and contact in EN/FA with RTL support.',
        'پورتفولیوی وب دوزبانه با Flutter — مطالعه موردی پروژه‌ها، مهارت‌ها، تجربه، تحصیلات و تماس به فارسی و انگلیسی با پشتیبانی راست‌به‌چپ.',
      ),
      category: L('Personal Web App', 'وب‌اپ شخصی'),
      tags: ['Flutter', 'Web', 'RTL', 'i18n', 'Provider'],
      color: Color(0xFF6366F1),
      url: '',
      overview: L(
        'A dynamic single-page developer portfolio built with Flutter for web. Showcases selected projects with full bilingual case study pages, grouped skills with brand icons, work experience and education timelines, and contact channels — all with smooth animations, dark/light theme toggle, and a developer-themed background. Deploy-ready for GitHub Pages and Firebase Hosting.',
        'پورتفولیوی تک‌صفحه‌ای پویا با Flutter برای وب. نمایش پروژه‌های منتخب با صفحات مطالعه موردی دوزبانه، مهارت‌های گروه‌بندی‌شده با آیکون برند، خط زمانی تجربه و تحصیلات، و راه‌های ارتباطی — همراه انیمیشن‌های روان، تم روشن/تیره و پس‌زمینه تم برنامه‌نویسی. آماده انتشار روی GitHub Pages و Firebase Hosting.',
      ),
      challenge: L(
        'Needed a professional online presence that presents projects in depth, supports both English and Persian audiences, and clearly communicates full-stack skills — without relying on a generic template site builder.',
        'نیاز به حضور آنلاین حرفه‌ای برای نمایش عمیق پروژه‌ها، پشتیبانی از مخاطب فارسی و انگلیسی، و انتقال شفاف مهارت‌های فول‌استک — بدون وابستگی به سایت‌سازهای آماده.',
      ),
      solution: L(
        'Built with Flutter — modular section architecture, ARB-based localization with RTL layout, Provider for theme/locale state, routed project detail screens, Simple Icons CDN for skill branding, animated hero and skills UI, and CI deploy configs for GitHub Pages and Firebase.',
        'با Flutter — معماری ماژولار بخش‌ها، چندزبانه‌سازی مبتنی بر ARB با چیدمان راست‌به‌چپ، Provider برای تم و زبان، صفحات جزئیات پروژه با مسیریابی، آیکون‌های Simple Icons برای مهارت‌ها، رابط انیمیشن‌دار و تنظیمات CI برای GitHub Pages و Firebase.',
      ),
      results: L(
        'A polished, maintainable portfolio where all content lives in one editable data file — bilingual, responsive, and unmistakably built by a developer.',
        'پورتفولیوی حرفه‌ای و قابل نگهداری که تمام محتوا در یک فایل داده قابل ویرایش است — دوزبانه، واکنش‌گرا و کاملاً مشخص به‌عنوان خروجی یک برنامه‌نویس.',
      ),
      myRole: L('Full-Stack Developer & Designer', 'توسعه‌دهنده فول‌استک و طراح'),
      duration: L('Personal project', 'پروژه شخصی'),
      imageAsset: 'assets/images/projects/portfolio.png',
      isFeatured: false,
    ),
    ProjectItem(
      id: 'rummy-dice-game',
      title: L('RamODis — Digital Board Game', 'بازی رام و دیس — پیاده‌سازی دیجیتال'),
      description: L(
        'Flutter implementation of RamODis — standalone local multiplayer or online play via Django REST Framework backend.',
        'پیاده‌سازی Flutter بازی رام و دیس — چندنفره محلی یا آنلاین با بک‌اند Django REST Framework.',
      ),
      category: L('Mobile Game', 'بازی موبایل'),
      tags: ['Flutter', 'Django REST', 'Local Network', 'Multiplayer'],
      color: Color(0xFFF59E0B),
      url: '',
      overview: L(
        'A digital adaptation of RamODis, delivered in two architectures. Version 1 is fully built with Flutter — players can compete against an AI bot or friends over a local network. Version 2 uses Flutter for the frontend and Django REST Framework for the backend, enabling bot matches and friend-vs-friend games over a wider network beyond local LAN. Both versions preserve core game rules while adding smooth UI, turn management, and real-time multiplayer sync.',
        'نسخه دیجیتال بازی کلاسیک رام و دیس در دو معماری. نسخه ۱ کاملاً با Flutter — بازی با ربات هوش مصنوعی یا دوستان روی شبکه محلی. نسخه ۲ فرانت Flutter و بک‌اند Django REST Framework — بازی با ربات و دوستان روی شبکه گسترده‌تر. هر دو نسخه قوانین اصلی بازی را حفظ کرده و رابط روان، مدیریت نوبت و همگام‌سازی چندنفره اضافه می‌کنند.',
      ),
      challenge: L(
        'The traditional board game needed a digital version that feels natural on mobile — with reliable multiplayer whether players are in the same room (local) or connecting remotely (online).',
        'بازی سنتی به نسخه دیجیتال طبیعی روی موبایل نیاز داشت — با بازی چندنفره پایدار، چه در یک اتاق و چه از راه دور.',
      ),
      solution: L(
        'Built Version 1 entirely in Flutter with local network discovery for nearby friends and an AI bot opponent. Built Version 2 with Flutter client + Django DRF backend for scalable online matchmaking, game state sync, and remote friend play — giving users flexibility between offline-local and cloud-connected modes.',
        'نسخه ۱ کاملاً با Flutter و کشف شبکه محلی برای دوستان نزدیک و ربات هوش مصنوعی. نسخه ۲ کلاینت Flutter و بک‌اند Django DRF برای بازی آنلاین، همگام‌سازی وضعیت بازی و بازی از راه دور — انعطاف بین حالت محلی و متصل به ابر.',
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
      isFeatured: false,
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
        'تجربه موسیقی آفلاین با مدیریت هوشمند کتابخانه، پلی‌لیست شخصی و سفارشی‌سازی کامل صدا — بدون وابستگی به پخش آنلاین.',
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
        'وب‌اپ جنگو برای کلینیک — مدیر زمان‌های خالی را تعریف می‌کند، بیماران آنلاین نوبت می‌گیرند.',
      ),
      category: L('Healthcare Web App', 'سامانه وب درمانی'),
      tags: ['Django', 'Booking', 'Scheduling', 'MySQL'],
      color: Color(0xFF06B6D4),
      url: '',
      overview: L(
        'A Django-based online appointment scheduling platform for clinics. Clinic administrators define their available time slots on the website, and patients browse open appointments and reserve the time that suits them — replacing phone-based booking with a self-service digital flow.',
        'پلتفرم رزرو نوبت آنلاین مبتنی بر جنگو برای کلینیک‌ها. مسئول کلینیک زمان‌های خالی را در سایت تعیین می‌کند و بیماران با توجه به زمان‌های آزاد، هر وقت بخواهند نوبت می‌گیرند — جایگزین نوبت‌گیری تلفنی با فرآیند دیجیتال خودخدمت.',
      ),
      challenge: L(
        'Phone-only appointment booking caused double bookings, staff overhead, and patients unable to see real-time availability outside business hours.',
        'نوبت‌گیری فقط تلفنی باعث رزرو تکراری، بار کاری پرسنل و ناتوانی بیماران در دیدن زمان‌های آزاد خارج از ساعات کاری می‌شد.',
      ),
      solution: L(
        'Built with Django — admin panel for clinic managers to create and manage available slots, public booking interface for patients to view open times and confirm reservations, with slot locking to prevent conflicts.',
        'با جنگو — پنل مدیریت برای تعریف و مدیریت زمان‌های خالی، رابط عمومی برای مشاهده زمان‌های آزاد و تأیید رزرو، با قفل زمان برای جلوگیری از تداخل.',
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
        'فرانت Ionic برای پلتفرم IoT — اتصال دستگاه، تنظیمات از راه دور و هشدار ردیابی با اعلان فوری.',
      ),
      category: L('IoT Mobile App', 'اپ موبایل IoT'),
      tags: ['Ionic', 'IoT', 'Push Notifications', 'TypeScript'],
      color: Color(0xFF3B82F6),
      url: '',
      overview: L(
        'Frontend mobile application built with Ionic for an IoT security platform focused on alarm systems and GPS trackers. Users register devices in the app, connect to them over the network, and apply remote configuration settings. When a device detects a tracked event or trigger, it sends data to the backend server, which forwards real-time push notifications to the user\'s phone.',
        'اپ موبایل Ionic برای پلتفرم IoT امنیتی — دزدگیر و ردیاب GPS. کاربران دستگاه‌ها را در اپ تعریف، به آن‌ها متصل و تنظیمات از راه دور اعمال می‌کنند. وقتی دستگاه رویداد ردیابی را تشخیص دهد، داده به سرور ارسال و اعلان فوری به موبایل کاربر می‌رسد.',
      ),
      challenge: L(
        'IoT device management required a cross-platform mobile UI for pairing, live configuration, and instant alerts — without users needing technical knowledge of each tracker or alarm model.',
        'مدیریت دستگاه IoT به رابط موبایل چندسکویی برای اتصال، تنظیمات لحظه‌ای و هشدار فوری نیاز داشت — بدون نیاز به دانش فنی کاربر از هر مدل ردیاب یا دزدگیر.',
      ),
      solution: L(
        'Built the frontend with Ionic — device registration and connection flows, remote settings panels per device type, real-time sync with backend API, and push notification integration so users are instantly notified when tracking events occur.',
        'فرانت با Ionic — گردش ثبت و اتصال دستگاه، پنل تنظیمات از راه دور برای هر نوع دستگاه، همگام‌سازی لحظه‌ای با API بک‌اند و اعلان فوری هنگام رویدادهای ردیابی.',
      ),
      results: L(
        'Unified mobile control for alarms and trackers, remote device management from anywhere, and immediate push alerts when events are detected.',
        'کنترل یکپارچه موبایل دزدگیر و ردیاب، مدیریت از راه دور دستگاه از هر جا و هشدار فوری هنگام تشخیص رویداد.',
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
        'پروژه کارشناسی ارشد — پورتال Django DRF + React برای مدیریت درخواست و پذیرش استعدادهای درخشان در مقاطع کارشناسی ارشد و دکتری.',
      ),
      category: L('Academic Web App', 'سامانه وب دانشگاهی'),
      tags: ['Django', 'React', 'DRF', 'JWT'],
      color: Color(0xFF7C3AED),
      url: '',
      overview: L(
        'A full-stack web application developed as a master\'s degree thesis project. The platform manages application requests and admissions for gifted and outstanding students (استعدادهای درخشان) applying to MSc and PhD programs. Built with Django REST Framework on the backend and React on the frontend, it implements role-based access control across multiple user levels and secures all API endpoints with JWT authentication.',
        'اپلیکیشن وب فول‌استک به‌عنوان پروژه پایان‌نامه کارشناسی ارشد. پلتفرم مدیریت درخواست‌ها و پذیرش دانشجویان استعدادهای درخشان در مقاطع کارشناسی ارشد و دکتری. بک‌اند Django REST Framework و فرانت React، کنترل دسترسی نقش‌محور در سطوح مختلف کاربر و امنیت API با JWT.',
      ),
      challenge: L(
        'The gifted student admission process involved paper forms, manual review chains, and no centralized system for applicants, reviewers, and administrators across MSc and PhD tracks.',
        'فرآیند پذیرش استعدادهای درخشان شامل فرم کاغذی، زنجیره بررسی دستی و نبود سامانه متمرکز برای متقاضی، داور و مدیر در مقاطع ارشد و دکتری بود.',
      ),
      solution: L(
        'Designed and built with Django DRF + React — multi-role access levels (applicant, reviewer, admin), JWT-secured REST APIs, application submission and tracking workflows, admission decision management, and a modern SPA frontend for a smooth user experience.',
        'طراحی و ساخت با Django DRF + React — سطوح دسترسی چندنقشی (متقاضی، داور، مدیر)، REST API امن با JWT، گردش ثبت و پیگیری درخواست، مدیریت تصمیم پذیرش و رابط تک‌صفحه‌ای مدرن برای تجربه کاربری روان.',
      ),
      results: L(
        'A complete thesis deliverable digitizing the gifted student admission pipeline — secure, role-aware, and ready for university-scale deployment.',
        'تحویل کامل پروژه پایان‌نامه — دیجیتالی‌سازی مسیر پذیرش استعدادهای درخشان، امن، نقش‌محور و آماده استقرار در مقیاس دانشگاه.',
      ),
      myRole: L('Full-Stack Developer (Thesis)', 'توسعه‌دهنده فول‌استک (پایان‌نامه)'),
      duration: L('Master\'s thesis', 'کارشناسی ارشد'),
      imageAsset: 'assets/images/projects/gifted-students.jpg',
      isFeatured: false,
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
      isFeatured: false,
    ),
    ProjectItem(
      id: 'jet-printer-excel-flutter',
      title: L('Jet Printer Excel & Scan Verification', 'چاپ از اکسل با چاپگر صنعتی و تأیید با اسکنر'),
      description: L(
        'Flutter desktop app — reads Excel files, sends print commands to industrial Jet Printers, and verifies output with a barcode scanner.',
        'اپ دسکتاپ Flutter — فایل اکسل را می‌خواند، به چاپگر صنعتی دستور چاپ می‌دهد و خروجی را با اسکنر بارکد تأیید می‌کند.',
      ),
      category: L('Industrial Desktop App', 'اپ دسکتاپ صنعتی'),
      tags: ['Flutter', 'Excel', 'Jet Printer', 'Barcode Scanner'],
      color: Color(0xFF14B8A6),
      url: '',
      overview: L(
        'A Flutter desktop application for production-line labeling workflows. Operators upload Excel files containing product data; the app parses rows and sends formatted print jobs to industrial Jet Printers. After printing, a barcode scanner verifies that the label was applied correctly — closing the loop between data import, print execution, and quality control.',
        'اپ دسکتاپ Flutter برای گردش کار برچسب‌گذاری خط تولید. اپراتور فایل اکسل حاوی داده محصول را بارگذاری می‌کند؛ اپ سطرها را پردازش و دستور چاپ فرمت‌شده به چاپگر صنعتی می‌فرستد. پس از چاپ، اسکنر بارکد صحت اعمال برچسب را بررسی می‌کند — بستن حلقه بین ورود داده، اجرای چاپ و کنترل کیفیت.',
      ),
      challenge: L(
        'Manual label printing from spreadsheets caused misprints, no verification step, and slow handoff between office data and the production floor.',
        'چاپ دستی برچسب از اکسل باعث چاپ اشتباه، نبود مرحله تأیید و انتقال کند داده بین دفتر و خط تولید می‌شد.',
      ),
      solution: L(
        'Built with Flutter — Excel parsing and batch queue management, Jet Printer driver integration for industrial print commands, scanner input for post-print barcode verification, and operator-friendly UI for daily production use.',
        'با Flutter — پردازش اکسل و مدیریت صف چاپ، اتصال چاپگر صنعتی، ورودی اسکنر برای تأیید بارکد پس از چاپ، و رابط مناسب اپراتور برای استفاده روزانه تولید.',
      ),
      results: L(
        'Automated Excel-to-printer pipeline, reduced labeling errors, and verified print quality on every unit before it leaves the line.',
        'خط لوله خودکار از اکسل تا چاپگر، کاهش خطای برچسب و تأیید کیفیت چاپ روی هر واحد قبل از خروج از خط.',
      ),
      myRole: L('Flutter Developer', 'توسعه‌دهنده Flutter'),
      duration: L('Production system', 'سامانه عملیاتی'),
      imageAsset: 'assets/images/projects/nitka1.png',
      galleryAssets: [
        'assets/images/projects/nitka2.png',
      ],
      isFeatured: false,
    ),
    ProjectItem(
      id: 'barcode-label-print-pyside',
      title: L('Barcode-Triggered Label Printer', 'چاپ برچسب با محرک بارکد'),
      description: L(
        'Python PySide desktop app — barcode scanner reads a code and the system sends user-configured label data to a printer.',
        'اپ دسکتاپ پایتون/PySide — اسکنر بارکد را می‌خواند و سیستم اطلاعات از پیش تعیین‌شده را به چاپگر ارسال می‌کند.',
      ),
      category: L('Industrial Desktop App', 'اپ دسکتاپ صنعتی'),
      tags: ['Python', 'PySide', 'Barcode Scanner', 'Label Printer'],
      color: Color(0xFF64748B),
      url: '',
      overview: L(
        'A lightweight Python desktop utility built with PySide for warehouse and production environments. A barcode scanner reads product or batch codes; based on mappings the user configures in advance, the system automatically formats and sends the corresponding label content to a connected printer — no manual copy-paste between systems.',
        'ابزار دسکتاپ سبک پایتون با PySide برای انبار و تولید. اسکنر بارکد کد محصول یا دسته را می‌خواند؛ بر اساس نگاشت از پیش تعریف‌شده توسط کاربر، سیستم خودکار محتوای برچسب را فرمت و به چاپگر متصل ارسال می‌کند — بدون کپی دستی بین سیستم‌ها.',
      ),
      challenge: L(
        'Operators had to look up barcode values manually and re-enter label text for every scan — slow, error-prone, and unsuitable for high-volume labeling.',
        'اپراتورها باید مقدار بارکد را دستی پیدا و متن برچسب را برای هر اسکن دوباره وارد می‌کردند — کند، خطاپذیر و نامناسب برای حجم بالای برچسب‌گذاری.',
      ),
      solution: L(
        'Built with Python and PySide — configurable barcode-to-label mapping table, real-time scanner input handling, print template engine, and direct printer dispatch so each scan triggers the correct label instantly.',
        'با پایتون و PySide — جدول نگاشت بارکد به برچسب قابل تنظیم، پردازش لحظه‌ای ورودی اسکنر، موتور قالب چاپ و ارسال مستقیم به چاپگر تا هر اسکن فوراً برچسب درست را چاپ کند.',
      ),
      results: L(
        'One-scan-one-label workflow, eliminated manual data entry, and faster throughput on the production floor.',
        'گردش یک اسکن — یک برچسب، حذف ورود دستی داده و سرعت بیشتر در خط تولید.',
      ),
      myRole: L('Python Developer', 'توسعه‌دهنده پایتون'),
      duration: L('Production system', 'سامانه عملیاتی'),
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
      role: L('Python Developer', 'توسعه‌دهنده پایتون'),
      period: L('Jul 2024 — Present', 'تیر ۱۴۰۳ — اکنون'),
      description: L(
        'Python developer at Supishi (UK Domino\'s franchise). Built product tracking and warehouse management systems, mission form digitization (supishi.net), Excel-to-Jet-Printer automation, and barcode-triggered label printing tools.',
        'توسعه‌دهنده پایتون در سوپیشی. ساخت سامانه رهگیری و انبار، دیجیتال‌سازی فرم مأموریت (supishi.net)، خودکارسازی اکسل به چاپگر صنعتی و چاپ برچسب با اسکن بارکد.',
      ),
      isCurrent: true,
      relatedProjectIds: [
        'product-tracking',
        'warehouse-management',
        'business-automation-suite',
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
      role: L('Python Developer — Internship', 'برنامه‌نویس پایتون — کارآموزی'),
      period: L('May — Jul 2022', 'اردیبهشت — تیر ۱۴۰۱'),
      description: L(
        'University internship — Python development with Django and AI. Main deliverable: training and deploying a YOLO model for automatic license plate detection in images and video.',
        'دوره کارآموزی دانشگاه — توسعه پایتون با جنگو و هوش مصنوعی. دستاورد اصلی: آموزش و استقرار مدل YOLO برای تشخیص خودکار پلاک خودرو در تصویر و ویدیو.',
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
        'توسعه‌دهنده موبایل با JavaScript و Ionic — ساخت اپ کنترل ردیاب و دزدگیر IoT برای ثبت دستگاه، تنظیمات از راه دور و اعلان فوری هنگام رویدادهای ردیابی.',
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
        'چشم‌انداز ما را به یک اپ خیره‌کننده تبدیل کرد. برای هر پروژه Flutter توصیه می‌کنم.',
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
    'AI APIs',
    'Automation',
    'MySQL',
    'Redis',
    'React',
    'Flutter',
    'OpenCV',
    'Git',
  ];

  static const services = [
    ServiceItem(
      title: L('AI Automation Solutions', 'خودکارسازی و راه‌حل هوش مصنوعی'),
      description: L(
        'Add AI to your business without hiring a full AI team — chat assistants, smart workflows, and content tools inside your app.',
        'هوش مصنوعی را بدون استخدام تیم کامل به کسب‌وکار اضافه کنید — دستیار چت، گردش کار هوشمند و ابزار تولید محتوا.',
      ),
      problems: [
        L(
          '"I want an AI assistant that answers customer questions based on my product docs"',
          '«می‌خواهم دستیار هوش مصنوعی سوالات مشتری را بر اساس مستندات محصول پاسخ دهد»',
        ),
        L(
          '"We manually copy data from emails into our system every day"',
          '«هر روز دستی داده را از ایمیل به سیستم کپی می‌کنیم»',
        ),
        L(
          '"I need AI-powered content generation inside my existing Django app"',
          '«به تولید محتوای هوش مصنوعی داخل اپ جنگو موجود نیاز دارم»',
        ),
      ],
      icon: Icons.psychology_outlined,
      color: Color(0xFF6366F1),
    ),
    ServiceItem(
      title: L('Python Web Scraping & Data Automation', 'جمع‌آوری داده و خودکارسازی'),
      description: L(
        'Stop manually collecting data from websites and files — get clean spreadsheets or database updates on a schedule.',
        'دیگر دستی از وب و فایل داده جمع نکنید — فایل اکسل تمیز یا به‌روزرسانی پایگاه داده به‌صورت زمان‌بندی‌شده.',
      ),
      problems: [
        L(
          '"I spend 2 hours daily copying prices from competitor websites"',
          '«هر روز ۲ ساعت قیمت رقبا را دستی کپی می‌کنم»',
        ),
        L(
          '"I need product data extracted from 50 URLs into a spreadsheet every week"',
          '«هر هفته داده ۵۰ آدرس وب را در اکسل می‌خواهم»',
        ),
        L(
          '"Our team manually updates inventory from supplier portals"',
          '«تیم دستی موجودی را از پورتال تأمین‌کننده به‌روز می‌کند»',
        ),
      ],
      icon: Icons.cloud_download_outlined,
      color: Color(0xFF0D9488),
    ),
    ServiceItem(
      title: L('Django Backend Development', 'توسعه بک‌اند جنگو'),
      description: L(
        'Replace broken spreadsheets and email workflows with a web app your team can use every day.',
        'اکسل و گردش کار ایمیلی خراب را با وب‌اپی جایگزین کنید که تیم هر روز از آن استفاده کند.',
      ),
      problems: [
        L(
          '"We track everything in Google Sheets and it\'s breaking"',
          '«همه‌چیز در Google Sheets است و دارد از هم می‌پاشد»',
        ),
        L(
          '"I need an internal tool for my team to manage orders and customers"',
          '«به ابزار داخلی برای مدیریت سفارش و مشتری نیاز دارم»',
        ),
        L(
          '"Our approval process is email chains — I need a proper workflow"',
          '«تأییدها زنجیره ایمیل است — به گردش کار درست نیاز دارم»',
        ),
      ],
      icon: Icons.dns_outlined,
      color: Color(0xFF059669),
    ),
    ServiceItem(
      title: L('Business Management Systems', 'سامانه مدیریت کسب‌وکار'),
      description: L(
        'Inventory, tracking, and operations software built around how your business actually works.',
        'نرم‌افزار موجودی، رهگیری و عملیات متناسب با واقعیت کار شما.',
      ),
      problems: [
        L(
          '"We don\'t know where our products are after they leave the factory"',
          '«نمی‌دانیم محصول بعد از کارخانه کجاست»',
        ),
        L(
          '"Our warehouse team uses Excel and counts are always wrong"',
          '«تیم انبار Excel دارد و موجودی همیشه غلط است»',
        ),
        L(
          '"I need digital client sign-off for field missions"',
          '«به تأیید دیجیتال مشتری برای مأموریت میدانی نیاز دارم»',
        ),
      ],
      icon: Icons.inventory_2_outlined,
      color: Color(0xFF8B5CF6),
    ),
    ServiceItem(
      title: L('API Integration & Workflow Automation', 'اتصال API و خودکارسازی'),
      description: L(
        'Make your printer, CRM, SMS, and database work together — no more copy-paste between tools.',
        'پرینتر، CRM، پیامک و پایگاه داده را به هم وصل کنید — بدون کپی دستی بین ابزارها.',
      ),
      problems: [
        L(
          '"When a form is submitted, I need SMS + email + database update automatically"',
          '«با ثبت فرم، پیامک + ایمیل + پایگاه داده خودکار به‌روز شود»',
        ),
        L(
          '"Our label printer needs to read from Excel but the process is manual"',
          '«چاپگر برچسب باید از اکسل بخواند اما فرآیند دستی است»',
        ),
        L(
          '"I use 3 tools that don\'t talk to each other — I need them connected"',
          '«۳ ابزار دارم که به هم وصل نیستند»',
        ),
      ],
      icon: Icons.hub_outlined,
      color: Color(0xFFF59E0B),
    ),
  ];
}
