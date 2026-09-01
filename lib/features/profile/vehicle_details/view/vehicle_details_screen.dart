import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_primary_button.dart';

import '../model/vehicle_details_model.dart';
import '../view_model/vehicle_details_view_model.dart';

class VehicleDetailsScreen
    extends StatelessWidget {
  const VehicleDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          VehicleDetailsViewModel(),
      child:
          const _VehicleDetailsView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _VehicleDetailsView
    extends StatelessWidget {
  const _VehicleDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      // =========================================================
      // UPDATE BUTTON
      // =========================================================

      bottomNavigationBar:
          const _UpdateVehicleSection(),

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            const _Header(),

            const Divider(
              height: 1,
              color:
                  AppColors.divider,
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: Consumer<
                  VehicleDetailsViewModel>(
                builder: (
                  context,
                  viewModel,
                  child,
                ) {
                  final vehicle =
                      viewModel.vehicle;

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
                      // VEHICLE CARD
                      // ===========================================

                      _VehicleCard(
                        vehicle: vehicle,
                      ),

                      AppSpacing.gapXXL,

                      // ===========================================
                      // TITLE
                      // ===========================================

                      Text(
                        'Vehicle Documents',
                        style:
                            AppTextStyles.headingLarge
                                .copyWith(
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),

                      AppSpacing.gapLG,

                      // ===========================================
                      // DOCUMENTS
                      // ===========================================

                      ...vehicle.documents.map(
                        (document) =>
                            _VehicleDocumentRow(
                          document:
                              document,
                          onTap: () {
                            viewModel.openDocument(
                              document:
                                  document,
                              onPressed: () {
                                debugPrint(
                                  'Open ${document.title}',
                                );
                              },
                            );
                          },
                        ),
                      ),

                      AppSpacing.gapXL,
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

class _Header extends StatelessWidget {
  const _Header();

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
                Navigator.of(context)
                    .maybePop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                size:
                    AppSpacing.iconMD,
                color:
                    AppColors.textPrimary,
              ),
            ),
          ),

          Expanded(
            child: Text(
              'My Vehicle',
              textAlign:
                  TextAlign.center,
              style:
                  AppTextStyles.headingLarge
                      .copyWith(
                fontWeight:
                    FontWeight.w700,
              ),
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
// VEHICLE CARD
// =====================================================================

class _VehicleCard extends StatelessWidget {
  final VehicleDetailsModel vehicle;

  const _VehicleCard({
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(
        AppSpacing.lg,
      ),

      decoration: BoxDecoration(
        color:
            AppColors.background,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusLG,
        ),

        border: Border.all(
          color:
              AppColors.border,
        ),
      ),

      child: Column(
        children: [
          // =====================================================
          // TOP
          // =====================================================

          Row(
            children: [
              Container(
                width: 88,
                height: 88,

                decoration: BoxDecoration(
                  color:
                      AppColors.surfaceSecondary,

                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusLG,
                  ),
                ),

                child: const Icon(
                  Icons.local_shipping_rounded,
                  size: 46,
                  color:
                      AppColors.textPrimary,
                ),
              ),

              AppSpacing.horizontalLG,

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.vehicleType,

                      style:
                          AppTextStyles.headingLarge
                              .copyWith(
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    AppSpacing.gapXS,

                    Text(
                      vehicle.brand,

                      style:
                          AppTextStyles.bodyLargeSecondary
                              .copyWith(
                        fontWeight:
                            FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          AppSpacing.gapLG,

          const Divider(
            height: 1,
            color:
                AppColors.divider,
          ),

          AppSpacing.gapMD,

          // =====================================================
          // DETAILS
          // =====================================================

          Row(
            children: [
              Expanded(
                child: _VehicleInfo(
                  label:
                      'PLATE NUMBER',
                  value:
                      vehicle.plateNumber,
                ),
              ),

              AppSpacing.horizontalLG,

              Expanded(
                child: _VehicleInfo(
                  label:
                      'COLOR',
                  value:
                      vehicle.color,
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
// VEHICLE INFO
// =====================================================================

class _VehicleInfo extends StatelessWidget {
  final String label;
  final String value;

  const _VehicleInfo({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              AppTextStyles.labelMedium
                  .copyWith(
            color:
                AppColors.textSecondary,
            fontWeight:
                FontWeight.w500,
            letterSpacing:
                0.8,
          ),
        ),

        AppSpacing.gapXS,

        Text(
          value,
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis,
          style:
              AppTextStyles.titleLarge
                  .copyWith(
            fontWeight:
                FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// DOCUMENT ROW
// =====================================================================

class _VehicleDocumentRow
    extends StatelessWidget {
  final VehicleDocumentModel document;
  final VoidCallback onTap;

  const _VehicleDocumentRow({
    required this.document,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Container(
        height: 64,

        padding:
            const EdgeInsets.symmetric(
          vertical:
              AppSpacing.sm,
        ),

        decoration:
            const BoxDecoration(
          border: Border(
            top: BorderSide(
              color:
                  AppColors.divider,
            ),
          ),
        ),

        child: Row(
          children: [
            // =================================================
            // ICON
            // =================================================

            SizedBox(
              width: 42,
              child: Icon(
                _documentIcon(
                  document.title,
                ),
                size:
                    AppSpacing.iconMD,
                color:
                    AppColors.textSecondary,
              ),
            ),

            AppSpacing.horizontalMD,

            // =================================================
            // NAME
            // =================================================

            Expanded(
              child: Text(
                document.title,

                style:
                    AppTextStyles.titleLarge
                        .copyWith(
                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ),

            AppSpacing.horizontalSM,

            // =================================================
            // STATUS
            // =================================================

            _ApprovedBadge(
              approved:
                  document.isApproved,
            ),
          ],
        ),
      ),
    );
  }

  IconData _documentIcon(
    String title,
  ) {
    switch (title.toLowerCase()) {
      case 'rc':
        return Icons.description_outlined;

      case 'insurance':
        return Icons.shield_outlined;

      case 'pollution':
        return Icons.co2_rounded;

      case 'permit':
        return Icons.badge_outlined;

      default:
        return Icons.description_outlined;
    }
  }
}

// =====================================================================
// APPROVED BADGE
// =====================================================================

class _ApprovedBadge
    extends StatelessWidget {
  final bool approved;

  const _ApprovedBadge({
    required this.approved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal:
            AppSpacing.sm,
        vertical:
            AppSpacing.xxs,
      ),

      decoration: BoxDecoration(
        color:
            AppColors.surfaceSecondary,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusCircular,
        ),
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            approved
                ? Icons.check_circle_rounded
                : Icons.pending_outlined,

            size:
                AppSpacing.iconXS,

            color:
                AppColors.textPrimary,
          ),

          AppSpacing.horizontalXS,

          Text(
            approved
                ? 'Approved'
                : 'Pending',

            style:
                AppTextStyles.labelMedium
                    .copyWith(
              fontWeight:
                  FontWeight.w600,
              color:
                  AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// UPDATE VEHICLE
// =====================================================================

class _UpdateVehicleSection
    extends StatelessWidget {
  const _UpdateVehicleSection();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,

      child: Container(
        padding:
            const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.md,
          AppSpacing.screenHorizontal,
          AppSpacing.md,
        ),

        decoration:
            const BoxDecoration(
          color:
              AppColors.background,

          border: Border(
            top: BorderSide(
              color:
                  AppColors.divider,
            ),
          ),
        ),

        child: AppPrimaryButton(
          title:
              'UPDATE VEHICLE',

          onPressed: () {
            context
                .read<
                    VehicleDetailsViewModel>()
                .updateVehicle(
              onPressed: () {
                debugPrint(
                  'Update vehicle',
                );

                // TODO:
                // Open vehicle edit/update screen.
              },
            );
          },
        ),
      ),
    );
  }
}