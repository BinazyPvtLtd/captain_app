import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../model/trip_detail_model.dart';
import '../view_model/trip_detail_view_model.dart';

class TripDetailScreen extends StatelessWidget {
  final TripDetailModel trip;

  const TripDetailScreen({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripDetailViewModel(
        trip: trip,
      ),
      child: const _TripDetailView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _TripDetailView extends StatelessWidget {
  const _TripDetailView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const _TripDetailHeader(),

            const Divider(
              height: 1,
            ),

            Expanded(
              child: Consumer<TripDetailViewModel>(
                builder: (
                  context,
                  viewModel,
                  child,
                ) {
                  final trip = viewModel.trip;

                  return SingleChildScrollView(
                    physics:
                        const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.fromLTRB(
                      AppSpacing.screenHorizontal,
                      AppSpacing.lg,
                      AppSpacing.screenHorizontal,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // =========================================
                        // BOOKING INFO
                        // =========================================

                        _BookingInfoSection(
                          bookingId:
                              trip.bookingId,
                          date:
                              trip.date,
                          time:
                              trip.time,
                          status:
                              trip.status,
                        ),

                        AppSpacing.gapXL,

                        const Divider(
                          height: 1,
                        ),

                        AppSpacing.gapXL,

                        // =========================================
                        // ROUTE
                        // =========================================

                        _RouteSection(
                          pickup:
                              trip.pickup,
                          dropoff:
                              trip.dropoff,
                        ),

                        AppSpacing.gapXL,

                        // =========================================
                        // TRIP META
                        // =========================================

                        _TripMetaGrid(
                          distance:
                              trip.distance,
                          duration:
                              trip.duration,
                          goodsType:
                              trip.goodsType,
                          vehicleType:
                              trip.vehicleType,
                        ),

                        AppSpacing.gapXL,

                        // =========================================
                        // FARE / EARNING
                        // =========================================

                        _FareEarningCard(
                          fare:
                              trip.fare,
                          earning:
                              trip.earning,
                        ),

                        AppSpacing.gapXXL,

                        // =========================================
                        // SUPPORT
                        // =========================================

                        Center(
                          child: TextButton.icon(
                            onPressed: () {
                              viewModel.contactSupport(
                                onPressed: () {
                                  debugPrint(
                                    'Contact support',
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.support_agent_outlined,
                              color:
                                  AppColors.textSecondary,
                            ),
                            label: Text(
                              'Contact Support',
                              style:
                                  AppTextStyles.titleMedium.copyWith(
                                color:
                                    AppColors.textSecondary,
                                decoration:
                                    TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class _TripDetailHeader extends StatelessWidget {
  const _TripDetailHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: AppSpacing.iconMD,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          Expanded(
            child: Text(
              'Trip Details',
              textAlign: TextAlign.center,
              style:
                  AppTextStyles.headingLarge,
            ),
          ),

          const SizedBox(
            width: 56,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// BOOKING INFO
// =====================================================================

class _BookingInfoSection
    extends StatelessWidget {
  final String bookingId;
  final String date;
  final String time;
  final String status;

  const _BookingInfoSection({
    required this.bookingId,
    required this.date,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'BOOKING ID',
                style:
                    AppTextStyles.labelMedium.copyWith(
                  color:
                      AppColors.textSecondary,
                  letterSpacing: 0.9,
                ),
              ),

              AppSpacing.gapXS,

              Text(
                bookingId,
                style:
                    AppTextStyles.headingLarge,
              ),

              AppSpacing.gapSM,

              Text(
                '$date • $time',
                style:
                    AppTextStyles.bodyMediumSecondary,
              ),
            ],
          ),
        ),

        AppSpacing.horizontalMD,

        _StatusBox(
          status: status,
        ),
      ],
    );
  }
}

// =====================================================================
// STATUS
// =====================================================================

class _StatusBox extends StatelessWidget {
  final String status;

  const _StatusBox({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool completed =
        status.toLowerCase() ==
            'completed';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: completed
            ? AppColors.primary
            : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusSM,
        ),
        border: Border.all(
          color: AppColors.primary,
        ),
      ),
      child: Text(
        status,
        style:
            AppTextStyles.titleMedium.copyWith(
          color: completed
              ? AppColors.white
              : AppColors.textPrimary,
        ),
      ),
    );
  }
}

// =====================================================================
// ROUTE
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
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'ROUTE',
          style:
              AppTextStyles.labelMedium.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0.9,
          ),
        ),

        AppSpacing.gapLG,

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.circle,
                    size: 8,
                    color: AppColors.primary,
                  ),
                ),

                Container(
                  width: 2,
                  height: 54,
                  decoration:
                      const BoxDecoration(
                    color: AppColors.border,
                  ),
                ),

                Container(
                  width: 28,
                  height: 28,
                  decoration:
                      const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.location_on_outlined,
                    size: 17,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),

            AppSpacing.horizontalMD,

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pickup',
                    style:
                        AppTextStyles.bodyMediumSecondary,
                  ),

                  AppSpacing.gapXS,

                  Text(
                    pickup,
                    style:
                        AppTextStyles.titleLarge,
                  ),

                  AppSpacing.gapLG,

                  Text(
                    'Drop',
                    style:
                        AppTextStyles.bodyMediumSecondary,
                  ),

                  AppSpacing.gapXS,

                  Text(
                    dropoff,
                    style:
                        AppTextStyles.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// =====================================================================
// TRIP META GRID
// =====================================================================

class _TripMetaGrid extends StatelessWidget {
  final String distance;
  final String duration;
  final String goodsType;
  final String vehicleType;

  const _TripMetaGrid({
    required this.distance,
    required this.duration,
    required this.goodsType,
    required this.vehicleType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MetaItem(
                icon:
                    Icons.route_outlined,
                label:
                    'Distance',
                value:
                    distance,
              ),
            ),

            AppSpacing.horizontalMD,

            Expanded(
              child: _MetaItem(
                icon:
                    Icons.schedule_outlined,
                label:
                    'Duration',
                value:
                    duration,
              ),
            ),
          ],
        ),

        AppSpacing.gapLG,

        Row(
          children: [
            Expanded(
              child: _MetaItem(
                icon:
                    Icons.inventory_2_outlined,
                label:
                    'Goods',
                value:
                    goodsType,
              ),
            ),

            AppSpacing.horizontalMD,

            Expanded(
              child: _MetaItem(
                icon:
                    Icons.local_shipping_outlined,
                label:
                    'Vehicle',
                value:
                    vehicleType,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// =====================================================================
// META ITEM
// =====================================================================

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetaItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: AppColors.divider,
            width: 2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: AppSpacing.iconSM,
                color:
                    AppColors.textSecondary,
              ),

              AppSpacing.horizontalXS,

              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  style:
                      AppTextStyles.bodyMediumSecondary,
                ),
              ),
            ],
          ),

          AppSpacing.gapSM,

          Text(
            value,
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style:
                AppTextStyles.titleLarge,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// FARE / EARNING
// =====================================================================

class _FareEarningCard
    extends StatelessWidget {
  final String fare;
  final String earning;

  const _FareEarningCard({
    required this.fare,
    required this.earning,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      radius: AppSpacing.radiusLG,
      backgroundColor:
          AppColors.surfaceSecondary,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Fare',
                  style:
                      AppTextStyles.bodyMediumSecondary,
                ),
              ),

              Text(
                fare,
                style:
                    AppTextStyles.titleLarge,
              ),
            ],
          ),

          AppSpacing.gapMD,

          const Divider(
            height: 1,
          ),

          AppSpacing.gapMD,

          Row(
            children: [
              Expanded(
                child: Text(
                  'Your Earning',
                  style:
                      AppTextStyles.titleMedium,
                ),
              ),

              Text(
                earning,
                style:
                    AppTextStyles.headingLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}