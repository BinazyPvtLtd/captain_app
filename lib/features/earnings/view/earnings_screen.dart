import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';

import '../model/earnings_model.dart';
import '../view_model/earnings_view_model.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EarningsViewModel(),
      child: const _EarningsView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _EarningsView extends StatelessWidget {
  const _EarningsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            const _EarningsHeader(),

            const Divider(
              height: 1,
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: Consumer<EarningsViewModel>(
                builder: (
                  context,
                  viewModel,
                  child,
                ) {
                  return ListView(
                    physics:
                        const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.fromLTRB(
                      AppSpacing.screenHorizontal,
                      AppSpacing.lg,
                      AppSpacing.screenHorizontal,
                      AppSpacing.xl,
                    ),
                    children: [
                      // ===========================================
                      // TITLE
                      // ===========================================

                      Text(
                        'Earnings',
                        style:
                            AppTextStyles.headingLarge,
                      ),

                      AppSpacing.gapXL,

                      // ===========================================
                      // PERIOD FILTER
                      // ===========================================

                      const _PeriodSelector(),

                      AppSpacing.gapMD,

                      // ===========================================
                      // CURRENT EARNING CARD
                      // ===========================================

                      _CurrentEarningsCard(
                        title:
                            viewModel.currentTitle,
                        amount:
                            viewModel.currentAmount,
                        comparison:
                            viewModel.comparisonText,
                      ),

                      AppSpacing.gapXXL,

                      // ===========================================
                      // SUMMARY
                      // ===========================================

                      Text(
                        'Summary',
                        style:
                            AppTextStyles.headingMedium,
                      ),

                      AppSpacing.gapMD,

                      ...viewModel.summary.map(
                        (item) =>
                            _SummaryRow(
                          item: item,
                        ),
                      ),

                      AppSpacing.gapXXL,

                      // ===========================================
                      // HISTORY
                      // ===========================================

                      Text(
                        'Earnings History',
                        style:
                            AppTextStyles.headingMedium,
                      ),

                      AppSpacing.gapMD,

                      ...viewModel.history.map(
                        (item) =>
                            _HistoryRow(
                          item: item,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// HEADER
// =====================================================================

class _EarningsHeader extends StatelessWidget {
  const _EarningsHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal:
              AppSpacing.screenHorizontal,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context
                      .read<EarningsViewModel>()
                      .openMenu(
                    onPressed: () {
                      debugPrint(
                        'Open menu',
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.menu_rounded,
                  size: AppSpacing.iconMD,
                  color:
                      AppColors.textPrimary,
                ),
              ),
            ),

            AppSpacing.horizontalMD,

            Expanded(
              child: Text(
                'PATGOLITO DRIVER',
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style:
                    AppTextStyles.headingMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// PERIOD SELECTOR
// =====================================================================

class _PeriodSelector extends StatelessWidget {
  const _PeriodSelector();

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.watch<EarningsViewModel>();

    return Container(
      padding: const EdgeInsets.all(
        AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color:
            AppColors.surfaceSecondary,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusMD,
        ),
        border: Border.all(
          color:
              AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _PeriodTab(
              title: 'Today',
              selected:
                  viewModel.selectedPeriod ==
                      EarningsPeriod.today,
              onTap: () {
                viewModel.selectPeriod(
                  EarningsPeriod.today,
                );
              },
            ),
          ),

          Expanded(
            child: _PeriodTab(
              title: 'Week',
              selected:
                  viewModel.selectedPeriod ==
                      EarningsPeriod.week,
              onTap: () {
                viewModel.selectPeriod(
                  EarningsPeriod.week,
                );
              },
            ),
          ),

          Expanded(
            child: _PeriodTab(
              title: 'Month',
              selected:
                  viewModel.selectedPeriod ==
                      EarningsPeriod.month,
              onTap: () {
                viewModel.selectPeriod(
                  EarningsPeriod.month,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PeriodTab extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _PeriodTab({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(
        AppSpacing.radiusSM,
      ),
      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 180,
        ),
        height: 46,
        alignment:
            Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : Colors.transparent,
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusSM,
          ),
        ),
        child: Text(
          title,
          style:
              AppTextStyles.titleMedium.copyWith(
            color: selected
                ? AppColors.white
                : AppColors.textSecondary,
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// CURRENT EARNINGS CARD
// =====================================================================

class _CurrentEarningsCard
    extends StatelessWidget {
  final String title;
  final String amount;
  final String comparison;

  const _CurrentEarningsCard({
    required this.title,
    required this.amount,
    required this.comparison,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      radius:
          AppSpacing.radiusLG,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                AppTextStyles.bodyLargeSecondary,
          ),

          AppSpacing.gapMD,

          Text(
            amount,
            style:
                AppTextStyles.displayMedium,
          ),

          AppSpacing.gapMD,

          Row(
            children: [
              const Icon(
                Icons.trending_up_rounded,
                size:
                    AppSpacing.iconSM,
                color:
                    AppColors.textPrimary,
              ),

              AppSpacing.horizontalXS,

              Text(
                comparison,
                style:
                    AppTextStyles.titleMedium.copyWith(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SUMMARY ROW
// =====================================================================

class _SummaryRow extends StatelessWidget {
  final EarningsSummaryModel item;

  const _SummaryRow({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color:
                AppColors.divider,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style:
                      AppTextStyles.titleMedium,
                ),

                AppSpacing.gapXS,

                Text(
                  '${item.trips} Trips',
                  style:
                      AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),

          Text(
            item.amount,
            style:
                AppTextStyles.headingMedium,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// HISTORY ROW
// =====================================================================

class _HistoryRow extends StatelessWidget {
  final EarningsHistoryModel item;

  const _HistoryRow({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color:
                AppColors.divider,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  item.date,
                  style:
                      AppTextStyles.titleMedium,
                ),

                AppSpacing.gapXS,

                Text(
                  '${item.trips} Trips',
                  style:
                      AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),

          Text(
            item.amount,
            style:
                AppTextStyles.titleLarge,
          ),
        ],
      ),
    );
  }
}