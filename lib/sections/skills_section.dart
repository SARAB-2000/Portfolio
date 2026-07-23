import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/portfolio_data.dart';
import '../data/skill_icons.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/skill_icon_widget.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> with TickerProviderStateMixin {
  static const _groupIcons = [
    Icons.dns_outlined,
    Icons.devices_outlined,
    Icons.psychology_outlined,
    Icons.build_outlined,
  ];

  static const _categoryColors = [
    AppTheme.accent,
    AppTheme.accentSecondary,
    AppTheme.accentTertiary,
    Color(0xFFF59E0B),
  ];

  static const _autoRotateInterval = Duration(seconds: 4);
  static const _resumeAfterManualTap = Duration(seconds: 10);

  int _selectedIndex = 0;
  bool _autoRotateEnabled = true;
  Timer? _resumeTimer;
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: _autoRotateInterval,
    )..addStatusListener(_onProgressCompleted);
    _startAutoRotate();
  }

  void _onProgressCompleted(AnimationStatus status) {
    if (status != AnimationStatus.completed || !_autoRotateEnabled || !mounted) return;
    setState(() {
      _selectedIndex = (_selectedIndex + 1) % PortfolioData.skillGroups.length;
    });
    _progressController.forward(from: 0);
  }

  void _startAutoRotate() {
    _autoRotateEnabled = true;
    _progressController.forward(from: 0);
  }

  void _pauseAutoRotate({required bool scheduleResume}) {
    _autoRotateEnabled = false;
    _progressController.stop();
    _resumeTimer?.cancel();
    if (!scheduleResume) return;
    _resumeTimer = Timer(_resumeAfterManualTap, () {
      if (mounted) {
        setState(() {});
        _startAutoRotate();
      }
    });
  }

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
    _pauseAutoRotate(scheduleResume: true);
  }

  @override
  void dispose() {
    _resumeTimer?.cancel();
    _progressController
      ..removeStatusListener(_onProgressCompleted)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = MediaQuery.sizeOf(context).width > 900;
    final groups = PortfolioData.skillGroups;
    final selectedGroup = groups[_selectedIndex];
    final accent = _categoryColors[_selectedIndex % _categoryColors.length];

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
            accent.withValues(alpha: 0.04),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: SectionHeader(
              title: l10n.sectionSkills,
              subtitle: l10n.sectionSkillsSubtitle,
            ),
          ),
          const SizedBox(height: 40),
          _CategoryTabs(
            groups: groups,
            icons: _groupIcons,
            colors: _categoryColors,
            selectedIndex: _selectedIndex,
            progress: _autoRotateEnabled ? _progressController : null,
            onSelected: _onTabSelected,
          ),
          const SizedBox(height: 24),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: _SkillCloudPanel(
              key: ValueKey(_selectedIndex),
              group: selectedGroup,
              icon: _groupIcons[_selectedIndex],
              accent: accent,
              countLabel: l10n.skillsCount(selectedGroup.skills.length),
            ),
          ),
          if (isWide) ...[
            const SizedBox(height: 36),
            _SkillsOverviewStrip(
              groups: groups,
              icons: _groupIcons,
              colors: _categoryColors,
              selectedIndex: _selectedIndex,
              onSelected: _onTabSelected,
            ),
          ],
          const SizedBox(height: 28),
          _TabDotIndicator(
            count: groups.length,
            selectedIndex: _selectedIndex,
            colors: _categoryColors,
            progress: _autoRotateEnabled ? _progressController : null,
          ),
        ],
      ),
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs({
    required this.groups,
    required this.icons,
    required this.colors,
    required this.selectedIndex,
    required this.progress,
    required this.onSelected,
  });

  final List<SkillGroup> groups;
  final List<IconData> icons;
  final List<Color> colors;
  final int selectedIndex;
  final Animation<double>? progress;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (var i = 0; i < groups.length; i++) ...[
            if (i > 0) const SizedBox(width: 10),
            _CategoryTab(
              title: groups[i].title.of(context),
              icon: icons[i],
              accent: colors[i % colors.length],
              selected: i == selectedIndex,
              progress: i == selectedIndex ? progress : null,
              onTap: () => onSelected(i),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.08, end: 0);
  }
}

