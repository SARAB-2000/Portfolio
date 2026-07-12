import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/skill_icons.dart';
import '../theme/app_theme.dart';

/// Renders the official brand logo via Simple Icons CDN.
class SkillIconWidget extends StatelessWidget {
  const SkillIconWidget({
    super.key,
    required this.skillName,
    this.size = 20,
  });

  final String skillName;
  final double size;

  @override
  Widget build(BuildContext context) {
    final brand = skillBrandFor(skillName);
    final url = skillIconCdnUrl(brand);

    return SvgPicture.network(
      url,
      width: size,
      height: size,
      placeholderBuilder: (_) => SizedBox(
        width: size,
        height: size,
        child: Center(
          child: SizedBox(
            width: size * 0.5,
            height: size * 0.5,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: AppTheme.accent.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
      // CDN SVGs already include brand colors.
      errorBuilder: (context, error, stackTrace) => _FallbackBadge(
        label: skillName.isNotEmpty ? skillName[0].toUpperCase() : '?',
        size: size,
        color: skillIconColor(context, brand.color),
      ),
    );
  }
}

class _FallbackBadge extends StatelessWidget {
  const _FallbackBadge({
    required this.label,
    required this.size,
    required this.color,
  });

  final String label;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: size * 0.55,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}
