import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/portfolio_data.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/profile_avatar.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onViewServices,
    required this.onContact,
  });

  final VoidCallback onViewProjects;
  final VoidCallback onViewServices;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final profile = PortfolioData.profile;
    final isWide = MediaQuery.sizeOf(context).width > 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 48 : 24,
        vertical: isWide ? 80 : 48,
      ),
      child: isWide ? _buildWide(context, l10n, profile) : _buildNarrow(context, l10n, profile),
    );
  }

  Widget _buildWide(BuildContext context, AppLocalizations l10n, PortfolioProfile profile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: _buildContent(context, l10n, profile)),
        const SizedBox(width: 48),
        Expanded(flex: 2, child: _buildAvatar(isWide: true)),
      ],
    );
  }

  Widget _buildNarrow(BuildContext context, AppLocalizations l10n, PortfolioProfile profile) {
    return Column(
      children: [
        _buildAvatar(isWide: false),
        const SizedBox(height: 40),
        _buildContent(context, l10n, profile),
      ],
    );
  }

  Widget _buildContent(BuildContext context, AppLocalizations l10n, PortfolioProfile profile) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AvailableBadge(label: l10n.heroAvailable)
            .animate()
            .fadeIn(delay: 200.ms)
            .slideX(begin: -0.2, end: 0),
        const SizedBox(height: 20),
        GradientText(
          profile.headline.of(context),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 48,
                height: 1.1,
                letterSpacing: -1.2,
              ),
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 16),
        Text(
          profile.role.of(context),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.accent,
                fontWeight: FontWeight.w600,
              ),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 8),
        Text(
          Localizations.localeOf(context).languageCode == 'fa'
              ? l10n.heroGreeting
              : '${l10n.heroGreeting} ${profile.name}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
        ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 16),
        Text(
          profile.tagline.of(context),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colors.textSecondary,
                height: 1.7,
                fontSize: 17,
              ),
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (var i = 0; i < PortfolioData.heroTrustPoints.length; i++)
              _TrustChip(text: PortfolioData.heroTrustPoints[i].of(context))
                  .animate()
                  .fadeIn(delay: (550 + i * 60).ms),
          ],
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: onContact,
              icon: const Icon(Icons.mail_outline, size: 18),
              label: Text(l10n.heroCtaContact),
            ).animate().fadeIn(delay: 700.ms).scale(begin: const Offset(0.9, 0.9)),
            OutlinedButton.icon(
              onPressed: onViewServices,
              icon: const Icon(Icons.handyman_outlined, size: 18),
              label: Text(l10n.heroCtaServices),
            ).animate().fadeIn(delay: 750.ms).scale(begin: const Offset(0.9, 0.9)),
            OutlinedButton.icon(
              onPressed: onViewProjects,
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: Text(l10n.heroCtaProjects),
            ).animate().fadeIn(delay: 800.ms).scale(begin: const Offset(0.9, 0.9)),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar({required bool isWide}) {
    final size = isWide ? 280.0 : 200.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: RepaintBoundary(
            child: AnimatedGlow(
              size: size,
              child: ProfileAvatar(size: size),
            ),
          ),
        ).animate().fadeIn(delay: 300.ms).scale(
              begin: const Offset(0.8, 0.8),
              curve: Curves.easeOutBack,
              duration: 800.ms,
            ),
        const SizedBox(height: 28),
        const _HeroStatsPanel()
            .animate()
            .fadeIn(delay: 550.ms)
            .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),
      ],
    );
  }
}

class _HeroStatsPanel extends StatelessWidget {
  const _HeroStatsPanel();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final stats = PortfolioData.heroStats;

    return Container(
      width: 380,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.accent.withValues(alpha: 0.10),
            AppTheme.accentSecondary.withValues(alpha: 0.06),
            colors.surface.withValues(alpha: 0.85),
          ],
        ),
        border: Border.all(
          color: AppTheme.accent.withValues(alpha: 0.22),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accent.withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          for (var i = 0; i < stats.length; i++) ...[
            if (i > 0)
              Container(
                width: 1,
                height: 58,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors.border.withValues(alpha: 0.0),
                      AppTheme.accent.withValues(alpha: 0.35),
                      colors.border.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            Expanded(
              child: _HeroStatTile(
                stat: stats[i],
                delayMs: 650 + i * 120,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _HeroStatTile extends StatelessWidget {
  const _HeroStatTile({
    required this.stat,
    required this.delayMs,
  });

  final HeroStatItem stat;
  final int delayMs;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.primaryGradient.scale(0.85),
            boxShadow: [
              BoxShadow(
                color: AppTheme.accent.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(stat.icon, size: 18, color: Colors.white),
        )
            .animate()
            .fadeIn(delay: delayMs.ms)
            .scale(begin: const Offset(0.6, 0.6), curve: Curves.easeOutBack),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (stat.showPlus)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  '+',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.accentSecondary,
                    height: 1,
                  ),
                ),
              ),
            GradientText(
              '${stat.value}',
              style: TextStyle(
                fontSize: stat.showPlus ? 36 : 32,
                fontWeight: FontWeight.w900,
                height: 1,
                letterSpacing: -1,
              ),
            ),
          ],
        ).animate().fadeIn(delay: (delayMs + 80).ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 6),
        Text(
          stat.label.of(context),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colors.textSecondary,
            height: 1.3,
          ),
        ).animate().fadeIn(delay: (delayMs + 160).ms),
      ],
    );
  }
}

class _TrustChip extends StatelessWidget {
  const _TrustChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppTheme.accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, size: 14, color: AppTheme.accent),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: colors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvailableBadge extends StatelessWidget {
  const _AvailableBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
          ).animate(onPlay: (c) => c.repeat()).fadeIn(duration: 800.ms).then().fadeOut(duration: 800.ms),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF10B981),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
