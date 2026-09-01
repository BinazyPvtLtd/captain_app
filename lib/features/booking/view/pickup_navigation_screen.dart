import 'package:driver_app/features/pickup/model/pickup_task_model.dart';
import 'package:driver_app/features/pickup/view/pickup_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_primary_button.dart';

import '../model/pickup_navigation_model.dart';
import '../view_model/pickup_navigation_view_model.dart';

class PickupNavigationScreen extends StatelessWidget {
  final PickupNavigationModel booking;

  const PickupNavigationScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PickupNavigationViewModel(
        booking: booking,
      ),
      child: const _PickupNavigationView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _PickupNavigationView extends StatelessWidget {
  const _PickupNavigationView();

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

            const _PickupHeader(),

            const Divider(
              height: 1,
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: Consumer<PickupNavigationViewModel>(
                builder: (
                  context,
                  viewModel,
                  child,
                ) {
                  return SingleChildScrollView(
                    physics:
                        const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // =========================================
                        // MAP
                        // =========================================

                        const _MapPreview(),

                        // =========================================
                        // DETAILS
                        // =========================================

                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(
                            AppSpacing.screenHorizontal,
                            AppSpacing.xl,
                            AppSpacing.screenHorizontal,
                            AppSpacing.xxl,
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              // =================================
                              // ETA / DISTANCE
                              // =================================

                              _EtaDistanceSection(
                                eta: viewModel.booking.eta,
                                distance:
                                    viewModel.booking.distance,
                              ),

                              AppSpacing.gapXL,

                              const Divider(
                                height: 1,
                              ),

                              AppSpacing.gapXL,

                              // =================================
                              // PICKUP LOCATION
                              // =================================

                              _PickupLocationSection(
                                address:
                                    viewModel
                                        .booking
                                        .pickupAddress,
                              ),

                              AppSpacing.gapXL,

                              // =================================
                              // CUSTOMER
                              // =================================

                              _CustomerSection(
                                customerName:
                                    viewModel
                                        .booking
                                        .customerName,
                                onCall: () {
                                  viewModel.callCustomer(
                                    onPressed: () {
                                      debugPrint(
                                        'Call customer',
                                      );
                                    },
                                  );
                                },
                              ),

                              AppSpacing.gapXL,

                              // =================================
                              // OPEN MAPS
                              // =================================

                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    viewModel.openMaps(
                                      onPressed: () {
                                        debugPrint(
                                          'Open external maps',
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.map_outlined,
                                  ),
                                  label: const Text(
                                    'OPEN IN MAPS',
                                  ),
                                ),
                              ),

                              AppSpacing.gapXL,

                              // =================================
                              // START TRIP
                              // =================================

                              AppPrimaryButton(
                                title: 'I HAVE ARRIVED',
                                isLoading:
                                    viewModel
                                        .isStartingTrip,
                                onPressed: () {
                                  viewModel.startTrip(
                                    onSuccess: () {
  final booking = context
      .read<PickupNavigationViewModel>()
      .booking;

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => PickupTaskScreen(
        task: PickupTaskModel(
          bookingId: booking.bookingId,
          pickupLocation: 'Gomti Nagar',
          customerName: booking.customerName,
        ),
      ),
    ),
  );
},
                                  );
                                },
                              ),
                            ],
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

class _PickupHeader extends StatelessWidget {
  const _PickupHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal:
              AppSpacing.screenHorizontal,
        ),
        child: Row(
          children: [
            // =================================================
            // LOGO
            // =================================================

            Image.asset(
              AppAssets.patgolitoLogo1,
              width: 90,
              height: 42,
              fit: BoxFit.contain,
            ),

            AppSpacing.horizontalXXS,

            Expanded(
              child: Text(
                'PATGOLITO DRIVER',
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style:
                    AppTextStyles.headingLarge,
              ),
            ),

            // =================================================
            // MENU
            // =================================================

            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color:
                    AppColors.surfaceSecondary,
                borderRadius:
                    BorderRadius.circular(
                  AppSpacing.radiusMD,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  debugPrint(
                    'Open driver menu',
                  );
                },
                icon: const Icon(
                  Icons.menu_rounded,
                  color:
                      AppColors.textPrimary,
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
// MAP PREVIEW
// =====================================================================

class _MapPreview extends StatelessWidget {
  const _MapPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      width: double.infinity,
      child: Stack(
        children: [
          // =====================================================
          // TEMPORARY MAP PLACEHOLDER
          // =====================================================

          Positioned.fill(
            child: Container(
              color:
                  AppColors.surfaceSecondary,
              child: const Center(
                child: Icon(
                  Icons.map_outlined,
                  size: 72,
                  color:
                      AppColors.textSecondary,
                ),
              ),
            ),
          ),

          // =====================================================
          // ETA CHIP
          // =====================================================

          Positioned(
            top: AppSpacing.md,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal:
                      AppSpacing.md,
                  vertical:
                      AppSpacing.sm,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      AppColors.background,
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusCircular,
                  ),
                  border: Border.all(
                    color:
                        AppColors.border,
                  ),
                ),
                child: Text(
                  '14 Min, 3.1 km',
                  style:
                      AppTextStyles.titleSmall,
                ),
              ),
            ),
          ),

          // =====================================================
          // RECENTER
          // =====================================================

          Positioned(
            right:
                AppSpacing.screenHorizontal,
            bottom: AppSpacing.lg,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color:
                    AppColors.background,
                borderRadius:
                    BorderRadius.circular(
                  AppSpacing.radiusMD,
                ),
                border: Border.all(
                  color:
                      AppColors.border,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  context
                      .read<
                          PickupNavigationViewModel>()
                      .recenterMap(
                    onPressed: () {
                      debugPrint(
                        'Recenter map',
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.my_location_rounded,
                  color:
                      AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// ETA / DISTANCE
// =====================================================================

class _EtaDistanceSection
    extends StatelessWidget {
  final String eta;
  final String distance;

  const _EtaDistanceSection({
    required this.eta,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // =====================================================
        // ETA
        // =====================================================

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'EST. ARRIVAL',
                style:
                    AppTextStyles.labelLarge.copyWith(
                  color:
                      AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
              ),

              AppSpacing.gapXXS,

              Text(
                eta,
                style:
                    AppTextStyles.displayMedium.copyWith(
                  fontWeight:
                      FontWeight.w800,
                ),
              ),
            ],
          ),
        ),

        Container(
          width: 1,
          height: 60,
          color:
              AppColors.divider,
        ),

        AppSpacing.horizontalLG,

        // =====================================================
        // DISTANCE
        // =====================================================

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'DISTANCE',
                style:
                    AppTextStyles.labelLarge.copyWith(
                  color:
                      AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
              ),

              AppSpacing.gapXXS,

              Text(
                distance,
                style:
                    AppTextStyles.headingLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// PICKUP LOCATION
// =====================================================================

class _PickupLocationSection
    extends StatelessWidget {
  final String address;

  const _PickupLocationSection({
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color:
                AppColors.primary,
            borderRadius:
                BorderRadius.circular(
              AppSpacing.radiusMD,
            ),
          ),
          child: const Icon(
            Icons.location_on_outlined,
            color:
                AppColors.white,
          ),
        ),

        AppSpacing.horizontalMD,

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'PICKUP LOCATION',
                style:
                    AppTextStyles.labelLarge.copyWith(
                  color:
                      AppColors.textSecondary,
                  letterSpacing: 1,
                ),
              ),

              AppSpacing.gapXXS,

              Text(
                address,
                style:
                    AppTextStyles.headingMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// CUSTOMER
// =====================================================================

class _CustomerSection extends StatelessWidget {
  final String customerName;
  final VoidCallback onCall;

  const _CustomerSection({
    required this.customerName,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
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
          child: const Icon(
            Icons.person_outline_rounded,
            color:
                AppColors.textPrimary,
          ),
        ),

        AppSpacing.horizontalMD,

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'CUSTOMER',
                style:
                    AppTextStyles.labelLarge.copyWith(
                  color:
                      AppColors.textSecondary,
                  letterSpacing: 1,
                ),
              ),

              AppSpacing.gapXXS,

              Text(
                customerName,
                style:
                    AppTextStyles.headingMedium,
              ),
            ],
          ),
        ),

        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color:
                AppColors.primary,
            borderRadius:
                BorderRadius.circular(
              AppSpacing.radiusMD,
            ),
          ),
          child: IconButton(
            onPressed: onCall,
            icon: const Icon(
              Icons.phone_outlined,
              color:
                  AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}