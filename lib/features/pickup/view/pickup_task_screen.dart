import 'package:driver_app/features/pickup/model/trip_details_model.dart';
import 'package:driver_app/features/pickup/view/trip_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_primary_button.dart';

import '../model/pickup_task_model.dart';
import '../view_model/pickup_task_view_model.dart';

class PickupTaskScreen extends StatelessWidget {
  final PickupTaskModel task;

  const PickupTaskScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PickupTaskViewModel(
        task: task,
      ),
      child: const _PickupTaskView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _PickupTaskView extends StatelessWidget {
  const _PickupTaskView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // =========================================================
      // FIXED OTP BUTTON
      // =========================================================

      bottomNavigationBar:
    const _VerifyPickupOtpSection(),

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
              child: Consumer<PickupTaskViewModel>(
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

                        const _PickupMapPreview(),

                        // =========================================
                        // BODY
                        // =========================================

                        Padding(
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
                              // =================================
                              // ARRIVED
                              // =================================

                              Text(
                                'You\'ve arrived',
                                style:
                                    AppTextStyles.displaySmall,
                              ),

                              AppSpacing.gapXS,

                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size:
                                        AppSpacing.iconSM,
                                    color:
                                        AppColors.textSecondary,
                                  ),

                                  AppSpacing.horizontalXS,

                                  Expanded(
                                    child: Text(
                                      viewModel
                                          .task
                                          .pickupLocation,
                                      style:
                                          AppTextStyles
                                              .bodyLargeSecondary,
                                    ),
                                  ),
                                ],
                              ),

                              AppSpacing.gapMD,

                              const Divider(
                                height: 1,
                              ),

                              AppSpacing.gapMD,

                              // =================================
                              // CUSTOMER
                              // =================================

                              _CustomerSection(
                                customerName:
                                    viewModel
                                        .task
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

                              const Divider(
                                height: 1,
                              ),

                              AppSpacing.gapXL,

                              // =================================
                              // WAITING CARD
                              // =================================

                              const _PickupOtpSection(),

                              AppSpacing.gapXXL,
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
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
              'Pickup Task',
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
// MAP PREVIEW
// =====================================================================

class _PickupMapPreview extends StatelessWidget {
  const _PickupMapPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      width: double.infinity,
      child: Container(
        color: AppColors.surfaceSecondary,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.map_outlined,
              size: 78,
              color: AppColors.textSecondary,
            ),

            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on_outlined,
                size: 38,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
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
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.surfaceSecondary,
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusLG,
            ),
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            color: AppColors.textPrimary,
            size: AppSpacing.iconLG,
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

        SizedBox(
          width: 58,
          height: 58,
          child: OutlinedButton(
            onPressed: onCall,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: const Icon(
              Icons.phone_outlined,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}


// 
// =====================================================================
// VERIFY PICKUP OTP BUTTON
// =====================================================================

class _VerifyPickupOtpSection extends StatelessWidget {
  const _VerifyPickupOtpSection();

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
        child: Consumer<PickupTaskViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return AppPrimaryButton(
              title: 'VERIFY PICKUP OTP',
              isLoading:
                  viewModel.isVerifying,

              onPressed: () {
                viewModel.verifyPickupOtp(
                  context,
                  onSuccess: () {
  final task = context
      .read<PickupTaskViewModel>()
      .task;

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => TripDetailsScreen(
        trip: TripDetailsModel(
          bookingId:
              task.bookingId,

          pickup:
              task.pickupLocation,

          dropoff:
              'Hazratganj',

          estimatedDistance:
              '8.7 km',

          estimatedTime:
              '28 min',

          goodsType:
              'Furniture',

          quantity:
              '2 Items',

          customerName:
              task.customerName,

          customerImage:
              null,

          customerPhone:
              task.customerPhone,
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



// =====================================================================
// PICKUP OTP SECTION
// =====================================================================

class _PickupOtpSection extends StatelessWidget {
  const _PickupOtpSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<PickupTaskViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(
            AppSpacing.lg,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceSecondary,
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusLG,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // =================================================
              // STATUS
              // =================================================

              Row(
                children: [
                  const Icon(
                    Icons.lock_outline_rounded,
                    size: AppSpacing.iconSM,
                    color: AppColors.textSecondary,
                  ),

                  AppSpacing.horizontalSM,

                  Expanded(
                    child: Text(
                      'Pickup Verification',
                      style: AppTextStyles
                          .bodyLargeSecondary,
                    ),
                  ),
                ],
              ),

              AppSpacing.gapMD,

              Text(
                'Enter Pickup OTP',
                style:
                    AppTextStyles.headingMedium,
              ),

              AppSpacing.gapXS,

              Text(
                'Ask the customer for the 4-digit OTP.',
                style: AppTextStyles
                    .bodyMediumSecondary,
              ),

              AppSpacing.gapLG,

              // =================================================
              // OTP BOXES
              // =================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: List.generate(
                  PickupTaskViewModel.otpLength,
                  (index) {
                    return _OtpBox(
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// =====================================================================
// OTP BOX
// =====================================================================

class _OtpBox extends StatelessWidget {
  final int index;

  const _OtpBox({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.read<PickupTaskViewModel>();

    return SizedBox(
      width: 58,
      height: 62,
      child: KeyboardListener(
        focusNode: FocusNode(
          skipTraversal: true,
          canRequestFocus: false,
        ),
        onKeyEvent: (event) {
          viewModel.onOtpKeyEvent(
            index: index,
            event: event,
          );
        },
        child: TextField(
          controller:
              viewModel.otpControllers[index],
          focusNode:
              viewModel.otpFocusNodes[index],

          keyboardType: TextInputType.number,

          textAlign: TextAlign.center,

          textInputAction:
              index ==
                      PickupTaskViewModel
                              .otpLength -
                          1
                  ? TextInputAction.done
                  : TextInputAction.next,

          style:
              AppTextStyles.headingMedium,

          maxLength: 1,

          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],

          decoration: InputDecoration(
            counterText: '',

            contentPadding: EdgeInsets.zero,

            filled: true,

            fillColor: AppColors.background,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMD,
              ),
              borderSide: const BorderSide(
                color: AppColors.border,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMD,
              ),
              borderSide: const BorderSide(
                color: AppColors.border,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMD,
              ),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),

          onChanged: (value) {
            viewModel.onOtpChanged(
              context: context,
              index: index,
              value: value,
            );
          },
        ),
      ),
    );
  }
}