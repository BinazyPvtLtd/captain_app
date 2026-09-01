import 'package:driver_app/features/destination_&_payment/model/delivery_completed_model.dart';
import 'package:driver_app/features/destination_&_payment/view/delivery_completed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';

import '../model/payment_model.dart';
import '../view_model/payment_view_model.dart';

class PaymentScreen extends StatelessWidget {
  final PaymentModel payment;

  const PaymentScreen({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentViewModel(
        payment: payment,
      ),
      child: const _PaymentView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _PaymentView extends StatelessWidget {
  const _PaymentView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

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
              child: Consumer<PaymentViewModel>(
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
                      AppSpacing.lg,
                    ),

                    child: Column(
                      children: [
                        // =========================================
                        // FARE
                        // =========================================

                        _FareCard(
                          totalFare:
                              viewModel
                                  .payment
                                  .totalFare,
                          baseFare:
                              viewModel
                                  .payment
                                  .baseFare,
                          serviceCharge:
                              viewModel
                                  .payment
                                  .serviceCharge,
                        ),

                        AppSpacing.gapMD,

                        // =========================================
                        // ONLINE SELECTED
                        // =========================================

                        const _OnlinePaymentHeader(),

                        AppSpacing.gapLG,

                        // =========================================
                        // QR
                        // =========================================

                        _QrSection(
                          qrImage:
                              viewModel
                                  .payment
                                  .qrImage,
                        ),

                        AppSpacing.gapXL,

                        // =========================================
                        // CASH
                        // =========================================

                        _CashSection(
                          amount:
                              viewModel
                                  .payment
                                  .totalFare,
                        ),

                        AppSpacing.gapLG,

                        // =========================================
                        // SLIDE COMPLETE
                        // =========================================

                        _CompleteTripSlider(
                          viewModel:
                              viewModel,
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
      height: 64,
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
              'Select Payment\nMethod',
              textAlign:
                  TextAlign.left,
              maxLines: 2,
              style:
                  AppTextStyles.headingLarge
                      .copyWith(
                height: 1.1,
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
// FARE CARD
// =====================================================================

class _FareCard extends StatelessWidget {
  final double totalFare;
  final double baseFare;
  final double serviceCharge;

  const _FareCard({
    required this.totalFare,
    required this.baseFare,
    required this.serviceCharge,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),
      radius:
          AppSpacing.radiusLG,

      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Total Fare',
                  style:
                      AppTextStyles.bodyLargeSecondary,
                ),
              ),

              Text(
                '₹${totalFare.toStringAsFixed(0)}',
                style:
                    AppTextStyles.headingLarge
                        .copyWith(
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ],
          ),

          AppSpacing.gapXS,

          const Divider(
            height: 1,
          ),

          AppSpacing.gapSM,

          _FareRow(
            title:
                'Base Fare',
            amount:
                baseFare,
          ),

          AppSpacing.gapSM,

          _FareRow(
            title:
                'Service Charge',
            amount:
                serviceCharge,
          ),
        ],
      ),
    );
  }
}

class _FareRow extends StatelessWidget {
  final String title;
  final double amount;

  const _FareRow({
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style:
                AppTextStyles.bodyMediumSecondary,
          ),
        ),

        Text(
          '₹${amount.toStringAsFixed(0)}',
          style:
              AppTextStyles.bodyMedium.copyWith(
            fontWeight:
                FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// ONLINE PAYMENT HEADER
// =====================================================================

class _OnlinePaymentHeader
    extends StatelessWidget {
  const _OnlinePaymentHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSpacing.xxs,
      ),
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
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          vertical:
              AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color:
              AppColors.primary,
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusSM,
          ),
        ),
        child: Text(
          'Online (UPI/QR)',
          textAlign:
              TextAlign.center,
          style:
              AppTextStyles.titleMedium.copyWith(
            color:
                AppColors.white,
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// QR SECTION
// =====================================================================

class _QrSection extends StatelessWidget {
  final String? qrImage;

  const _QrSection({
    this.qrImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 240,
          height: 240,
          padding: const EdgeInsets.all(
            AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color:
                AppColors.surfaceSecondary,
            borderRadius:
                BorderRadius.circular(
              AppSpacing.radiusSM,
            ),
          ),
          child: qrImage != null &&
                  qrImage!.isNotEmpty
              ? Image.asset(
                  qrImage!,
                  fit:
                      BoxFit.contain,
                )
              : const Icon(
                  Icons.qr_code_2_rounded,
                  size: 180,
                  color:
                      AppColors.primary,
                ),
        ),

        AppSpacing.gapMD,

        Text(
          'Scan QR to Pay via UPI',
          textAlign:
              TextAlign.center,
          style:
              AppTextStyles.headingMedium
                  .copyWith(
            fontWeight:
                FontWeight.w600,
          ),
        ),

        AppSpacing.gapXS,

        Text(
          'Accepting all UPI apps (GPay,\nPhonePe, Paytm)',
          textAlign:
              TextAlign.center,
          style:
              AppTextStyles.bodyMediumSecondary
                  .copyWith(
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// CASH SECTION
// =====================================================================

class _CashSection extends StatelessWidget {
  final double amount;

  const _CashSection({
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),

        AppSpacing.gapLG,

        Text(
          'OR PAY WITH CASH',
          style:
              AppTextStyles.labelMedium.copyWith(
            color:
                AppColors.textSecondary,
            fontWeight:
                FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),

        AppSpacing.gapSM,

        Text(
          'Collect ₹${amount.toStringAsFixed(0)}',
          style:
              AppTextStyles.titleLarge.copyWith(
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SLIDE TO COMPLETE
// =====================================================================

class _CompleteTripSlider
    extends StatelessWidget {
  final PaymentViewModel viewModel;

  const _CompleteTripSlider({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        const double handleSize = 58;

        final double maxDrag =
            constraints.maxWidth -
                handleSize -
                8;

        final double offset =
            viewModel.slideOffset.clamp(
          0.0,
          maxDrag,
        );

        return Container(
          height: 66,
          padding: const EdgeInsets.all(
            4,
          ),
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
          child: Stack(
            alignment:
                Alignment.centerLeft,
            children: [
              // =================================================
              // LABEL
              // =================================================

              Center(
                child: Text(
                  viewModel.isProcessing
                      ? 'Completing Trip...'
                      : 'Slide to Complete Trip',
                  style:
                      AppTextStyles.titleMedium
                          .copyWith(
                    color:
                        AppColors.textSecondary,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),

              // =================================================
              // HANDLE
              // =================================================

              Transform.translate(
                offset: Offset(
                  offset,
                  0,
                ),
                child: GestureDetector(
                  behavior:
                      HitTestBehavior.opaque,

                  onHorizontalDragUpdate: (
                    details,
                  ) {
                    viewModel.updateSlide(
                      delta:
                          details.delta.dx,
                      maxDrag:
                          maxDrag,
                    );
                  },

                  onHorizontalDragEnd: (_) {
                    viewModel.completeSlide(
                      context,
                      maxDrag:
                          maxDrag,

                      onSuccess: () {
  final payment =
      viewModel.payment;

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) =>
          DeliveryCompletedScreen(
        delivery:
            DeliveryCompletedModel(
          bookingId:
              '#${payment.bookingId}',

          pickup:
              payment.pickup,

          dropoff:
              payment.dropoff,

          distance:
              payment.distance,

          time:
              payment.time,

          earning:
              '₹${payment.totalFare.toStringAsFixed(0)}',

          paymentStatus:
              'Payment Completed',
        ),
      ),
    ),
  );
},
                    );
                  },

                  child: Container(
                    width:
                        handleSize,
                    height:
                        handleSize,
                    decoration: BoxDecoration(
                      color:
                          AppColors.primary,
                      borderRadius:
                          BorderRadius.circular(
                        AppSpacing.radiusMD,
                      ),
                    ),
                    child:
                        viewModel.isProcessing
                            ? const Padding(
                                padding:
                                    EdgeInsets.all(
                                  18,
                                ),
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth:
                                      2,
                                  color:
                                      AppColors.white,
                                ),
                              )
                            : const Icon(
                                Icons
                                    .keyboard_double_arrow_right_rounded,
                                color:
                                    AppColors.white,
                                size:
                                    AppSpacing.iconMD,
                              ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}