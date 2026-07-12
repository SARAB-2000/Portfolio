import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/portfolio_data.dart';
import '../data/skill_icons.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/skill_icon_widget.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _groupIcons = [
    Icons.dns_outlined,
    Icons.devices_outlined,
    Icons.psychology_outlined,
    Icons.build_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = MediaQuery.sizeOf(context).width > 900;
    final groups = PortfolioData.skillGroups;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 48 : 24,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppTheme.accent.withValues(alpha: 0.03),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: l10n.sectionSkills,
            subtitle: l10n.sectionSkillsSubtitle,
          ),
          const SizedBox(height: 48),
          ...groups.asMap().entries.map((entry) {
            final index = entry.key;
            final group = entry.value;
            final icon = index < _groupIcons.length
                ? _groupIcons[index]
                : Icons.category_outlined;

            return Padding(
              padding: EdgeInsets.only(bottom: index < groups.length - 1 ? 40 : 0),
              child: _SkillGroupBlock(
                group: group,
                icon: icon,
                index: index,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _SkillGroupBlock extends StatelessWidget {
  const _SkillGroupBlock({
    required this.group,
    required this.icon,
    required this.index,
  });

  final SkillGroup group;
  final IconData icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
            decoration: BoxDecoration(
              color: colors.surface.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: colors.border.withValues(alpha: 0.75),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accent.withValues(alpha: 0.05),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.start,
              children: [
                for (final skill in group.skills) _SkillTile(skill: skill),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          start: 20,
          top: 0,
          child: _GroupBorderTitle(
            icon: icon,
            title: group.title.of(context),
            countLabel: l10n.skillsCount(group.skills.length),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(delay: (index * 100).ms)
        .slideY(begin: 0.05, end: 0);
  }
}

class _GroupBorderTitle extends StatelessWidget {
  const _GroupBorderTitle({
    required this.icon,
    required this.title,
    required this.countLabel,
  });

  final IconData icon;
  final String title;
  final String countLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: colors.background,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient.scale(0.9),
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accent.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppTheme.accent.withValues(alpha: 0.25)),
            ),
            child: Text(
              countLabel,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillTile extends StatefulWidget {
  const _SkillTile({required this.skill});

  final SkillItem skill;

  @override
  State<_SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<_SkillTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final brand = skillBrandFor(widget.skill.name);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedSlide(
        offset: _hovered ? const Offset(0, -0.06) : Offset.zero,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: _hovered
              ? AppTheme.accent.withValues(alpha: 0.10)
              : colors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? AppTheme.accent.withValues(alpha: 0.45)
                : colors.border.withValues(alpha: 0.65),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: brand.color.withValues(alpha: 0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: _hovered ? 1.12 : 1.0,
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutBack,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _hovered
                        ? brand.color.withValues(alpha: 0.35)
                        : colors.border.withValues(alpha: 0.5),
                  ),
                ),
                child: SkillIconWidget(skillName: widget.skill.name, size: 28),
              ),
            ),
            const SizedBox(height: 12),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: TextStyle(
                fontSize: 11,
                fontWeight: _hovered ? FontWeight.w700 : FontWeight.w600,
                color: _hovered ? AppTheme.accent : colors.textPrimary,
                height: 1.35,
              ),
              child: Text(
                widget.skill.name,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
