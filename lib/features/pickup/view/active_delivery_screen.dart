import 'package:driver_app/features/destination_&_payment/model/delivery_arrived_model.dart';
import 'package:driver_app/features/destination_&_payment/view/delivery_arrived_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_primary_button.dart';

import '../model/active_delivery_model.dart';
import '../view_model/active_delivery_view_model.dart';

class ActiveDeliveryScreen extends StatelessWidget {
  final ActiveDeliveryModel delivery;

  const ActiveDeliveryScreen({
    super.key,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActiveDeliveryViewModel(
        delivery: delivery,
      ),
      child: const _ActiveDeliveryView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _ActiveDeliveryView extends StatelessWidget {
  const _ActiveDeliveryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Consumer<ActiveDeliveryViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                bottom: AppSpacing.xl,
              ),
              child: Column(
                children: [
                  // =================================================
                  // MAP AREA
                  // =================================================

                  const _DeliveryMapSection(),

                  // =================================================
                  // DETAILS
                  // =================================================

                  Padding(
                    padding: const EdgeInsets.fromLTRB(
  AppSpacing.screenHorizontal,
  AppSpacing.lg,
  AppSpacing.screenHorizontal,
  AppSpacing.lg,
),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // ===========================================
                        // DISTANCE / ETA
                        // ===========================================

                        _DeliveryStats(
                          distance:
                              viewModel.delivery.distance,
                          eta:
                              viewModel.delivery.eta,
                        ),

                        AppSpacing.gapMD,

                        // ===========================================
                        // DESTINATION
                        // ===========================================

                        Text(
                          'DESTINATION',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textSecondary,
                            letterSpacing: 1.2,
                          ),
                        ),

                        AppSpacing.gapXXS,

                        Text(
                          viewModel.delivery.destination,
                          style: AppTextStyles.headingMedium,
                        ),

                        AppSpacing.gapMD,

                        const Divider(
                          height: 1,
                        ),

                        AppSpacing.gapMD,

                        // ===========================================
                        // CUSTOMER
                        // ===========================================

                        _CustomerRow(
                          name:
                              viewModel.delivery.customerName,
                          id:
                              viewModel.delivery.customerId,
                          image:
                              viewModel.delivery.customerImage,
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

                        // ===========================================
                        // NAVIGATE
                        // ===========================================

                        AppPrimaryButton(
  title: 'NAVIGATE',
  icon: Icons.navigation_outlined,
  onPressed: () {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => DeliveryArrivedScreen(
          delivery: DeliveryArrivedModel(
            bookingId: viewModel.delivery.bookingId,
            destination: viewModel.delivery.destination,
            customerName: viewModel.delivery.customerName,
            customerRole: 'Recipient',
            customerImage: viewModel.delivery.customerImage,
            customerPhone: viewModel.delivery.customerPhone,
          ),
        ),
      ),
    );
  },
),

                        AppSpacing.gapSM,

                        // ===========================================
                        // EMERGENCY
                        // ===========================================

                        Center(
                          child: TextButton.icon(
                            onPressed: () {
                              viewModel.openEmergencyHelp(
                                onPressed: () {
                                  debugPrint(
                                    'Open emergency/help',
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.warning_amber_rounded,
                              color: AppColors.error,
                            ),
                            label: Text(
                              'Emergency / Help',
                              style:
                                  AppTextStyles.bodyLarge.copyWith(
                                color: AppColors.error,
                              ),
                            ),
                          ),
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
    );
  }
}

// =====================================================================
// MAP SECTION
// =====================================================================

class _DeliveryMapSection extends StatelessWidget {
  const _DeliveryMapSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: double.infinity,
      child: Stack(
        children: [
          // =====================================================
          // TEMP MAP
          // =====================================================

          Positioned.fill(
            child: Container(
              color: AppColors.surfaceSecondary,
              child: const Center(
                child: Icon(
                  Icons.map_outlined,
                  size: 84,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),

          // =====================================================
          // DELIVERY STATUS
          // =====================================================

          Positioned(
  top: AppSpacing.md,
  left: 0,
  right: 0,
  child: Center(
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLG,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            color: AppColors.white,
            size: AppSpacing.iconXS,
          ),

          AppSpacing.horizontalSM,

          Text(
            'DELIVERY IN PROGRESS',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.9,
            ),
          ),
        ],
      ),
    ),
  ),
),

          // =====================================================
          // CURRENT DRIVER POSITION
          // =====================================================

          Positioned(
            top: 125,
            left: 165,
            child: Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.navigation_rounded,
                color: AppColors.white,
              ),
            ),
          ),

          // =====================================================
          // DESTINATION
          // =====================================================

          Positioned(
            top: 275,
            right: 95,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(
                  AppSpacing.radiusMD,
                ),
                border: Border.all(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.flag_outlined,
                color: AppColors.primary,
              ),
            ),
          ),

          // =====================================================
          // RECENTER
          // =====================================================

          Positioned(
            right: AppSpacing.screenHorizontal,
            bottom: AppSpacing.lg,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(
                  AppSpacing.radiusMD,
                ),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  context
                      .read<
                          ActiveDeliveryViewModel>()
                      .recenterMap(
                    onPressed: () {
                      debugPrint(
                        'Recenter delivery map',
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.my_location_rounded,
                  color: AppColors.textPrimary,
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
// STATS
// =====================================================================

class _DeliveryStats extends StatelessWidget {
  final String distance;
  final String eta;

  const _DeliveryStats({
    required this.distance,
    required this.eta,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'DISTANCE',
            value: distance,
          ),
        ),

        AppSpacing.horizontalMD,

        Expanded(
          child: _StatCard(
            label: 'ETA',
            value: eta,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),
      radius: AppSpacing.radiusLG,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
            ),
          ),

          AppSpacing.gapXXS,

          Text(
            value,
            style: AppTextStyles.headingMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// CUSTOMER
// =====================================================================

class _CustomerRow extends StatelessWidget {
  final String name;
  final String id;
  final String? image;
  final VoidCallback onCall;

  const _CustomerRow({
    required this.name,
    required this.id,
    required this.image,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CustomerAvatar(
          name: name,
          image: image,
        ),

        AppSpacing.horizontalMD,

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style:
                    AppTextStyles.headingMedium,
              ),

              AppSpacing.gapXS,

              Text(
                id,
                style:
                    AppTextStyles.bodyMediumSecondary,
              ),
            ],
          ),
        ),

        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color:
                AppColors.background,
            borderRadius:
                BorderRadius.circular(
              AppSpacing.radiusMD,
            ),
            border: Border.all(
              color:
                  AppColors.primary,
            ),
          ),
          child: IconButton(
            onPressed: onCall,
            icon: const Icon(
              Icons.phone_outlined,
              color:
                  AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// AVATAR
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
    const size = 58.0;

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
    final String initial =
        name.trim().isEmpty
            ? '?'
            : name
                .trim()
                .substring(0, 1)
                .toUpperCase();

    return Container(
      width: 58,
      height: 58,
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