class _CategoryTab extends StatelessWidget {
  const _CategoryTab({
    required this.title,
    required this.icon,
    required this.accent,
    required this.selected,
    required this.progress,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color accent;
  final bool selected;
  final Animation<double>? progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final tab = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
          decoration: BoxDecoration(
            gradient: selected
                ? LinearGradient(
                    colors: [accent, accent.withValues(alpha: 0.75)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: selected ? null : colors.surfaceLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? accent.withValues(alpha: 0.5)
                  : accent.withValues(alpha: 0.22),
              width: selected ? 1 : 1.2,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.28),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected ? Colors.white : accent,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (selected && progress != null) {
      return AnimatedBuilder(
        animation: progress!,
        builder: (context, child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              child!,
              Positioned(
                left: 8,
                right: 8,
                bottom: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: LinearProgressIndicator(
                    value: progress!.value,
                    minHeight: 3,
                    backgroundColor: Colors.white.withValues(alpha: 0.18),
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
        child: tab,
      );
    }

    if (!selected) {
      return tab
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .shimmer(
            duration: 1800.ms,
            color: accent.withValues(alpha: 0.08),
          );
    }

    return tab;
  }
}

class _TabDotIndicator extends StatelessWidget {
  const _TabDotIndicator({
    required this.count,
    required this.selectedIndex,
    required this.colors,
    required this.progress,
  });

  final int count;
  final int selectedIndex;
  final List<Color> colors;
  final Animation<double>? progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          _Dot(
            active: i == selectedIndex,
            color: colors[i % colors.length],
            progress: i == selectedIndex ? progress : null,
          ),
        ],
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.active,
    required this.color,
    required this.progress,
  });

  final bool active;
  final Color color;
  final Animation<double>? progress;

  @override
  Widget build(BuildContext context) {
    if (!active) {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.25),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
      );
    }

    if (progress == null) {
      return Container(
        width: 24,
        height: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color,
        ),
      );
    }

    return AnimatedBuilder(
      animation: progress!,
      builder: (context, _) {
        return Container(
          width: 24,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: color.withValues(alpha: 0.2),
          ),
          alignment: AlignmentDirectional.centerStart,
          child: FractionallySizedBox(
            widthFactor: progress!.value.clamp(0.08, 1),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: color,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SkillCloudPanel extends StatelessWidget {
  const _SkillCloudPanel({
    super.key,
    required this.group,
    required this.icon,
    required this.accent,
    required this.countLabel,
  });

  final SkillGroup group;
  final IconData icon;
  final Color accent;
  final String countLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isCompact = MediaQuery.sizeOf(context).width < 640;

    return GlassCard(
      padding: EdgeInsets.fromLTRB(isCompact ? 18 : 28, 24, isCompact ? 18 : 28, 24),
      borderRadius: 22,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PositionedDirectional(
            end: -20,
            bottom: -24,
            child: Icon(
              icon,
              size: 140,
              color: accent.withValues(alpha: 0.06),
            ),
          ),
          isCompact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _CategorySidebar(
                      group: group,
                      icon: icon,
                      accent: accent,
                      countLabel: countLabel,
                      horizontal: true,
                    ),
                    const SizedBox(height: 20),
                    _SkillsWrap(group: group, accent: accent),
                  ],
                )
              : IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _CategorySidebar(
                        group: group,
                        icon: icon,
                        accent: accent,
                        countLabel: countLabel,
                      ),
                      const SizedBox(width: 24),
                      VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: colors.border.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: _SkillsWrap(group: group, accent: accent),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class _CategorySidebar extends StatelessWidget {
  const _CategorySidebar({
    required this.group,
    required this.icon,
    required this.accent,
    required this.countLabel,
    this.horizontal = false,
  });

  final SkillGroup group;
  final IconData icon;
  final Color accent;
  final String countLabel;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final iconBox = Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accent, accent.withValues(alpha: 0.7)],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );

    final textBlock = Column(
      crossAxisAlignment:
          horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          group.title.of(context),
          textAlign: horizontal ? TextAlign.start : TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          countLabel,
          textAlign: horizontal ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: colors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    if (horizontal) {
      return Row(
        children: [
          iconBox,
          const SizedBox(width: 14),
          Expanded(child: textBlock),
        ],
      );
    }

    return SizedBox(
      width: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconBox,
          const SizedBox(height: 16),
          textBlock,
        ],
      ),
    );
  }
}

class _SkillsWrap extends StatelessWidget {
  const _SkillsWrap({
    required this.group,
    required this.accent,
  });

  final SkillGroup group;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10,
      runSpacing: 10,
      children: [
        for (var i = 0; i < group.skills.length; i++)
          _SkillChip(
            skill: group.skills[i],
            accent: accent,
            index: i,
          ),
      ],
    );
  }
}

class _SkillChip extends StatefulWidget {
  const _SkillChip({
    required this.skill,
    required this.accent,
    required this.index,
  });

  final SkillItem skill;
  final Color accent;
  final int index;

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final brand = skillBrandFor(widget.skill.name);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: _hovered
              ? widget.accent.withValues(alpha: 0.12)
              : colors.surfaceLight,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: _hovered
                ? brand.color.withValues(alpha: 0.5)
                : colors.border.withValues(alpha: 0.8),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: brand.color.withValues(alpha: 0.15),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _hovered
                      ? brand.color.withValues(alpha: 0.35)
                      : colors.border.withValues(alpha: 0.5),
                ),
              ),
              child: SkillIconWidget(skillName: widget.skill.name, size: 18),
            ),
            const SizedBox(width: 8),
            Text(
              widget.skill.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: _hovered ? FontWeight.w700 : FontWeight.w600,
                color: _hovered ? widget.accent : colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: (widget.index * 35).ms)
        .scale(
          begin: const Offset(0.92, 0.92),
          end: const Offset(1, 1),
          delay: (widget.index * 35).ms,
          curve: Curves.easeOutBack,
        );
  }
}

class _SkillsOverviewStrip extends StatelessWidget {
  const _SkillsOverviewStrip({
    required this.groups,
    required this.icons,
    required this.colors,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<SkillGroup> groups;
  final List<IconData> icons;
  final List<Color> colors;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final themeColors = context.colors;

    return Row(
      children: [
        for (var i = 0; i < groups.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onSelected(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  decoration: BoxDecoration(
                    color: i == selectedIndex
                        ? colors[i].withValues(alpha: 0.1)
                        : themeColors.surfaceLight.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: i == selectedIndex
                          ? colors[i].withValues(alpha: 0.45)
                          : themeColors.border.withValues(alpha: 0.6),
                      width: i == selectedIndex ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(icons[i], size: 20, color: colors[i]),
                      const SizedBox(height: 8),
                      Text(
                        '${groups[i].skills.length}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: colors[i],
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        groups[i].title.of(context),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: themeColors.textSecondary,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.06, end: 0);
  }
}
