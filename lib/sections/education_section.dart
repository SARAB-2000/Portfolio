import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/portfolio_data.dart';
import '../l10n/app_localizations.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppTheme.accentSecondary.withValues(alpha: 0.03),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: l10n.sectionEducation,
            subtitle: l10n.sectionEducationSubtitle,
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          const SizedBox(height: 48),
          ...PortfolioData.educations.asMap().entries.map((entry) {
            return _EducationCard(
              education: entry.value,
              index: entry.key,
              isLast: entry.key == PortfolioData.educations.length - 1,
            );
          }),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard({
    required this.education,
    required this.index,
    required this.isLast,
  });

  final EducationItem education;
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
                    gradient: index == 0 ? AppTheme.primaryGradient : null,
                    color: index == 0 ? null : colors.border,
                    border: index == 0
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: AppTheme.accentSecondary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppTheme.accentSecondary.withValues(alpha: 0.25),
                              ),
                            ),
                            child: const Icon(
                              Icons.school_outlined,
                              size: 22,
                              color: AppTheme.accentSecondary,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  education.institution,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  education.degree.of(context),
                                  style: const TextStyle(
                                    color: AppTheme.accent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  education.period.of(context),
                                  style: TextStyle(
                                    color: colors.textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        education.description.of(context),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                              height: 1.6,
                            ),
                      ),
                      if (education.relatedProjectIds.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        _EducationProjectLinks(projectIds: education.relatedProjectIds),
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

class _EducationProjectLinks extends StatelessWidget {
  const _EducationProjectLinks({required this.projectIds});

  final List<String> projectIds;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
              '${l10n.educationThesisProject}: ${project.title.of(context)}',
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
