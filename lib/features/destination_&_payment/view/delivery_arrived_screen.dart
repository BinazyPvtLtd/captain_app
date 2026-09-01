import 'package:driver_app/features/destination_&_payment/model/delivery_completed_model.dart';
import 'package:driver_app/features/destination_&_payment/model/payment_model.dart';
import 'package:driver_app/features/destination_&_payment/view/delivery_completed_screen.dart';
import 'package:driver_app/features/destination_&_payment/view/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_primary_button.dart';

import '../model/delivery_arrived_model.dart';
import '../view_model/delivery_arrived_view_model.dart';

class DeliveryArrivedScreen extends StatelessWidget {
  final DeliveryArrivedModel delivery;

  const DeliveryArrivedScreen({
    super.key,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeliveryArrivedViewModel(
        delivery: delivery,
      ),
      child: const _DeliveryArrivedView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _DeliveryArrivedView extends StatelessWidget {
  const _DeliveryArrivedView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      bottomNavigationBar:
          const _DeliveryOtpButtonSection(),

      body: SafeArea(
        child: Column(
          children: [
            const _Header(),

            const Divider(
              height: 1,
            ),

            Expanded(
              child: Consumer<DeliveryArrivedViewModel>(
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

                        const _DestinationMapPreview(),

                        // =========================================
                        // CONTENT
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
                              // STATUS
                              // =================================

                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration:
                                        const BoxDecoration(
                                      color:
                                          AppColors.primary,
                                      shape:
                                          BoxShape.circle,
                                    ),
                                  ),

                                  AppSpacing.horizontalSM,

                                  Text(
                                    'STATUS',
                                    style: AppTextStyles
                                        .labelMedium
                                        .copyWith(
                                      color:
                                          AppColors
                                              .textSecondary,
                                      fontWeight:
                                          FontWeight.w600,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),

                              AppSpacing.gapMD,

                              Text(
                                'You’ve reached the destination',
                                style:
                                    AppTextStyles.headingLarge,
                              ),

                              AppSpacing.gapSM,

                              Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons
                                        .location_on_outlined,
                                    size:
                                        AppSpacing.iconSM,
                                    color:
                                        AppColors
                                            .textSecondary,
                                  ),

                                  AppSpacing.horizontalSM,

                                  Expanded(
                                    child: Text(
                                      viewModel
                                          .delivery
                                          .destination,
                                      style: AppTextStyles
                                          .bodyLargeSecondary,
                                    ),
                                  ),
                                ],
                              ),

                              AppSpacing.gapXL,

                              const Divider(
                                height: 1,
                              ),

                              AppSpacing.gapXL,

                              // =================================
                              // CUSTOMER
                              // =================================

                              Text(
                                'CUSTOMER DETAILS',
                                style: AppTextStyles
                                    .labelMedium
                                    .copyWith(
                                  color:
                                      AppColors.textSecondary,
                                  fontWeight:
                                      FontWeight.w600,
                                  letterSpacing: 1.0,
                                ),
                              ),

                              AppSpacing.gapLG,

                              _CustomerSection(
                                name:
                                    viewModel
                                        .delivery
                                        .customerName,
                                role:
                                    viewModel
                                        .delivery
                                        .customerRole,
                                image:
                                    viewModel
                                        .delivery
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

                              AppSpacing.gapXL,

                              const Divider(
                                height: 1,
                              ),

                              AppSpacing.gapXL,

                              // =================================
                              // SECURITY INFO
                              // =================================

                              const _SecurityRequirementCard(),

                              AppSpacing.gapXL,

                              const _DeliveryOtpSection(),

AppSpacing.gapXL,
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
              'PATGOLITO',
              textAlign: TextAlign.left,
              style: AppTextStyles.headingLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          SizedBox(
            width: 64,
            child: IconButton(
              onPressed: () {
                context
                    .read<DeliveryArrivedViewModel>()
                    .openHelp(
                  onPressed: () {
                    debugPrint(
                      'Open help',
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.help_outline_rounded,
                size: AppSpacing.iconMD,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// MAP
// =====================================================================

class _DestinationMapPreview extends StatelessWidget {
  const _DestinationMapPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              color: AppColors.surfaceSecondary,
              child: const Center(
                child: Icon(
                  Icons.map_outlined,
                  size: 72,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),

          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusLG,
              ),
            ),
            child: const Icon(
              Icons.location_on_rounded,
              size: 30,
              color: AppColors.white,
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

class _CustomerSection extends StatelessWidget {
  final String name;
  final String role;
  final String? image;
  final VoidCallback onCall;

  const _CustomerSection({
    required this.name,
    required this.role,
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

              AppSpacing.gapXXS,

              Text(
                role,
                style:
                    AppTextStyles.bodyMediumSecondary,
              ),
            ],
          ),
        ),

        AppSpacing.horizontalMD,

        SizedBox(
          width: 56,
          height: 56,
          child: OutlinedButton(
            onPressed: onCall,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: const Icon(
              Icons.phone_outlined,
              size: AppSpacing.iconMD,
              color: AppColors.textPrimary,
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
    const double size = 58;

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
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLG,
        ),
        border: Border.all(
          color: AppColors.border,
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
// SECURITY CARD
// =====================================================================

class _SecurityRequirementCard extends StatelessWidget {
  const _SecurityRequirementCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      // Reduced padding
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),

      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusMD,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: AppSpacing.iconSM,
            color: AppColors.textPrimary,
          ),

          AppSpacing.horizontalSM,

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Security Requirement',
                  style:
                      AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                AppSpacing.gapXS,

                Text(
                  'Ask the customer for the 4-digit Delivery OTP.',
                  style:
                      AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _DeliveryOtpSection
    extends StatelessWidget {
  const _DeliveryOtpSection();

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.watch<
            DeliveryArrivedViewModel>();

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'DELIVERY OTP',
          style:
              AppTextStyles.labelMedium.copyWith(
            color:
                AppColors.textSecondary,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),

        AppSpacing.gapSM,

        Text(
          'Enter the 4-digit code from the customer',
          style:
              AppTextStyles.bodyMediumSecondary,
        ),

        AppSpacing.gapLG,

        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: List.generate(
            DeliveryArrivedViewModel
                .otpLength,
            (index) {
              return _OtpBox(
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _OtpBox extends StatelessWidget {
  final int index;

  const _OtpBox({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.read<
            DeliveryArrivedViewModel>();

    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        viewModel.onOtpKeyEvent(
          index: index,
          event: event,
        );
      },
      child: SizedBox(
        width: 60,
        height: 60,
        child: TextField(
          controller:
              viewModel
                  .otpControllers[index],
          focusNode:
              viewModel
                  .otpFocusNodes[index],

          keyboardType:
              TextInputType.number,

          textInputAction:
              index ==
                      DeliveryArrivedViewModel
                              .otpLength -
                          1
                  ? TextInputAction.done
                  : TextInputAction.next,

          textAlign:
              TextAlign.center,

          maxLength: 1,

          style:
              AppTextStyles.headingMedium
                  .copyWith(
            fontWeight:
                FontWeight.w600,
          ),

          inputFormatters: [
            FilteringTextInputFormatter
                .digitsOnly,
            LengthLimitingTextInputFormatter(
              1,
            ),
          ],

          decoration: InputDecoration(
            counterText: '',

            contentPadding:
                EdgeInsets.zero,

            filled: true,

            fillColor:
                AppColors.background,

            enabledBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusMD,
              ),
              borderSide:
                  const BorderSide(
                color:
                    AppColors.border,
              ),
            ),

            focusedBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusMD,
              ),
              borderSide:
                  const BorderSide(
                color:
                    AppColors.primary,
                width: 1.5,
              ),
            ),
          ),

          onChanged: (value) {
            viewModel.onOtpChanged(
              index: index,
              value: value,
            );
          },
        ),
      ),
    );
  }
}

// =====================================================================
// DELIVERY OTP BUTTON
// =====================================================================

class _DeliveryOtpButtonSection
    extends StatelessWidget {
  const _DeliveryOtpButtonSection();

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.watch<
            DeliveryArrivedViewModel>();

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
          title: viewModel.isVerifying
              ? 'VERIFYING...'
              : 'VERIFY OTP',
          icon:
              Icons.verified_outlined,
          onPressed:
              viewModel.isVerifying
                  ? null
                  : () {
                      viewModel
                          .verifyDeliveryOtp(
                        context,
                        onSuccess: () {
  final delivery = context
      .read<DeliveryArrivedViewModel>()
      .delivery;

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => PaymentScreen(
        payment: PaymentModel(
          bookingId:
              delivery.bookingId,

          totalFare:
              240,

          baseFare:
              180,

          serviceCharge:
              60,

          pickup:
              'Gomti Nagar',

          dropoff:
              'Hazratganj',

          distance:
              '9.2 km',

          time:
              '31 min',

          qrImage:
              null,
        ),
      ),
    ),
  );
},
                      );
                    },
        ),
      ),
    );
  }
}