import 'package:driver_app/features/onboarding/vehicle/view/vehicle_documents_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../model/vehicle_type_model.dart';
import '../view_model/vehicle_details_view_model.dart';

class VehicleDetailsScreen extends StatelessWidget {
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
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      bottomNavigationBar:
          const _BottomContinueButton(),

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
              child:
                  SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.xl,
                  AppSpacing.screenHorizontal,
                  AppSpacing.xxxl,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // =============================================
                    // STEP
                    // =============================================

                    Text(
                      'STEP 3 OF 3',
                      style:
                          AppTextStyles.labelLarge
                              .copyWith(
                        color:
                            AppColors
                                .textSecondary,
                        letterSpacing: 1.5,
                      ),
                    ),

                    AppSpacing.gapMD,

                    // =============================================
                    // PROGRESS
                    // =============================================

                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(
                        AppSpacing
                            .radiusCircular,
                      ),
                      child:
                          const LinearProgressIndicator(
                        value: 1,
                        minHeight: 6,
                        color:
                            AppColors.primary,
                        backgroundColor:
                            AppColors.border,
                      ),
                    ),

                    AppSpacing.gapXXL,

                    // =============================================
                    // TITLE
                    // =============================================

                    Text(
                      'Vehicle Details',
                      style:
                          AppTextStyles
                              .displaySmall,
                    ),

                    AppSpacing.gapXXL,

                    // =============================================
                    // VEHICLE TYPE
                    // =============================================

                    Text(
                      'SELECT VEHICLE TYPE',
                      style:
                          AppTextStyles.labelLarge
                              .copyWith(
                        color:
                            AppColors
                                .textSecondary,
                        letterSpacing: 1.1,
                      ),
                    ),

                    AppSpacing.gapMD,

                    const _VehicleTypeSelector(),

                    AppSpacing.gapXXL,

                    // =============================================
                    // VEHICLE NUMBER
                    // =============================================

                    const _VehicleNumberField(),

                    AppSpacing.gapLG,

                    // =============================================
                    // BRAND
                    // =============================================

                    const _VehicleBrandField(),

                    AppSpacing.gapLG,

                    // =============================================
                    // MODEL
                    // =============================================

                    const _VehicleModelField(),

                    AppSpacing.gapLG,

                    // =============================================
                    // COLOR
                    // =============================================

                    const _VehicleColorField(),

                    AppSpacing.gapLG,

                    // =============================================
                    // YEAR
                    // =============================================

                    const _ManufacturingYearField(),

                    AppSpacing.gapXXL,
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .maybePop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                size:
                    AppSpacing.iconLG,
                color:
                    AppColors.textPrimary,
              ),
            ),
          ),

          Expanded(
            child: Text(
              'Patgolito Driver',
              textAlign:
                  TextAlign.center,
              style:
                  AppTextStyles
                      .headingLarge,
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
// VEHICLE TYPE SELECTOR
// =====================================================================

class _VehicleTypeSelector
    extends StatelessWidget {
  const _VehicleTypeSelector();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer<
        VehicleDetailsViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection:
                Axis.horizontal,
            physics:
                const BouncingScrollPhysics(),
            itemCount:
                VehicleDetailsViewModel
                    .vehicleTypes.length,
            separatorBuilder:
                (
                  context,
                  index,
                ) {
              return AppSpacing.horizontalMD;
            },
            itemBuilder:
                (
                  context,
                  index,
                ) {
              final VehicleTypeModel
                  vehicle =
                  VehicleDetailsViewModel
                      .vehicleTypes[index];

              final bool selected =
                  viewModel
                          .selectedVehicleType
                          ?.id ==
                      vehicle.id;

              return _VehicleTypeCard(
                vehicle: vehicle,
                selected: selected,
                onTap: () {
                  viewModel
                      .selectVehicleType(
                    vehicle,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

// =====================================================================
// VEHICLE TYPE CARD
// =====================================================================

class _VehicleTypeCard
    extends StatelessWidget {
  final VehicleTypeModel vehicle;
  final bool selected;
  final VoidCallback onTap;

  const _VehicleTypeCard({
    required this.vehicle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 180,
        ),
        width: 132,
        padding:
            const EdgeInsets.all(
          AppSpacing.md,
        ),
        decoration:
            BoxDecoration(
          color:
              selected
                  ? AppColors
                      .surfaceSecondary
                  : AppColors.surface,
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusLG,
          ),
          border: Border.all(
            color:
                selected
                    ? AppColors.primary
                    : AppColors.border,
            width:
                selected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Icon(
                  vehicle.icon,
                  size: 44,
                  color:
                      AppColors
                          .textPrimary,
                ),

                AppSpacing.gapMD,

                Text(
                  vehicle.title,
                  textAlign:
                      TextAlign.center,
                  style:
                      AppTextStyles
                          .titleMedium,
                ),
              ],
            ),

            if (selected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration:
                      BoxDecoration(
                    color:
                        AppColors.primary,
                    borderRadius:
                        BorderRadius.circular(
                      AppSpacing.radiusSM,
                    ),
                  ),
                  child:
                      const Icon(
                    Icons
                        .check_rounded,
                    size:
                        AppSpacing.iconSM,
                    color:
                        AppColors.white,
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
// VEHICLE NUMBER
// =====================================================================

class _VehicleNumberField
    extends StatelessWidget {
  const _VehicleNumberField();

  @override
  Widget build(
    BuildContext context,
  ) {
    final viewModel = context
        .read<
            VehicleDetailsViewModel>();

    return AppTextField(
      controller:
          viewModel
              .vehicleNumberController,
      label:
          'VEHICLE NUMBER',
      hint:
          'UP32 AB 1234',
      textInputAction:
          TextInputAction.next,
      textCapitalization:
          TextCapitalization.characters,
      inputFormatters: [
        LengthLimitingTextInputFormatter(
          15,
        ),
      ],
    );
  }
}

// =====================================================================
// VEHICLE BRAND
// =====================================================================

class _VehicleBrandField
    extends StatelessWidget {
  const _VehicleBrandField();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer<
        VehicleDetailsViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'VEHICLE BRAND',
              style:
                  AppTextStyles
                      .labelLarge,
            ),

            AppSpacing.gapXS,

            DropdownButtonFormField<String>(
              initialValue:
                  viewModel.selectedBrand,
              hint: Text(
                'Select vehicle brand',
                style:
                    AppTextStyles
                        .inputHint,
              ),
              icon:
                  const Icon(
                Icons
                    .keyboard_arrow_down_rounded,
                color:
                    AppColors
                        .iconSecondary,
              ),
              style:
                  AppTextStyles.input,
              decoration:
                  const InputDecoration(),
              items:
                  VehicleDetailsViewModel
                      .brands
                      .map(
                (brand) {
                  return DropdownMenuItem<
                      String>(
                    value: brand,
                    child:
                        Text(
                      brand,
                    ),
                  );
                },
              ).toList(),
              onChanged:
                  viewModel.selectBrand,
            ),
          ],
        );
      },
    );
  }
}

// =====================================================================
// VEHICLE MODEL
// =====================================================================

class _VehicleModelField
    extends StatelessWidget {
  const _VehicleModelField();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer<
        VehicleDetailsViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'VEHICLE MODEL',
              style:
                  AppTextStyles
                      .labelLarge,
            ),

            AppSpacing.gapXS,

            DropdownButtonFormField<String>(
              initialValue:
                  viewModel.selectedModel,
              hint: Text(
                'Select vehicle model',
                style:
                    AppTextStyles
                        .inputHint,
              ),
              icon:
                  const Icon(
                Icons
                    .keyboard_arrow_down_rounded,
                color:
                    AppColors
                        .iconSecondary,
              ),
              style:
                  AppTextStyles.input,
              decoration:
                  const InputDecoration(),
              items:
                  VehicleDetailsViewModel
                      .models
                      .map(
                (model) {
                  return DropdownMenuItem<
                      String>(
                    value: model,
                    child:
                        Text(
                      model,
                    ),
                  );
                },
              ).toList(),
              onChanged:
                  viewModel.selectModel,
            ),
          ],
        );
      },
    );
  }
}

