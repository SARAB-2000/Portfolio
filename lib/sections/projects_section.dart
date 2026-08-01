import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/portfolio_data.dart';
import '../l10n/app_localizations.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../widgets/common_widgets.dart';

const _initialVisibleCount = 4;

double _coverHeight(double cardWidth, bool compact) =>
    cardWidth * (compact ? 0.72 : 0.75);

double _cardHeight(double cardWidth, bool compact) =>
    _coverHeight(cardWidth, compact) + (compact ? 100.0 : 118.0);

int _crossAxisCountForWidth(double width) {
  if (width >= 1200) return 4;
  if (width >= 900) return 3;
  if (width >= 560) return 2;
  return 1;
}

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = MediaQuery.sizeOf(context).width > 900;
    final projects = PortfolioData.orderedProjects;

    final hiddenCount = projects.length > _initialVisibleCount
        ? projects.length - _initialVisibleCount
        : 0;
    final visibleProjects = _showAll
        ? projects
        : projects.take(_initialVisibleCount).toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isWide ? 48 : 24, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: l10n.sectionProjects,
            subtitle: l10n.sectionProjectsSubtitle,
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = _crossAxisCountForWidth(
                constraints.maxWidth,
              );
              const spacing = 16.0;
              final cardWidth =
                  (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
                  crossAxisCount;
              final compact = crossAxisCount >= 3;

              return Column(
                children: [
                  Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (var i = 0; i < visibleProjects.length; i++)
                        SizedBox(
                          width: cardWidth,
                          height: _cardHeight(cardWidth, compact),
                          child: _FeaturedProjectCard(
                            project: visibleProjects[i],
                            index: i,
                            compact: compact,
                            coverHeight: _coverHeight(cardWidth, compact),
                            onTap: () => AppRoutes.openProject(
                              context,
                              visibleProjects[i],
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (hiddenCount > 0) ...[
                    const SizedBox(height: 20),
                    Center(
                      child: _showAll
                          ? TextButton.icon(
                              onPressed: () => setState(() => _showAll = false),
                              icon: const Icon(Icons.expand_less, size: 20),
                              label: Text(l10n.showLessProjects),
                            )
                          : OutlinedButton.icon(
                              onPressed: () => setState(() => _showAll = true),
                              icon: const Icon(Icons.expand_more, size: 20),
                              label: Text(l10n.viewMoreProjects(hiddenCount)),
                            ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeaturedProjectCard extends StatelessWidget {
  const _FeaturedProjectCard({
    required this.project,
    required this.onTap,
    required this.index,
    required this.coverHeight,
    this.compact = false,
  });

  final ProjectItem project;
  final VoidCallback onTap;
  final int index;
  final double coverHeight;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardCover(project: project, height: coverHeight, compact: compact),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  compact ? 12 : 16,
                  compact ? 10 : 14,
                  compact ? 12 : 16,
                  compact ? 12 : 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title.of(context),
                      maxLines: compact ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                        fontSize: compact ? 13 : null,
                      ),
                    ),
                    SizedBox(height: compact ? 6 : 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: compact ? 6 : 8,
                        vertical: compact ? 2 : 3,
                      ),
                      decoration: BoxDecoration(
                        color: project.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        project.category.of(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: project.color,
                          fontWeight: FontWeight.w600,
                          fontSize: compact ? 10 : 11,
                        ),
                      ),
                    ),
                    SizedBox(height: compact ? 6 : 8),
                    Expanded(
                      child: Text(
                        project.description.of(context),
                        maxLines: compact ? 2 : 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                          height: 1.4,
                          fontSize: compact ? 11 : null,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          l10n.viewProject,
                          style: TextStyle(
                            color: project.color,
                            fontWeight: FontWeight.w600,
                            fontSize: compact ? 12 : 13,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          color: project.color,
                          size: compact ? 12 : 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardCover extends StatelessWidget {
  const _CardCover({
    required this.project,
    required this.height,
    this.compact = false,
  });

  final ProjectItem project;
  final double height;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final cacheWidth = ((compact ? 280 : 480) * dpr).round();
    final hasImage = project.imageAsset.isNotEmpty;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: hasImage
          ? _buildImageCover(colors, cacheWidth)
          : _buildPlaceholderCover(colors),
    );
  }

  Widget _buildPlaceholderCover(AppColors colors) {
    return Container(
      color: project.color.withValues(alpha: 0.08),
      child: Center(
        child: Icon(
          Icons.folder_outlined,
          size: compact ? 32 : 40,
          color: project.color.withValues(alpha: 0.45),
        ),
      ),
    );
  }

  Widget _buildImageCover(AppColors colors, int cacheWidth) {
    if (project.portraitCover) {
      return Container(
        width: double.infinity,
        height: height,
        color: project.color.withValues(alpha: 0.06),
        padding: EdgeInsets.all(compact ? 6 : 10),
        child: Image.asset(
          project.imageAsset,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
          cacheWidth: cacheWidth,
          errorBuilder: (context, error, stackTrace) =>
              _buildPlaceholderCover(colors),
        ),
      );
    }

    return Image.asset(
      project.imageAsset,
      fit: BoxFit.cover,
      width: double.infinity,
      height: height,
      cacheWidth: cacheWidth,
      errorBuilder: (context, error, stackTrace) =>
          _buildPlaceholderCover(colors),
    );
  }
}
