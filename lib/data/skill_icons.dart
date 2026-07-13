import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Brand slug + color for Simple Icons CDN (https://cdn.simpleicons.org).
class SkillBrand {
  const SkillBrand({required this.slug, required this.color});

  /// Simple Icons slug — see https://simpleicons.org
  final String slug;
  final Color color;
}

SkillBrand skillBrandFor(String name) {
  final resolved = _aliases[name] ?? name;
  return _brands[resolved] ??
      const SkillBrand(slug: 'codeigniter', color: AppTheme.accent);
}

const _aliases = {
  'DRF': 'Django REST Framework',
  'Django REST': 'Django REST Framework',
  'REST API': 'Postman',
  'Web': 'HTML',
  'Excel': 'Microsoft Excel',
  'SMS API': 'Twilio',
  'IoT': 'Firebase',
  'Push Notifications': 'Firebase',
  'PySide': 'Qt',
};

String skillIconCdnUrl(SkillBrand brand) {
  return 'https://cdn.simpleicons.org/${brand.slug}';
}

Color skillIconColor(BuildContext context, Color brandColor) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  if (isDark && brandColor.computeLuminance() < 0.15) {
    return context.colors.textPrimary.withValues(alpha: 0.85);
  }
  return brandColor;
}

final Map<String, SkillBrand> _brands = {
  'Python': SkillBrand(slug: 'python', color: Color(0xFF3776AB)),
  'Django': SkillBrand(slug: 'django', color: Color(0xFF092E20)),
  'Django REST Framework': SkillBrand(slug: 'django', color: Color(0xFF092E20)),
  'Redis': SkillBrand(slug: 'redis', color: Color(0xFFFF4438)),
  'Celery': SkillBrand(slug: 'celery', color: Color(0xFF37814A)),
  'MySQL': SkillBrand(slug: 'mysql', color: Color(0xFF4479A1)),
  'PostgreSQL': SkillBrand(slug: 'postgresql', color: Color(0xFF4169E1)),
  'JWT': SkillBrand(slug: 'jsonwebtokens', color: Color(0xFF000000)),
  'JavaScript': SkillBrand(slug: 'javascript', color: Color(0xFFF7DF1E)),
  'HTML': SkillBrand(slug: 'html5', color: Color(0xFFE34F26)),
  'CSS': SkillBrand(slug: 'css', color: Color(0xFF663399)),
  'React': SkillBrand(slug: 'react', color: Color(0xFF61DAFB)),
  'Redux': SkillBrand(slug: 'redux', color: Color(0xFF764ABC)),
  'Flutter': SkillBrand(slug: 'flutter', color: Color(0xFF02569B)),
  'Dart': SkillBrand(slug: 'dart', color: Color(0xFF0175C2)),
  'Ionic': SkillBrand(slug: 'ionic', color: Color(0xFF3880FF)),
  'TypeScript': SkillBrand(slug: 'typescript', color: Color(0xFF3178C6)),
  'Electron.js': SkillBrand(slug: 'electron', color: Color(0xFF47848F)),
  'YOLO': SkillBrand(slug: 'ultralytics', color: Color(0xFF111F68)),
  'OpenCV': SkillBrand(slug: 'opencv', color: Color(0xFF5C3EE8)),
  'PyTorch': SkillBrand(slug: 'pytorch', color: Color(0xFFEE4C2C)),
  'AI APIs': SkillBrand(slug: 'huggingface', color: Color(0xFFFFD21E)),
  'Git': SkillBrand(slug: 'git', color: Color(0xFFF05032)),
  'Postman': SkillBrand(slug: 'postman', color: Color(0xFFFF6C37)),
  'Docker': SkillBrand(slug: 'docker', color: Color(0xFF2496ED)),
  'Microsoft Excel': SkillBrand(slug: 'microsoftexcel', color: Color(0xFF217346)),
  'Twilio': SkillBrand(slug: 'twilio', color: Color(0xFFF22F46)),
  'Firebase': SkillBrand(slug: 'firebase', color: Color(0xFFFFCA28)),
  'Qt': SkillBrand(slug: 'qt', color: Color(0xFF41CD52)),
};
