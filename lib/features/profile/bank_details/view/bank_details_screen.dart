import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_primary_button.dart';

import '../view_model/bank_details_view_model.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BankDetailsViewModel(),
      child: const _BankDetailsView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _BankDetailsView extends StatelessWidget {
  const _BankDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // =========================================================
      // FIXED BOTTOM BUTTON
      // =========================================================

      bottomNavigationBar:
          const _UpdateBankSection(),

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            const _Header(),

            const Divider(
              height: 1,
              color: AppColors.divider,
            ),

            // =====================================================
            // DETAILS
            // =====================================================

            Expanded(
              child: Consumer<BankDetailsViewModel>(
                builder: (
                  context,
                  viewModel,
                  child,
                ) {
                  final bank =
                      viewModel.bankDetails;

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
                      _BankInfoRow(
                        label:
                            'Account Holder Name',
                        value:
                            bank.accountHolderName,
                      ),

                      _BankInfoRow(
                        label:
                            'Bank Name',
                        value:
                            bank.bankName,
                      ),

                      _AccountNumberRow(
                        accountNumber:
                            bank.accountNumber,
                        isVerified:
                            bank.isVerified,
                      ),

                      _BankInfoRow(
                        label:
                            'IFSC Code',
                        value:
                            bank.ifscCode,
                      ),
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
                size: AppSpacing.iconMD,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          Expanded(
            child: Text(
              'Bank Details',
              textAlign: TextAlign.center,
              style:
                  AppTextStyles.headingLarge.copyWith(
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
// NORMAL BANK INFO ROW
// =====================================================================

class _BankInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _BankInfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // =====================================================
          // LABEL
          // =====================================================

          Text(
            label,
            style:
                AppTextStyles.labelLarge.copyWith(
              color:
                  AppColors.textSecondary,
              fontWeight:
                  FontWeight.w500,
              letterSpacing:
                  0.5,
            ),
          ),

          AppSpacing.gapSM,

          // =====================================================
          // VALUE
          // =====================================================

          Text(
            value,
            maxLines: 2,
            overflow:
                TextOverflow.ellipsis,
            style:
                AppTextStyles.titleLarge.copyWith(
              color:
                  AppColors.textPrimary,
              fontWeight:
                  FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// ACCOUNT NUMBER + VERIFIED
// =====================================================================

class _AccountNumberRow
    extends StatelessWidget {
  final String accountNumber;
  final bool isVerified;

  const _AccountNumberRow({
    required this.accountNumber,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Account Number',
            style:
                AppTextStyles.labelLarge.copyWith(
              color:
                  AppColors.textSecondary,
              fontWeight:
                  FontWeight.w500,
              letterSpacing:
                  0.5,
            ),
          ),

          AppSpacing.gapSM,

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  accountNumber,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      AppTextStyles.titleLarge.copyWith(
                    color:
                        AppColors.textPrimary,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
              ),

              if (isVerified) ...[
                AppSpacing.horizontalMD,

                const _VerifiedBadge(),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// VERIFIED BADGE
// =====================================================================

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color:
            AppColors.surfaceSecondary,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusSM,
        ),
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            size: AppSpacing.iconXS,
            color: AppColors.textPrimary,
          ),

          AppSpacing.horizontalXS,

          Text(
            'Verified',
            style:
                AppTextStyles.labelMedium.copyWith(
              color:
                  AppColors.textPrimary,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// UPDATE BANK BUTTON
// =====================================================================

class _UpdateBankSection
    extends StatelessWidget {
  const _UpdateBankSection();

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
              'UPDATE BANK DETAILS',
          onPressed: () {
            context
                .read<BankDetailsViewModel>()
                .updateBankDetails(
              onPressed: () {
                debugPrint(
                  'Update bank details',
                );

                // TODO:
                // Open bank details edit screen.
              },
            );
          },
        ),
      ),
    );
  }
}