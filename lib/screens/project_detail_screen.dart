import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../widgets/common_widgets.dart';
import '../widgets/skill_icon_widget.dart';

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
            pinned: true,
            backgroundColor: colors.background,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colors.textPrimary),
              onPressed: () => Navigator.of(context).pop(),
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
                    children: project.tags.map((tag) => _ProjectTagChip(
                          tag: tag,
                          color: project.color,
                        )).toList(),
                  ),
                  if (project.allImageAssets.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    _ProjectImageSlider(project: project, l10n: l10n),
                  ],
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

class _ProjectTagChip extends StatelessWidget {
  const _ProjectTagChip({
    required this.tag,
    required this.color,
  });

  final String tag;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SkillIconWidget(skillName: tag, size: 15),
          const SizedBox(width: 7),
          Text(
            tag,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectImageSlider extends StatelessWidget {
  const _ProjectImageSlider({
    required this.project,
    required this.l10n,
  });

  final ProjectItem project;
  final AppLocalizations l10n;

  void _openPreviewModal(BuildContext context, int initialIndex) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.72),
      builder: (dialogContext) {
        return _ImagePreviewModal(
          images: project.allImageAssets,
          initialIndex: initialIndex,
          projectColor: project.color,
        );
      },
    );
  }

  Widget _buildThumbnail(BuildContext context, String asset) {
    return Image.asset(
      asset,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: project.color.withValues(alpha: 0.1),
        alignment: Alignment.center,
        child: Icon(
          Icons.broken_image_outlined,
          color: context.colors.textSecondary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final images = project.allImageAssets;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.projectGallery,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _openPreviewModal(context, index),
                  borderRadius: BorderRadius.circular(10),
                  child: Ink(
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.border),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: _buildThumbnail(context, images[index]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }
}

class _ImagePreviewModal extends StatefulWidget {
  const _ImagePreviewModal({
    required this.images,
    required this.initialIndex,
    required this.projectColor,
  });

  final List<String> images;
  final int initialIndex;
  final Color projectColor;

  @override
  State<_ImagePreviewModal> createState() => _ImagePreviewModalState();
}

class _ImagePreviewModalState extends State<_ImagePreviewModal> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  void _goPrev() {
    setState(() {
      _index = (_index - 1 + widget.images.length) % widget.images.length;
    });
  }

  void _goNext() {
    setState(() {
      _index = (_index + 1) % widget.images.length;
    });
  }

  bool get _isRtl => Directionality.of(context) == TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final size = MediaQuery.sizeOf(context);
    final maxWidth = (size.width - 48).clamp(280.0, 960.0);
    final maxHeight = size.height * 0.75;

    return Dialog(
      backgroundColor: colors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.images[_index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => SizedBox(
                      height: 200,
                      child: Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: colors.textSecondary,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: colors.border)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: widget.images.length > 1 ? _goPrev : null,
                    icon: Icon(_isRtl ? Icons.chevron_right : Icons.chevron_left),
                  ),
                  Expanded(
                    child: Text(
                      '${_index + 1} / ${widget.images.length}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: widget.images.length > 1 ? _goNext : null,
                    icon: Icon(_isRtl ? Icons.chevron_left : Icons.chevron_right),
                  ),
                ],
              ),
            ),
          ],
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
