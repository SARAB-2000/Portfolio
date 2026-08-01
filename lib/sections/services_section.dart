import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/portfolio_data.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({
    super.key,
    required this.onContact,
  });

  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = MediaQuery.sizeOf(context).width > 900;
    final services = PortfolioData.services;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 48 : 24,
        vertical: isWide ? 72 : 56,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.accent.withValues(alpha: 0.04),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: l10n.sectionServices,
            subtitle: l10n.sectionServicesSubtitle,
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          if (Localizations.localeOf(context).languageCode != 'fa') ...[
            const SizedBox(height: 12),
            Text(
              PortfolioData.pricingNote.of(context),
              style: TextStyle(
                color: AppTheme.accent,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ).animate().fadeIn(delay: 80.ms),
          ],
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              final twoCol = constraints.maxWidth >= 720;
              final cardWidth = twoCol
                  ? (constraints.maxWidth - 16) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (var i = 0; i < services.length; i++)
                    SizedBox(
                      width: cardWidth,
                      child: _ServiceCard(
                        service: services[i],
                        index: i,
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 28),
          Center(
            child: ElevatedButton.icon(
              onPressed: onContact,
              icon: const Icon(Icons.mail_outline, size: 18),
              label: Text(l10n.servicesCta),
            ).animate().fadeIn(delay: 400.ms),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.service,
    required this.index,
  });

  final ServiceItem service;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: service.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(service.icon, color: service.color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  service.title.of(context),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            service.description.of(context),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 14),
          for (final problem in service.problems)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.format_quote,
                      size: 14,
                      color: service.color.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      problem.of(context),
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: colors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: (index * 80).ms)
        .slideY(begin: 0.12, end: 0);
  }
}
