import 'package:driver_app/features/trips/model/trip_detail_model.dart';
import 'package:driver_app/features/trips/view/trip_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../model/trip_history_model.dart';
import '../view_model/trips_view_model.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripsViewModel(),
      child: const _TripsView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _TripsView extends StatelessWidget {
  const _TripsView();

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

            const _TripsHeader(),

            const Divider(
              height: 1,
            ),

            // =====================================================
            // FILTERS
            // =====================================================

            const _TripFilters(),

            // =====================================================
            // LIST
            // =====================================================

            Expanded(
              child: Consumer<TripsViewModel>(
                builder: (
                  context,
                  viewModel,
                  child,
                ) {
                  final grouped =
                      viewModel.groupedTrips;

                  if (grouped.isEmpty) {
                    return const _EmptyTrips();
                  }

                  return ListView(
                    physics:
                        const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.only(
                      bottom: AppSpacing.xl,
                    ),
                    children: grouped.entries
                        .map(
                          (entry) =>
                              _TripSection(
                            title: entry.key,
                            trips:
                                entry.value,
                          ),
                        )
                        .toList(),
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

class _TripsHeader extends StatelessWidget {
  const _TripsHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.read<TripsViewModel>().openMenu(
                    onPressed: () {
                      debugPrint('Open menu');
                    },
                  );
                },
                icon: const Icon(
                  Icons.menu_rounded,
                  size: AppSpacing.iconMD,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            Expanded(
              child: Text(
                'Your Trips',
                textAlign: TextAlign.center,
                style: AppTextStyles.headingLarge,
              ),
            ),

            // SizedBox(
            //   width: 44,
            //   height: 44,
            //   child: IconButton(
            //     padding: EdgeInsets.zero,
            //     onPressed: () {
            //       context
            //           .read<TripsViewModel>()
            //           .openNotifications(
            //         onPressed: () {
            //           debugPrint('Open notifications');
            //         },
            //       );
            //     },
            //     icon: const Icon(
            //       Icons.notifications_none_rounded,
            //       size: AppSpacing.iconMD,
            //       color: AppColors.textPrimary,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// FILTERS
// =====================================================================

class _TripFilters extends StatelessWidget {
  const _TripFilters();

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.watch<TripsViewModel>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.md,
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _FilterButton(
                  title: 'All',
                  selected:
                      viewModel.selectedFilter ==
                          TripFilter.all,
                  onPressed: () {
                    viewModel.changeFilter(
                      TripFilter.all,
                    );
                  },
                ),
              ),

              AppSpacing.horizontalSM,

              Expanded(
                child: _FilterButton(
                  title: 'Completed',
                  selected:
                      viewModel.selectedFilter ==
                          TripFilter.completed,
                  onPressed: () {
                    viewModel.changeFilter(
                      TripFilter.completed,
                    );
                  },
                ),
              ),

              AppSpacing.horizontalSM,

              Expanded(
                child: _FilterButton(
                  title: 'Cancelled',
                  selected:
                      viewModel.selectedFilter ==
                          TripFilter.cancelled,
                  onPressed: () {
                    viewModel.changeFilter(
                      TripFilter.cancelled,
                    );
                  },
                ),
              ),
            ],
          ),

          AppSpacing.gapMD,

          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onPressed;

  const _FilterButton({
    required this.title,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Material(
        color: selected
            ? AppColors.primary
            : AppColors.background,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusSM,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusSM,
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusSM,
              ),
              border: Border.all(
                color: AppColors.primary,
              ),
            ),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.titleMedium.copyWith(
                color: selected
                    ? AppColors.white
                    : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION
// =====================================================================

class _TripSection extends StatelessWidget {
  final String title;
  final List<TripHistoryModel> trips;

  const _TripSection({
    required this.title,
    required this.trips,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.md,
            AppSpacing.screenHorizontal,
            AppSpacing.sm,
          ),
          child: Text(
            title,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
        ),

        ...trips.map(
          (trip) => _TripItem(
            trip: trip,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// TRIP ITEM
// =====================================================================

class _TripItem extends StatelessWidget {
  final TripHistoryModel trip;

  const _TripItem({
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    final bool completed =
        trip.status ==
            TripStatus.completed;

    return InkWell(
      onTap: () {
        context.read<TripsViewModel>().openTrip(
          trip: trip,
          onPressed: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) =>
          TripDetailScreen(
        trip: TripDetailModel(
          bookingId:
              '#${trip.id}',
          date:
              '22 Aug 2026',
          time:
              trip.time,
          status:
              trip.status ==
                      TripStatus.completed
                  ? 'Completed'
                  : 'Cancelled',
          pickup:
              trip.pickup,
          dropoff:
              trip.dropoff,
          distance:
              '9.2 km',
          duration:
              '31 min',
          goodsType:
              'Furniture',
          vehicleType:
              'Mini Truck',
          fare:
              '₹480',
          earning:
              trip.amount,
        ),
      ),
    ),
  );
},
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: AppSpacing.md,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.divider,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(
                  AppSpacing.radiusLG,
                ),
              ),
              child: const Icon(
                Icons.route_rounded,
                size: AppSpacing.iconMD,
                color: AppColors.textPrimary,
              ),
            ),

            AppSpacing.horizontalMD,

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    '${trip.pickup} → ${trip.dropoff}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  AppSpacing.gapXS,

                  Wrap(
                    crossAxisAlignment:
                        WrapCrossAlignment.center,
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: [
                      Text(
                        trip.time,
                        style: AppTextStyles
                            .bodyMediumSecondary,
                      ),

                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppColors.borderDark,
                          shape: BoxShape.circle,
                        ),
                      ),

                      _TripStatusBadge(
                        completed: completed,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            AppSpacing.horizontalSM,

            Text(
              trip.amount,
              style: AppTextStyles.headingMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            AppSpacing.horizontalXS,

            const Icon(
              Icons.chevron_right_rounded,
              size: AppSpacing.iconSM,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// STATUS BADGE
// =====================================================================

class _TripStatusBadge extends StatelessWidget {
  final bool completed;

  const _TripStatusBadge({
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusXS,
        ),
      ),
      child: Text(
        completed
            ? 'Completed'
            : 'Cancelled',
        style: AppTextStyles.labelMedium.copyWith(
          color: completed
              ? AppColors.textPrimary
              : AppColors.textSecondary,
        ),
      ),
    );
  }
}

// =====================================================================
// EMPTY STATE
// =====================================================================

class _EmptyTrips extends StatelessWidget {
  const _EmptyTrips();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            const Icon(
              Icons.route_outlined,
              size: 52,
              color:
                  AppColors.textSecondary,
            ),

            AppSpacing.gapMD,

            Text(
              'No trips found',
              style:
                  AppTextStyles.headingMedium,
            ),

            AppSpacing.gapXS,

            Text(
              'Your trips will appear here.',
              textAlign:
                  TextAlign.center,
              style:
                  AppTextStyles.bodyMediumSecondary,
            ),
          ],
        ),
      ),
    );
  }
}