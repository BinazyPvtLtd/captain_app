import 'package:driver_app/features/pickup/model/active_delivery_model.dart';
import 'package:driver_app/features/pickup/view/active_delivery_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_primary_button.dart';

import '../model/trip_details_model.dart';
import '../view_model/trip_details_view_model.dart';

class TripDetailsScreen extends StatelessWidget {
  final TripDetailsModel trip;

  const TripDetailsScreen({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripDetailsViewModel(
        trip: trip,
      ),
      child: const _TripDetailsView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _TripDetailsView extends StatelessWidget {
  const _TripDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // =========================================================
      // FIXED START TRIP BUTTON
      // =========================================================

      bottomNavigationBar:
          const _StartTripSection(),

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            const _Header(),

            const Divider(
              height: 1,
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: Consumer<TripDetailsViewModel>(
                builder: (
                  context,
                  viewModel,
                  child,
                ) {
                  return SingleChildScrollView(
                    physics:
                        const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.fromLTRB(
                      AppSpacing.screenHorizontal,
                      AppSpacing.md,
                      AppSpacing.screenHorizontal,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      children: [
                        // =========================================
                        // PICKUP CONFIRMED
                        // =========================================

                        const _PickupConfirmedSection(),

                        AppSpacing.gapSM,

                        // =========================================
                        // ROUTE
                        // =========================================

                        _RouteCard(
                          pickup:
                              viewModel.trip.pickup,
                          dropoff:
                              viewModel.trip.dropoff,
                        ),

                        AppSpacing.gapSM,

                        // =========================================
                        // TRIP DETAILS
                        // =========================================

                        _TripInfoCard(
                          distance:
                              viewModel
                                  .trip
                                  .estimatedDistance,
                          time:
                              viewModel
                                  .trip
                                  .estimatedTime,
                        ),

                        AppSpacing.gapMD,

                        // =========================================
                        // GOODS
                        // =========================================

                        _GoodsCard(
                          goodsType:
                              viewModel
                                  .trip
                                  .goodsType,
                          quantity:
                              viewModel
                                  .trip
                                  .quantity,
                        ),

                        AppSpacing.gapMD,

                        // =========================================
                        // CUSTOMER
                        // =========================================

                        _CustomerCard(
                          customerName:
                              viewModel
                                  .trip
                                  .customerName,
                          customerImage:
                              viewModel
                                  .trip
                                  .customerImage,
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

                        AppSpacing.gapMD,
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: AppSpacing.iconLG,
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
            width: 64,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// PICKUP CONFIRMED
// =====================================================================

class _PickupConfirmedSection
    extends StatelessWidget {
  const _PickupConfirmedSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusXXL,
            ),
          ),
          child: const Icon(
            Icons.check_circle_outline_rounded,
            size: 46,
            color: AppColors.white,
          ),
        ),

        AppSpacing.gapMD,

        Text(
          'Pickup Confirmed',
          textAlign: TextAlign.center,
          style:
              AppTextStyles.displaySmall,
        ),

        AppSpacing.gapXS,

        Text(
          'Ready to begin the journey',
          textAlign: TextAlign.center,
          style:
              AppTextStyles.bodyLargeSecondary,
        ),
      ],
    );
  }
}

// =====================================================================
// ROUTE CARD
// =====================================================================

class _RouteCard extends StatelessWidget {
  final String pickup;
  final String dropoff;

  const _RouteCard({
    required this.pickup,
    required this.dropoff,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      radius: AppSpacing.radiusLG,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'ROUTE',
            style:
                AppTextStyles.labelLarge.copyWith(
              letterSpacing: 1.1,
            ),
          ),

          AppSpacing.gapMD,

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // =============================================
              // ROUTE ICONS
              // =============================================

              Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color:
                          AppColors.background,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            AppColors.primary,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.circle,
                      size: 10,
                      color:
                          AppColors.primary,
                    ),
                  ),

                  Container(
                    width: 1.5,
                    height: 58,
                    color:
                        AppColors.borderDark,
                  ),

                  Container(
                    width: 34,
                    height: 34,
                    decoration:
                        const BoxDecoration(
                      color:
                          AppColors.primary,
                      shape:
                          BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color:
                          AppColors.white,
                    ),
                  ),
                ],
              ),

              AppSpacing.horizontalMD,

              // =============================================
              // ROUTE TEXT
              // =============================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PICKUP',
                      style:
                          AppTextStyles.labelMedium.copyWith(
                        color:
                            AppColors.textSecondary,
                        letterSpacing: 0.8,
                      ),
                    ),

                    AppSpacing.gapXXS,

                    Text(
                      pickup,
                      style:
                          AppTextStyles.headingMedium,
                    ),

                    AppSpacing.gapXL,

                    Text(
                      'DROPOFF',
                      style:
                          AppTextStyles.labelMedium.copyWith(
                        color:
                            AppColors.textSecondary,
                        letterSpacing: 0.8,
                      ),
                    ),

                    AppSpacing.gapXXS,

                    Text(
                      dropoff,
                      style:
                          AppTextStyles.headingMedium,
                    ),
                  ],
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
// TRIP INFO
// =====================================================================

class _TripInfoCard extends StatelessWidget {
  final String distance;
  final String time;

