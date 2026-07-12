import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchSocial(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final profile = PortfolioData.profile;
    final isWide = MediaQuery.sizeOf(context).width > 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 48 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: l10n.sectionContact,
            subtitle: l10n.sectionContactSubtitle,
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          const SizedBox(height: 48),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
              _ContactChannelCard(
                icon: Icons.mail_outline,
                iconColor: AppTheme.accent,
                label: l10n.contactEmail,
                value: profile.email,
                onTap: () => _launchEmail(profile.email),
              ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
              _ContactChannelCard(
                icon: Icons.location_on_outlined,
                iconColor: AppTheme.accentSecondary,
                label: l10n.contactLocation,
                value: profile.location.of(context),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
              for (var i = 0; i < profile.socialLinks.length; i++)
                _ContactChannelCard(
                  icon: profile.socialLinks[i].icon,
                  iconColor: AppTheme.accent,
                  label: profile.socialLinks[i].label,
                  value: _socialDisplayValue(profile.socialLinks[i].url),
                  onTap: () => _launchSocial(profile.socialLinks[i].url),
                )
                    .animate()
                    .fadeIn(delay: (300 + i * 100).ms)
                    .slideY(begin: 0.1, end: 0),
              ],
            ),
          ),
          if (isWide) const SizedBox(height: 8),
        ],
      ),
    );
  }

  static String _socialDisplayValue(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return url;
    final host = uri.host.replaceFirst('www.', '');
    final path = uri.path.replaceAll(RegExp(r'^/|/$'), '');
    if (path.isEmpty) return host;
    return '$host/$path';
  }
}

class _ContactChannelCard extends StatefulWidget {
  const _ContactChannelCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  State<_ContactChannelCard> createState() => _ContactChannelCardState();
}

class _ContactChannelCardState extends State<_ContactChannelCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isInteractive = widget.onTap != null;

    return MouseRegion(
      onEnter: isInteractive ? (_) => setState(() => _hovered = true) : null,
      onExit: isInteractive ? (_) => setState(() => _hovered = false) : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 280,
          height: 200,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? AppTheme.accent.withValues(alpha: 0.5)
                  : colors.border.withValues(alpha: 0.7),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppTheme.accent.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(widget.icon, color: widget.iconColor, size: 28),
              const SizedBox(height: 14),
              Text(
                widget.label,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.value,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: isInteractive && _hovered ? AppTheme.accent : colors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              if (isInteractive)
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.visitLiveSite,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _hovered ? AppTheme.accent : colors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_outward,
                      size: 14,
                      color: _hovered ? AppTheme.accent : colors.textSecondary,
                    ),
                  ],
                )
              else
                const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final year = DateTime.now().year;
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.border.withValues(alpha: 0.5))),
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            '© $year ${PortfolioData.profile.name}. ${l10n.footerRights}',
            style: TextStyle(color: colors.textSecondary, fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Built with Flutter 💙',
            style: TextStyle(
              color: colors.textSecondary.withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
