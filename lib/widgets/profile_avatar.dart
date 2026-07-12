import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Profile photo widget — put your image at [PortfolioProfile.avatarAsset]
/// or set [PortfolioProfile.avatarUrl] for a network image.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.size = 280,
    this.borderWidth = 3,
  });

  final double size;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final profile = PortfolioData.profile;
    final colors = context.colors;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.primaryGradient,
        border: Border.all(color: colors.border, width: borderWidth),
      ),
      child: ClipOval(child: _buildImage(context, profile)),
    );
  }

  Widget _buildImage(BuildContext context, PortfolioProfile profile) {
    if (profile.avatarAsset.isNotEmpty) {
      return Image.asset(
        profile.avatarAsset,
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorBuilder: (_, __, ___) => _initialsFallback(context, profile),
      );
    }

    if (profile.avatarUrl.isNotEmpty) {
      return Image.network(
        profile.avatarUrl,
        fit: BoxFit.cover,
        width: size,
        height: size,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return _loadingPlaceholder(context);
        },
        errorBuilder: (_, __, ___) => _initialsFallback(context, profile),
      );
    }

    return _initialsFallback(context, profile);
  }

  Widget _loadingPlaceholder(BuildContext context) {
    return ColoredBox(
      color: context.colors.surfaceLight,
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.accent),
      ),
    );
  }

  Widget _initialsFallback(BuildContext context, PortfolioProfile profile) {
    final initials = _initialsFromName(profile.name);
    return Container(
      color: context.colors.surfaceLight,
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: size * 0.28,
          fontWeight: FontWeight.w800,
          foreground: Paint()
            ..shader = AppTheme.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, size, size),
            ),
        ),
      ),
    );
  }

  String _initialsFromName(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