  const _TripInfoCard({
    required this.distance,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      radius: AppSpacing.radiusLG,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'TRIP DETAILS',
            style:
                AppTextStyles.labelLarge.copyWith(
              letterSpacing: 1.1,
            ),
          ),

          AppSpacing.gapMD,

          _InfoRow(
            label: 'Est. Distance',
            value: distance,
          ),

          AppSpacing.gapMD,

          const Divider(
            height: 1,
          ),

          AppSpacing.gapMD,

          _InfoRow(
            label: 'Est. Time',
            value: time,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// INFO ROW
// =====================================================================

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style:
                AppTextStyles.bodyLargeSecondary,
          ),
        ),

        AppSpacing.horizontalMD,

        Text(
          value,
          style:
              AppTextStyles.titleLarge,
        ),
      ],
    );
  }
}

// =====================================================================
// GOODS CARD
// =====================================================================

class _GoodsCard extends StatelessWidget {
  final String goodsType;
  final String quantity;

  const _GoodsCard({
    required this.goodsType,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      radius: AppSpacing.radiusLG,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'GOODS INFORMATION',
            style:
                AppTextStyles.labelLarge.copyWith(
              letterSpacing: 1.1,
            ),
          ),

          AppSpacing.gapLG,

          _GoodsRow(
            icon:
                Icons.inventory_2_outlined,
            label:
                'TYPE',
            value:
                goodsType,
          ),

          AppSpacing.gapLG,

          _GoodsRow(
            icon:
                Icons.format_list_numbered_rounded,
            label:
                'QUANTITY',
            value:
                quantity,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// GOODS ROW
// =====================================================================

class _GoodsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _GoodsRow({
    required this.icon,
    required this.label,
    required this.value,
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
          ),
          child: Icon(
            icon,
            color:
                AppColors.textPrimary,
            size:
                AppSpacing.iconMD,
          ),
        ),

        AppSpacing.horizontalMD,

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    AppTextStyles.labelMedium.copyWith(
                  color:
                      AppColors.textSecondary,
                  letterSpacing: 0.8,
                ),
              ),

              AppSpacing.gapXXS,

              Text(
                value,
                style:
                    AppTextStyles.titleLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// CUSTOMER CARD
// =====================================================================

class _CustomerCard extends StatelessWidget {
  final String customerName;
  final String? customerImage;
  final VoidCallback onCall;

  const _CustomerCard({
    required this.customerName,
    required this.customerImage,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      radius: AppSpacing.radiusLG,
      child: Row(
        children: [
          _CustomerAvatar(
            name: customerName,
            image: customerImage,
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
                      AppTextStyles.labelMedium.copyWith(
                    color:
                        AppColors.textSecondary,
                    letterSpacing: 0.8,
                  ),
                ),

                AppSpacing.gapXXS,

                Text(
                  customerName,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      AppTextStyles.headingMedium,
                ),
              ],
            ),
          ),

          AppSpacing.horizontalMD,

          Container(
            width: 54,
            height: 54,
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
      ),
    );
  }
}

// =====================================================================
// CUSTOMER AVATAR
// =====================================================================

class _CustomerAvatar extends StatelessWidget {
  final String name;
  final String? image;

  const _CustomerAvatar({
    required this.name,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 56;

    if (image != null &&
        image!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLG,
        ),
        child: Image.network(
          image!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            return _AvatarFallback(
              name: name,
            );
          },
        ),
      );
    }

    return _AvatarFallback(
      name: name,
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  final String name;

  const _AvatarFallback({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final initial =
        name.trim().isEmpty
            ? '?'
            : name
                .trim()
                .substring(0, 1)
                .toUpperCase();

    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color:
            AppColors.surfaceSecondary,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusLG,
        ),
        border: Border.all(
          color:
              AppColors.border,
        ),
      ),
      child: Text(
        initial,
        style:
            AppTextStyles.headingMedium,
      ),
    );
  }
}

// =====================================================================
// START TRIP
// =====================================================================

class _StartTripSection extends StatelessWidget {
  const _StartTripSection();

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
        child: Consumer<TripDetailsViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return AppPrimaryButton(
              title: 'START TRIP',
              icon:
                  Icons.play_arrow_rounded,
              isLoading:
                  viewModel.isStartingTrip,
              onPressed: () {
                viewModel.startTrip(
                  onSuccess: () {
  final trip = context
      .read<TripDetailsViewModel>()
      .trip;

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => ActiveDeliveryScreen(
        delivery: ActiveDeliveryModel(
          bookingId:
              trip.bookingId,

          destination:
              '${trip.dropoff}, Lucknow',

          distance:
              '6.4 km',

          eta:
              '18 min',

          customerName:
              trip.customerName,

          customerId:
              '#PAT10285',

          customerImage:
              trip.customerImage,

          customerPhone:
              trip.customerPhone,
        ),
      ),
    ),
  );
},
                );
              },
            );
          },
        ),
      ),
    );
  }
}