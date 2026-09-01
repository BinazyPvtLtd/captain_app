import 'package:driver_app/core/widgets/main_navigation/view/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_primary_button.dart';

import '../model/delivery_completed_model.dart';
import '../view_model/delivery_completed_view_model.dart';

class DeliveryCompletedScreen extends StatelessWidget {
  final DeliveryCompletedModel delivery;

  const DeliveryCompletedScreen({
    super.key,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeliveryCompletedViewModel(
        delivery: delivery,
      ),
      child: const _DeliveryCompletedView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _DeliveryCompletedView extends StatelessWidget {
  const _DeliveryCompletedView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // =========================================================
      // FIXED DONE BUTTON
      // =========================================================

      bottomNavigationBar: const _DoneSection(),

      body: SafeArea(
        child: Consumer<DeliveryCompletedViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
              ),
              child: Column(
                children: [
                  // =================================================
                  // SUCCESS
                  // =================================================

                  const _SuccessSection(),

                  AppSpacing.gapXL,

                  // =================================================
                  // ROUTE
                  // =================================================

                  _RouteSection(
                    pickup: viewModel.delivery.pickup,
                    dropoff: viewModel.delivery.dropoff,
                  ),

                  AppSpacing.gapLG,

                  // =================================================
                  // DISTANCE / TIME
                  // =================================================

                  _TripSummaryCard(
                    distance: viewModel.delivery.distance,
                    time: viewModel.delivery.time,
                  ),

                  AppSpacing.gapLG,

                  // =================================================
                  // EARNING
                  // =================================================

                  _EarningCard(
                    earning: viewModel.delivery.earning,
                    paymentStatus:
                        viewModel.delivery.paymentStatus,
                  ),

                  AppSpacing.gapLG,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// =====================================================================
// SUCCESS SECTION
// =====================================================================

class _SuccessSection extends StatelessWidget {
  const _SuccessSection();

  @override
  Widget build(BuildContext context) {
    final bookingId = context
        .read<DeliveryCompletedViewModel>()
        .delivery
        .bookingId;

    return Column(
      children: [
        Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusXL,
            ),
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 44,
            color: AppColors.white,
          ),
        ),

        AppSpacing.gapLG,

        Text(
          'Delivery Completed',
          textAlign: TextAlign.center,
          style: AppTextStyles.headingLarge,
        ),

        AppSpacing.gapXS,

        Text(
          'Booking ID $bookingId',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMediumSecondary,
        ),

        AppSpacing.gapLG,

        const Divider(
          height: 1,
        ),
      ],
    );
  }
}

// =====================================================================
// ROUTE SECTION
// =====================================================================

class _RouteSection extends StatelessWidget {
  final String pickup;
  final String dropoff;

  const _RouteSection({
    required this.pickup,
    required this.dropoff,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // ROUTE INDICATOR
          // =====================================================

          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.textSecondary,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.circle,
                  size: 8,
                  color: AppColors.textSecondary,
                ),
              ),

              Container(
                width: 2,
                height: 38,
                margin: const EdgeInsets.symmetric(
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusCircular,
                  ),
                ),
              ),

              const Icon(
                Icons.location_on_outlined,
                size: 28,
                color: AppColors.primary,
              ),
            ],
          ),

          AppSpacing.horizontalMD,

          // =====================================================
          // ROUTE TEXT
          // =====================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PICK-UP',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 0.8,
                  ),
                ),

                AppSpacing.gapXS,

                Text(
                  pickup,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleLarge,
                ),

                AppSpacing.gapLG,

                Text(
                  'DROP-OFF',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 0.8,
                  ),
                ),

                AppSpacing.gapXS,

                Text(
                  dropoff,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// TRIP SUMMARY CARD
// =====================================================================

class _TripSummaryCard extends StatelessWidget {
  final String distance;
  final String time;

  const _TripSummaryCard({
    required this.distance,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      radius: AppSpacing.radiusLG,
      child: Row(
        children: [
          Expanded(
            child: _SummaryValue(
              label: 'DISTANCE',
              value: distance,
            ),
          ),

          Container(
            width: 1,
            height: 54,
            color: AppColors.divider,
          ),

          Expanded(
            child: _SummaryValue(
              label: 'TIME',
              value: time,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SUMMARY VALUE
// =====================================================================

class _SummaryValue extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryValue({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0.8,
          ),
        ),

        AppSpacing.gapSM,

        Text(
          value,
          textAlign: TextAlign.center,
          style: AppTextStyles.headingMedium,
        ),
      ],
    );
  }
}

// =====================================================================
// EARNING CARD
// =====================================================================

class _EarningCard extends StatelessWidget {
  final String earning;
  final String paymentStatus;

  const _EarningCard({
    required this.earning,
    required this.paymentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      radius: AppSpacing.radiusLG,
      child: Column(
        children: [
          Text(
            'YOUR EARNING',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.0,
            ),
          ),

          AppSpacing.gapMD,

          // =====================================================
          // EARNING
          // =====================================================

          Text(
            earning,
            textAlign: TextAlign.center,
            style: AppTextStyles.displayMedium,
          ),

          AppSpacing.gapLG,

          // =====================================================
          // PAYMENT STATUS
          // =====================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusSM,
              ),
            ),
            child: Text(
              paymentStatus,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// DONE BUTTON
// =====================================================================

class _DoneSection extends StatelessWidget {
  const _DoneSection();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.md,
          AppSpacing.screenHorizontal,
          AppSpacing.md,
        ),
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(
            top: BorderSide(
              color: AppColors.divider,
            ),
          ),
        ),
        child: AppPrimaryButton(
          title: 'DONE',
          onPressed: () {
            context
                .read<DeliveryCompletedViewModel>()
                .completeFlow(
              onPressed: () {
                debugPrint(
                  'Delivery flow completed',
                );

                // =================================================
                // RETURN TO HOME
                // =================================================

                
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) =>
                        const MainNavigationScreen(),
                  ),
                  (route) => false,
                );
              },
            );
          },
        ),
      ),
    );
  }
}