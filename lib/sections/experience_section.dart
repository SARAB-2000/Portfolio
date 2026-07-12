import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../l10n/app_localizations.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
            title: l10n.sectionExperience,
            subtitle: l10n.sectionExperienceSubtitle,
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          const SizedBox(height: 48),
          ...PortfolioData.experiences.asMap().entries.map((entry) {
            return _ExperienceCard(
              experience: entry.value,
              index: entry.key,
              isLast: entry.key == PortfolioData.experiences.length - 1,
            );
          }),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({
    required this.experience,
    required this.index,
    required this.isLast,
  });

  final ExperienceItem experience;
  final int index;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: experience.isCurrent
                        ? AppTheme.primaryGradient
                        : null,
                    color: experience.isCurrent ? null : colors.border,
                    border: experience.isCurrent
                        ? null
                        : Border.all(color: colors.textSecondary, width: 2),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: colors.border,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
              child: HoverScale(
                scale: 1.01,
                child: GlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              experience.company,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          if (experience.isCurrent)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.accent.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.present,
                                style: const TextStyle(
                                  color: AppTheme.accent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        experience.role.of(context),
                        style: const TextStyle(
                          color: AppTheme.accentSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        experience.period.of(context),
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        experience.description.of(context),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                              height: 1.6,
                            ),
                      ),
                      if (experience.websiteUrl != null &&
                          experience.websiteUrl!.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        _ExperienceWebsiteLink(url: experience.websiteUrl!),
                      ],
                      if (experience.relatedProjectIds.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        _ExperienceProjectLinks(projectIds: experience.relatedProjectIds),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: (index * 150).ms)
        .slideX(begin: 0.1, end: 0, delay: (index * 150).ms);
  }
}

class _ExperienceWebsiteLink extends StatelessWidget {
  const _ExperienceWebsiteLink({required this.url});

  final String url;

  Future<void> _open(BuildContext context) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final host = Uri.tryParse(url)?.host.replaceFirst('www.', '') ?? url;

    return InkWell(
      onTap: () => _open(context),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, size: 16, color: AppTheme.accent),
            const SizedBox(width: 6),
            Text(
              '$host — ${l10n.visitLiveSite}',
              style: const TextStyle(
                color: AppTheme.accent,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceProjectLinks extends StatelessWidget {
  const _ExperienceProjectLinks({required this.projectIds});

  final List<String> projectIds;

  @override
  Widget build(BuildContext context) {
    final projects = projectIds
        .map(PortfolioData.projectById)
        .whereType<ProjectItem>()
        .toList();
    if (projects.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final project in projects)
          ActionChip(
            avatar: Icon(Icons.arrow_outward, size: 14, color: AppTheme.accent),
            label: Text(
              project.title.of(context),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            side: BorderSide(color: AppTheme.accent.withValues(alpha: 0.35)),
            backgroundColor: AppTheme.accent.withValues(alpha: 0.08),
            onPressed: () => AppRoutes.openProject(context, project),
          ),
      ],
    );
  }
}
