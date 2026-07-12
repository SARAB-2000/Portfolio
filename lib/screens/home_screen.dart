import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import '../sections/contact_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
// import '../sections/testimonials_section.dart';
import '../theme/app_colors.dart';
import '../widgets/dev_portfolio_background.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'projects': GlobalKey(),
    'skills': GlobalKey(),
    'experience': GlobalKey(),
    'education': GlobalKey(),
    // 'testimonials': GlobalKey(),
    'contact': GlobalKey(),
  };

  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _scrollToSection(String section) {
    _scaffoldKey.currentState?.closeDrawer();
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Scaffold(
      key: _scaffoldKey,
      drawer: MediaQuery.sizeOf(context).width <= 768
          ? Drawer(
              backgroundColor: colors.surface,
              child: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Text(
                      l10n.appTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 24),
                    _DrawerTile(l10n.navProjects, () => _scrollToSection('projects')),
                    _DrawerTile(l10n.navSkills, () => _scrollToSection('skills')),
                    _DrawerTile(l10n.navExperience, () => _scrollToSection('experience')),
                    _DrawerTile(l10n.navEducation, () => _scrollToSection('education')),
                    // _DrawerTile(l10n.navTestimonials, () => _scrollToSection('testimonials')),
                    _DrawerTile(l10n.navContact, () => _scrollToSection('contact')),
                    const Divider(height: 32),
                    _DrawerTile(
                      context.watch<ThemeProvider>().isDark
                          ? l10n.themeToggleLight
                          : l10n.themeToggleDark,
                      () => context.read<ThemeProvider>().toggleTheme(),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: Stack(
        children: [
          const Positioned.fill(child: DevPortfolioBackground()),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.paddingOf(context).top + 72),
                    KeyedSubtree(
                      key: _sectionKeys['home'],
                      child: HeroSection(
                        onViewProjects: () => _scrollToSection('projects'),
                        onContact: () => _scrollToSection('contact'),
                      ),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['projects'],
                      child: const ProjectsSection(),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['skills'],
                      child: const SkillsSection(),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['experience'],
                      child: const ExperienceSection(),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['education'],
                      child: const EducationSection(),
                    ),
                    // KeyedSubtree(
                    //   key: _sectionKeys['testimonials'],
                    //   child: const TestimonialsSection(),
                    // ),
                    KeyedSubtree(
                      key: _sectionKeys['contact'],
                      child: const ContactSection(),
                    ),
                    const FooterSection(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(
              onNavTap: _scrollToSection,
              onLanguageToggle: () =>
                  context.read<LocaleProvider>().toggleLocale(),
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
              isScrolled: _isScrolled,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile(this.label, this.onTap);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 14, color: context.colors.textSecondary),
      onTap: onTap,
    );
  }
}
