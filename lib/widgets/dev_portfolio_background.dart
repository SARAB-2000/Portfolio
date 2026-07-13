import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/skill_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Decorative developer-themed background — grid, code snippets, tech icons.
class DevPortfolioBackground extends StatelessWidget {
  const DevPortfolioBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textFade = isDark ? 0.07 : 0.055;
    final iconFade = isDark ? 0.14 : 0.10;
    final gridFade = isDark ? 0.10 : 0.07;

    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: _DotGridPainter(
              color: colors.border.withValues(alpha: gridFade),
              spacing: 36,
            ),
          ),
          ..._glowOrbs(),
          ..._codeSnippets(textFade),
          ..._techIconBadges(context, iconFade),
          ..._deviceSilhouettes(context, isDark),
          ..._decorWindows(context, isDark),
        ],
      ),
    );
  }

  List<Widget> _glowOrbs() {
    return [
      Positioned(
        top: -120,
        left: -100,
        child: _GlowOrb(
          size: 420,
          color: AppTheme.accent.withValues(alpha: 0.07),
        ),
      ),
      Positioned(
        top: 280,
        right: -160,
        child: _GlowOrb(
          size: 380,
          color: AppTheme.accentSecondary.withValues(alpha: 0.06),
        ),
      ),
      Positioned(
        bottom: 120,
        left: -90,
        child: _GlowOrb(
          size: 320,
          color: AppTheme.accentTertiary.withValues(alpha: 0.05),
        ),
      ),
      Positioned(
        bottom: -80,
        right: 80,
        child: _GlowOrb(
          size: 260,
          color: AppTheme.accent.withValues(alpha: 0.04),
        ),
      ),
    ];
  }

  List<Widget> _codeSnippets(double opacity) {
    const snippets = [
      _Snippet('const app = ', 0.06, 0.12, -8),
      _Snippet('{ }', 0.78, 0.08, 12),
      _Snippet('async/await', 0.14, 0.22, -6),
      _Snippet('<Flutter />', 0.82, 0.18, 10),
      _Snippet('def build():', 0.04, 0.38, -4),
      _Snippet('git push', 0.88, 0.32, 8),
      _Snippet('SELECT *', 0.10, 0.52, -10),
      _Snippet('import dart', 0.72, 0.48, 6),
      _Snippet('REST API', 0.92, 0.58, -5),
      _Snippet('docker run', 0.08, 0.68, 7),
      _Snippet('npm install', 0.70, 0.72, -8),
      _Snippet('class Dev', 0.86, 0.82, 5),
      _Snippet('return true;', 0.12, 0.88, -6),
      _Snippet('// TODO', 0.58, 0.06, 4),
      _Snippet('=> {}', 0.48, 0.92, -12),
    ];

    return snippets.map((s) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment(s.x * 2 - 1, s.y * 2 - 1),
          child: Transform.rotate(
            angle: s.rotation * math.pi / 180,
            child: Text(
              s.text,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: s.text.length > 10 ? 11 : 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.accent.withValues(alpha: opacity),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _techIconBadges(BuildContext context, double opacity) {
    const placements = [
      _IconPlacement('Python', 0.18, 0.14, 44),
      _IconPlacement('React', 0.62, 0.10, 38),
      _IconPlacement('Flutter', 0.90, 0.42, 42),
      _IconPlacement('Django', 0.06, 0.46, 40),
      _IconPlacement('Docker', 0.76, 0.62, 36),
      _IconPlacement('Git', 0.22, 0.78, 38),
      _IconPlacement('JavaScript', 0.52, 0.28, 34),
      _IconPlacement('PostgreSQL', 0.94, 0.76, 36),
    ];

    return placements.map((p) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment(p.x * 2 - 1, p.y * 2 - 1),
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: p.size + 16,
              height: p.size + 16,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.surface.withValues(alpha: 0.35),
                border: Border.all(
                  color: AppTheme.accent.withValues(alpha: 0.12),
                ),
              ),
              child: _BackgroundSkillBadge(name: p.name, size: p.size * 0.55),
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _deviceSilhouettes(BuildContext context, bool isDark) {
    final opacity = isDark ? 0.13 : 0.10;
    final isWide = MediaQuery.sizeOf(context).width > 900;

    final devices = isWide
        ? const [
            _DevicePlacement(_DeviceType.laptop, 0.05, 0.56, 128, -14),
            _DevicePlacement(_DeviceType.desktop, 0.90, 0.86, 108, 7),
            _DevicePlacement(_DeviceType.phone, 0.14, 0.28, 54, 11),
            _DevicePlacement(_DeviceType.tablet, 0.92, 0.36, 78, -9),
          ]
        : const [
            _DevicePlacement(_DeviceType.phone, 0.10, 0.18, 46, 8),
            _DevicePlacement(_DeviceType.tablet, 0.88, 0.42, 64, -6),
            _DevicePlacement(_DeviceType.laptop, 0.06, 0.78, 96, -12),
          ];

    return devices.map((d) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment(d.x * 2 - 1, d.y * 2 - 1),
          child: _FloatingDevice(
            type: d.type,
            size: d.size,
            rotation: d.rotation,
            opacity: opacity,
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _decorWindows(BuildContext context, bool isDark) {
    final surface = isDark
        ? const Color(0xFF12121A).withValues(alpha: 0.55)
        : Colors.white.withValues(alpha: 0.45);
    final border = AppTheme.accent.withValues(alpha: isDark ? 0.15 : 0.12);
    final isWide = MediaQuery.sizeOf(context).width > 900;

    if (!isWide) {
      return [
        Positioned(
          top: 100,
          right: 8,
          child: _DecorWindow(
            width: 160,
            surface: surface,
            border: border,
            title: 'terminal',
            lines: const [
              _Line('~/portfolio \$ run', AppTheme.accentTertiary),
              _Line('✓ Built release', Color(0xFF10B981)),
            ],
            rotation: 3,
          ),
        ),
      ];
    }

    return [
      Positioned(
        top: 140,
        right: 24,
        child: _DecorWindow(
          width: 200,
          surface: surface,
          border: border,
          title: 'terminal',
          lines: const [
            _Line('~/portfolio \$ flutter run', AppTheme.accentTertiary),
            _Line('✓ Built web release', Color(0xFF10B981)),
            _Line('→ localhost:8080', AppTheme.accentSecondary),
          ],
          rotation: 4,
        ),
      ),
      Positioned(
        top: 520,
        left: 16,
        child: _DecorWindow(
          width: 220,
          surface: surface,
          border: border,
          title: 'main.dart',
          lines: const [
            _Line("import 'package:flutter/", AppTheme.accent),
            _Line('class Portfolio extends', AppTheme.accentSecondary),
            _Line('  Widget build() {', Color(0xFFE879F9)),
            _Line('    return MaterialApp(', AppTheme.accentTertiary),
          ],
          rotation: -3,
        ),
      ),
      Positioned(
        bottom: 280,
        right: 40,
        child: _DecorWindow(
          width: 190,
          surface: surface,
          border: border,
          title: 'api.py',
          lines: const [
            _Line('@api_view(["GET"])', AppTheme.accent),
            _Line('def projects(request):', AppTheme.accentTertiary),
            _Line('  return Response(data)', Color(0xFF10B981)),
          ],
          rotation: 2,
        ),
      ),
    ];
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _DecorWindow extends StatelessWidget {
  const _DecorWindow({
    required this.width,
    required this.surface,
    required this.border,
    required this.title,
    required this.lines,
    required this.rotation,
  });

  final double width;
  final Color surface;
  final Color border;
  final String title;
  final List<_Line> lines;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * math.pi / 180,
      child: Opacity(
        opacity: Theme.of(context).brightness == Brightness.dark ? 0.55 : 0.45,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border),
            boxShadow: [
              BoxShadow(
                color: AppTheme.accent.withValues(alpha: 0.06),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const _TrafficDot(color: Color(0xFFEF4444)),
                  const SizedBox(width: 5),
                  const _TrafficDot(color: Color(0xFFF59E0B)),
                  const SizedBox(width: 5),
                  const _TrafficDot(color: Color(0xFF10B981)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: context.colors.textSecondary.withValues(alpha: 0.8),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              for (final line in lines)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    line.text,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9.5,
                      height: 1.4,
                      color: line.color.withValues(alpha: 0.85),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrafficDot extends StatelessWidget {
  const _TrafficDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Snippet {
  const _Snippet(this.text, this.x, this.y, this.rotation);

  final String text;
  final double x;
  final double y;
  final double rotation;
}

class _IconPlacement {
  const _IconPlacement(this.name, this.x, this.y, this.size);

  final String name;
  final double x;
  final double y;
  final double size;
}

enum _DeviceType { desktop, laptop, phone, tablet }

class _DevicePlacement {
  const _DevicePlacement(this.type, this.x, this.y, this.size, this.rotation);

  final _DeviceType type;
  final double x;
  final double y;
  final double size;
  final double rotation;
}

class _FloatingDevice extends StatelessWidget {
  const _FloatingDevice({
    required this.type,
    required this.size,
    required this.rotation,
    required this.opacity,
  });

  final _DeviceType type;
  final double size;
  final double rotation;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (w, h) = switch (type) {
      _DeviceType.desktop => (size * 1.15, size),
      _DeviceType.laptop => (size * 1.2, size * 0.82),
      _DeviceType.phone => (size * 0.48, size),
      _DeviceType.tablet => (size * 0.72, size),
    };

    return Transform.rotate(
      angle: rotation * math.pi / 180,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: w + 24,
          height: h + 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.accent.withValues(alpha: 0.04),
          ),
          child: CustomPaint(
            size: Size(w, h),
            painter: _DeviceOutlinePainter(
              type: type,
              strokeColor: AppTheme.accent.withValues(alpha: 0.55),
              fillColor: colors.surface.withValues(alpha: 0.25),
            ),
          ),
        ),
      ),
    );
  }
}

class _DeviceOutlinePainter extends CustomPainter {
  _DeviceOutlinePainter({
    required this.type,
    required this.strokeColor,
    required this.fillColor,
  });

  final _DeviceType type;
  final Color strokeColor;
  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    switch (type) {
      case _DeviceType.desktop:
        _paintDesktop(canvas, size, fill, stroke);
      case _DeviceType.laptop:
        _paintLaptop(canvas, size, fill, stroke);
      case _DeviceType.phone:
        _paintPhone(canvas, size, fill, stroke);
      case _DeviceType.tablet:
        _paintTablet(canvas, size, fill, stroke);
    }
  }

  void _paintDesktop(Canvas canvas, Size size, Paint fill, Paint stroke) {
    final screenH = size.height * 0.72;
    final screen = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, screenH),
      const Radius.circular(6),
    );
    canvas.drawRRect(screen, fill);
    canvas.drawRRect(screen, stroke);

    final neckW = size.width * 0.08;
    final neckH = size.height * 0.12;
    final neckLeft = size.width / 2 - neckW / 2;
    canvas.drawRect(
      Rect.fromLTWH(neckLeft, screenH, neckW, neckH),
      stroke,
    );

    final baseW = size.width * 0.28;
    final baseH = size.height * 0.06;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width / 2 - baseW / 2, screenH + neckH, baseW, baseH),
        const Radius.circular(3),
      ),
      stroke,
    );

    _drawScreenGlow(canvas, Rect.fromLTWH(8, 8, size.width - 16, screenH - 16), strokeColor);
  }

  void _paintLaptop(Canvas canvas, Size size, Paint fill, Paint stroke) {
    final screenH = size.height * 0.62;
    final screen = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.08, 0, size.width * 0.84, screenH),
      const Radius.circular(5),
    );
    canvas.drawRRect(screen, fill);
    canvas.drawRRect(screen, stroke);

    final basePath = Path()
      ..moveTo(0, screenH + 2)
      ..lineTo(size.width, screenH + 2)
      ..lineTo(size.width * 0.92, size.height)
      ..lineTo(size.width * 0.08, size.height)
      ..close();
    canvas.drawPath(basePath, fill);
    canvas.drawPath(basePath, stroke);

    _drawScreenGlow(
      canvas,
      Rect.fromLTWH(size.width * 0.12, 6, size.width * 0.76, screenH - 12),
      strokeColor,
    );
  }

  void _paintPhone(Canvas canvas, Size size, Paint fill, Paint stroke) {
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(size.width * 0.18),
    );
    canvas.drawRRect(body, fill);
    canvas.drawRRect(body, stroke);

    final notchW = size.width * 0.35;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width / 2 - notchW / 2,
          size.height * 0.04,
          notchW,
          size.height * 0.04,
        ),
        Radius.circular(size.height * 0.02),
      ),
      stroke,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.12,
          size.height * 0.12,
          size.width * 0.76,
          size.height * 0.72,
        ),
        Radius.circular(size.width * 0.08),
      ),
      Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.9),
      size.width * 0.06,
      Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
  }

  void _paintTablet(Canvas canvas, Size size, Paint fill, Paint stroke) {
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(size.width * 0.08),
    );
    canvas.drawRRect(body, fill);
    canvas.drawRRect(body, stroke);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.08,
          size.height * 0.08,
          size.width * 0.84,
          size.height * 0.84,
        ),
        Radius.circular(size.width * 0.05),
      ),
      Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    _drawScreenGlow(
      canvas,
      Rect.fromLTWH(size.width * 0.14, size.height * 0.14, size.width * 0.5, size.height * 0.2),
      strokeColor,
    );
  }

  void _drawScreenGlow(Canvas canvas, Rect rect, Color color) {
    canvas.drawLine(
      rect.topLeft,
      Offset(rect.right, rect.top),
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  @override
  bool shouldRepaint(covariant _DeviceOutlinePainter oldDelegate) {
    return oldDelegate.type != type ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.fillColor != fillColor;
  }
}

class _Line {
  const _Line(this.text, this.color);

  final String text;
  final Color color;
}

class _BackgroundSkillBadge extends StatelessWidget {
  const _BackgroundSkillBadge({required this.name, required this.size});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final brand = skillBrandFor(name);
    final color = skillIconColor(context, brand.color);
    final label = name.isNotEmpty ? name[0].toUpperCase() : '?';

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

class _DotGridPainter extends CustomPainter {
  _DotGridPainter({required this.color, required this.spacing});

  final Color color;
  final double spacing;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (var x = 0.0; x < size.width; x += spacing) {
      for (var y = 0.0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.spacing != spacing;
  }
}
