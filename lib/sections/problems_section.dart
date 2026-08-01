import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/portfolio_data.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../widgets/common_widgets.dart';

class ProblemsSection extends StatelessWidget {
  const ProblemsSection({
    super.key,
    required this.onContact,
  });

  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = MediaQuery.sizeOf(context).width > 900;
    final problems = PortfolioData.clientProblems;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 48 : 24,
        vertical: isWide ? 72 : 56,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: l10n.sectionProblems,
            subtitle: l10n.sectionProblemsSubtitle,
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
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
                  for (var i = 0; i < problems.length; i++)
                    SizedBox(
                      width: cardWidth,
                      child: _ProblemCard(item: problems[i], index: i),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 28),
          Center(
            child: TextButton.icon(
              onPressed: onContact,
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: Text(l10n.problemsCta),
            ).animate().fadeIn(delay: 350.ms),
          ),
        ],
      ),
    );
  }
}

class _ProblemCard extends StatelessWidget {
  const _ProblemCard({
    required this.item,
    required this.index,
  });

  final ClientProblemItem item;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item.icon, color: item.color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.problem.of(context),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item.outcome.of(context),
            style: TextStyle(
              color: item.color,
              fontWeight: FontWeight.w600,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: (index * 70).ms)
        .slideY(begin: 0.1, end: 0);
  }
}
