import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class PortfolioNavBar extends StatelessWidget {
  const PortfolioNavBar({
    super.key,
    required this.onNavTap,
    required this.onLanguageToggle,
    required this.isScrolled,
    this.onMenuTap,
  });

  final void Function(String section) onNavTap;
  final VoidCallback onLanguageToggle;
  final bool isScrolled;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final isWide = MediaQuery.sizeOf(context).width > 1100;
    final isDark = context.watch<ThemeProvider>().isDark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 48 : 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: isScrolled ? colors.navScrolled : Colors.transparent,
        border: isScrolled
            ? Border(bottom: BorderSide(color: colors.border.withValues(alpha: 0.5)))
            : null,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onNavTap('home'),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                ),
                if (isWide) ...[
                  const SizedBox(width: 10),
                  Text(
                    l10n.appTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isWide) ...[
            const SizedBox(width: 28),
            Row(
              children: [
                _NavLink(l10n.navProjects, () => onNavTap('projects')),
                _NavLink(l10n.navSkills, () => onNavTap('skills')),
                _NavLink(l10n.navExperience, () => onNavTap('experience')),
                _NavLink(l10n.navEducation, () => onNavTap('education')),
                // _NavLink(l10n.navTestimonials, () => onNavTap('testimonials')),
                _NavLink(l10n.navContact, () => onNavTap('contact')),
              ],
            ),
          ],
          const Spacer(),
          if (!isWide && onMenuTap != null)
            IconButton(
              onPressed: onMenuTap,
              icon: Icon(Icons.menu_rounded, color: colors.textPrimary),
            ),
          const SizedBox(width: 8),
          _IconToggleButton(
            icon: isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            tooltip: isDark ? l10n.themeToggleLight : l10n.themeToggleDark,
            onTap: () => context.read<ThemeProvider>().toggleTheme(),
          ),
          const SizedBox(width: 8),
          _LanguageButton(
            label: l10n.languageToggle,
            onTap: onLanguageToggle,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0);
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink(this.label, this.onTap);

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? colors.surfaceLight.withValues(alpha: 0.8) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hovered ? colors.textPrimary : colors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _IconToggleButton extends StatelessWidget {
  const _IconToggleButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(8),
            color: colors.surfaceLight.withValues(alpha: 0.5),
          ),
          child: Icon(icon, size: 18, color: AppTheme.accent),
        ),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(8),
          color: colors.surfaceLight.withValues(alpha: 0.5),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: AppTheme.accent,
          ),
        ),
      ),
    );
  }
}
