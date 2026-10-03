import 'package:driver_app/features/booking/model/delivery_request_model.dart';
import 'package:driver_app/features/booking/view/delivery_request_screen.dart';
import 'package:driver_app/features/notifications/view/notifications_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../view_model/home_view_model.dart';
import '../widgets/driver_status_card.dart';
import '../widgets/home_stats_card.dart';
import '../widgets/recent_trip_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: const _HomeView(),
    );
  }
}

// =====================================================================
// HOME VIEW
// =====================================================================

class _HomeView extends StatelessWidget {
  const _HomeView();

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
            const _HomeHeader(),

            const Divider(height: 1),

            // =====================================================
            // CONTENT
            // =====================================================
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                  AppSpacing.screenHorizontal,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _GreetingSection(),

                    AppSpacing.gapLG,

                    DriverStatusCard(
                      onBookingFound: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (_) => const DeliveryRequestScreen(
                              request: DeliveryRequestModel(
                                id: 'booking_001',
                                pickup: 'Gomti Nagar',
                                drop: 'Indira Nagar',
                                pickupDistance: '2.1 km away',
                                tripDistance: '9.4 km',
                                estimatedTime: '32 min',
                                earning: '₹240',
                                goodsType: 'Furniture (2 Items)',
                                vehicleRequired: 'Mini Truck',
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    AppSpacing.gapXL,

                    Text(
                      'TODAY',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),

                    AppSpacing.gapSM,

                    const Divider(height: 1),

                    AppSpacing.gapMD,

                    const _StatsGrid(),

                    AppSpacing.gapXL,

                    Text(
                      'RECENT TRIP',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),

                    AppSpacing.gapSM,

                    const Divider(height: 1),

                    AppSpacing.gapMD,

                    const _RecentTripSection(),

                    AppSpacing.gapLG,
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

// =====================================================================
// HEADER
// =====================================================================

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Row(
          children: [
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () {
                context.read<HomeViewModel>().openMenu(
                  onPressed: () {
                    debugPrint('Open drawer');
                  },
                );
              },
              icon: const Icon(
                Icons.menu_rounded,
                size: AppSpacing.iconMD,
                color: AppColors.textPrimary,
              ),
            ),

            AppSpacing.horizontalXXS,

            Image.asset(
              AppAssets.patgolitoLogo1,
              width: 96,
              height: 52,
              fit: BoxFit.contain,
            ),

            const Spacer(),

            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'Notifications',
                  barrierColor: Colors.black.withValues(alpha: 0.20),
                  transitionDuration: const Duration(milliseconds: 280),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const Align(
                      alignment: Alignment.topCenter,
                      child: NotificationsSheet(),
                    );
                  },
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                          reverseCurve: Curves.easeInCubic,
                        );

                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -1),
                            end: Offset.zero,
                          ).animate(curvedAnimation),
                          child: FadeTransition(
                            opacity: curvedAnimation,
                            child: child,
                          ),
                        );
                      },
                );
              },
              icon: const Icon(
                Icons.notifications_none_rounded,
                size: AppSpacing.iconMD,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// GREETING
// =====================================================================

class _GreetingSection extends StatelessWidget {
  const _GreetingSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning, ${viewModel.driverName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.headingLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            AppSpacing.gapXXS,

            Text(
              'Ready to start earning?',
              style: AppTextStyles.bodyMediumSecondary,
            ),
          ],
        );
      },
    );
  }
}
// =====================================================================
// STATS GRID
// =====================================================================

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.stats.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.75,
          ),
          itemBuilder: (context, index) {
            return HomeStatsCard(stat: viewModel.stats[index]);
          },
        );
      },
    );
  }
}

// =====================================================================
// RECENT TRIP
// =====================================================================

class _RecentTripSection extends StatelessWidget {
  const _RecentTripSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final trip = viewModel.recentTrip;

        if (trip == null) {
          return Text(
            'No recent trips yet.',
            style: AppTextStyles.bodyMediumSecondary,
          );
        }

        return RecentTripCard(trip: trip);
      },
    );
  }
}