// =====================================================================
// COLOR
// =====================================================================

class _VehicleColorField
    extends StatelessWidget {
  const _VehicleColorField();

  @override
  Widget build(
    BuildContext context,
  ) {
    final viewModel = context
        .read<
            VehicleDetailsViewModel>();

    return AppTextField(
      controller:
          viewModel
              .vehicleColorController,
      label:
          'VEHICLE COLOR',
      hint:
          'Enter vehicle color',
      textInputAction:
          TextInputAction.next,
    );
  }
}

// =====================================================================
// MANUFACTURING YEAR
// =====================================================================

class _ManufacturingYearField
    extends StatelessWidget {
  const _ManufacturingYearField();

  @override
  Widget build(
    BuildContext context,
  ) {
    final viewModel = context
        .read<
            VehicleDetailsViewModel>();

    return AppTextField(
      controller:
          viewModel
              .manufacturingYearController,
      label:
          'MANUFACTURING YEAR',
      hint:
          '2024',
      keyboardType:
          TextInputType.number,
      textInputAction:
          TextInputAction.done,
      inputFormatters: [
        FilteringTextInputFormatter
            .digitsOnly,
        LengthLimitingTextInputFormatter(
          4,
        ),
      ],
    );
  }
}

// =====================================================================
// BOTTOM CONTINUE BUTTON
// =====================================================================

class _BottomContinueButton
    extends StatelessWidget {
  const _BottomContinueButton();

  @override
  Widget build(
    BuildContext context,
  ) {
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
          border:
              Border(
            top:
                BorderSide(
              color:
                  AppColors.divider,
            ),
          ),
        ),
        child: Consumer<
            VehicleDetailsViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return AppPrimaryButton(
              title: 'Continue',
              isLoading:
                  viewModel.isLoading,
              onPressed: () {
                viewModel
                    .continueVehicle(
                  context,
                  onSuccess: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) =>
          const VehicleDocumentsScreen(),
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