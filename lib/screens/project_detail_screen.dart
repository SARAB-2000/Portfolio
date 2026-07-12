import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../widgets/common_widgets.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final ProjectItem project;

  Future<void> _openLiveUrl() async {
    final uri = Uri.parse(project.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final isWide = MediaQuery.sizeOf(context).width > 900;
    final allProjects = PortfolioData.projects;
    final currentIndex = allProjects.indexWhere((p) => p.id == project.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: isWide ? 420 : 280,
            pinned: true,
            stretch: true,
            backgroundColor: colors.background,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colors.textPrimary),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: _HeroBanner(project: project),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 80 : 24,
                vertical: 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _MetaChip(
                        icon: Icons.category_outlined,
                        label: project.category.of(context),
                        color: project.color,
                      ),
                      _MetaChip(
                        icon: Icons.person_outline,
                        label: project.myRole.of(context),
                        color: project.color,
                      ),
                      _MetaChip(
                        icon: Icons.schedule,
                        label: project.duration.of(context),
                        color: project.color,
                      ),
                    ],
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 24),
                  Text(
                    project.title.of(context),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                        ),
                  ).animate().fadeIn(delay: 100.ms),
                  const SizedBox(height: 16),
                  Text(
                    project.description.of(context),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colors.textSecondary,
                          height: 1.7,
                        ),
                  ).animate().fadeIn(delay: 150.ms),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: project.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: project.color.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: project.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 40),
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _CaseStudyContent(project: project)),
                        const SizedBox(width: 48),
                        SizedBox(
                          width: 280,
                          child: _SidePanel(
                            project: project,
                            onVisit: _openLiveUrl,
                            l10n: l10n,
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _CaseStudyContent(project: project),
                    const SizedBox(height: 32),
                    _SidePanel(project: project, onVisit: _openLiveUrl, l10n: l10n),
                  ],
                  const SizedBox(height: 48),
                  _ProjectNavigation(
                    currentIndex: currentIndex,
                    projects: allProjects,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (project.imageAsset.isNotEmpty)
          Image.asset(
            project.imageAsset,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _gradientFallback(context),
          )
        else
          _gradientFallback(context),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                context.colors.background.withValues(alpha: 0.9),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _gradientFallback(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            project.color.withValues(alpha: 0.4),
            project.color.withValues(alpha: 0.1),
            context.colors.background,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.layers,
          size: 120,
          color: project.color.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}

class _CaseStudyContent extends StatelessWidget {
  const _CaseStudyContent({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _CaseStudyBlock(
          title: l10n.caseOverview,
          content: project.overview.of(context),
          icon: Icons.visibility_outlined,
          color: project.color,
          delay: 0,
        ),
        _CaseStudyBlock(
          title: l10n.caseChallenge,
          content: project.challenge.of(context),
          icon: Icons.warning_amber_outlined,
          color: project.color,
          delay: 100,
        ),
        _CaseStudyBlock(
          title: l10n.caseSolution,
          content: project.solution.of(context),
          icon: Icons.lightbulb_outline,
          color: project.color,
          delay: 200,
        ),
        _CaseStudyBlock(
          title: l10n.caseResults,
          content: project.results.of(context),
          icon: Icons.trending_up,
          color: const Color(0xFF10B981),
          delay: 300,
          highlight: true,
        ),
      ],
    );
  }
}

class _CaseStudyBlock extends StatelessWidget {
  const _CaseStudyBlock({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
    required this.delay,
    this.highlight = false,
  });

  final String title;
  final String content;
  final IconData icon;
  final Color color;
  final int delay;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: GlassCard(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 14),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: highlight ? colors.textPrimary : colors.textSecondary,
                    height: 1.7,
                    fontWeight: highlight ? FontWeight.w500 : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: delay.ms)
        .slideY(begin: 0.15, end: 0, delay: delay.ms);
  }
}

class _SidePanel extends StatelessWidget {
  const _SidePanel({
    required this.project,
    required this.onVisit,
    required this.l10n,
  });

  final ProjectItem project;
  final VoidCallback onVisit;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.projectDetails,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          _DetailRow(l10n.detailRole, project.myRole.of(context)),
          _DetailRow(l10n.detailDuration, project.duration.of(context)),
          _DetailRow(l10n.detailCategory, project.category.of(context)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onVisit,
              icon: const Icon(Icons.open_in_new, size: 18),
              label: Text(l10n.visitLiveSite),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(color: context.colors.textSecondary, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

class _ProjectNavigation extends StatelessWidget {
  const _ProjectNavigation({
    required this.currentIndex,
    required this.projects,
  });

  final int currentIndex;
  final List<ProjectItem> projects;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasPrev = currentIndex > 0;
    final hasNext = currentIndex < projects.length - 1;

    return Row(
      children: [
        if (hasPrev)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => ProjectDetailScreen(project: projects[currentIndex - 1]),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back, size: 18),
              label: Text(l10n.previousProject),
            ),
          ),
        if (hasPrev && hasNext) const SizedBox(width: 16),
        if (hasNext)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => ProjectDetailScreen(project: projects[currentIndex + 1]),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: Text(l10n.nextProject),
            ),
          ),
      ],
    );
  }
}
