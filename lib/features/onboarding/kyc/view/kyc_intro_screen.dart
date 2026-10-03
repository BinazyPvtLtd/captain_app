import 'package:driver_app/core/theme/app_colors.dart';
import 'package:driver_app/core/theme/app_spacing.dart';
import 'package:driver_app/core/theme/app_text_styles.dart';
import 'package:driver_app/core/widgets/app_primary_button.dart';
import 'package:driver_app/features/onboarding/kyc/view/kyc_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../view_model/kyc_intro_view_model.dart';

class KycIntroScreen extends StatelessWidget {
  const KycIntroScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KycIntroViewModel(),
      child: const _KycIntroView(),
    );
  }
}

// =====================================================================
// VIEW
// =====================================================================

class _KycIntroView extends StatelessWidget {
  const _KycIntroView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // =========================================================
      // FIXED BOTTOM BUTTON
      // =========================================================

      bottomNavigationBar: const _BottomButton(),

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            const _KycHeader(),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: Column(
                  children: [
                    AppSpacing.gapXS,

                    // =============================================
                    // SHIELD ICON
                    // =============================================

                    const _VerificationIcon(),

                    AppSpacing.gapXL,

                    // =============================================
                    // TITLE
                    // =============================================

                    Text(
                      'Verify Your Identity',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.displaySmall,
                    ),

                    AppSpacing.gapSM,

                    // =============================================
                    // SUBTITLE
                    // =============================================

                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 330,
                      ),
                      child: Text(
                        'Complete your KYC to start accepting deliveries.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLargeSecondary,
                      ),
                    ),

                    AppSpacing.gapXL,

                    // =============================================
                    // DOCUMENT LIST
                    // =============================================

                    const _KycRequirementList(),

                    AppSpacing.gapXL,

                    // =============================================
                    // BOTTOM INFO
                    // =============================================

                    Text(
                      'Vehicle documents will be added in the next step.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMediumSecondary,
                    ),

                    AppSpacing.gapXXXL,
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

class _KycHeader extends StatelessWidget {
  const _KycHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: SizedBox(
        height: 45,
        child: Row(
          children: [
            // =================================================
            // BACK BUTTON
            // =================================================

            SizedBox(
              width: 48,
              height: 48,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: AppSpacing.iconLG,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // =================================================
            // STEP TEXT
            // =================================================

            Expanded(
              child: Text(
                'STEP 2 OF 4',
                textAlign: TextAlign.center,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 1.6,
                ),
              ),
            ),

            // =================================================
            // EMPTY SPACE TO KEEP TITLE CENTERED
            // =================================================

            const SizedBox(
              width: 48,
            ),
          ],
        ),
      ),
    );
  }
}
// =====================================================================
// VERIFICATION ICON
// =====================================================================

class _VerificationIcon extends StatelessWidget {
  const _VerificationIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusXL,
        ),
      ),
      child: const Icon(
        Icons.verified_user_outlined,
        size: 58,
        color: AppColors.textPrimary,
      ),
    );
  }
}

// =====================================================================
// KYC REQUIREMENTS
// =====================================================================

class _KycRequirementList extends StatelessWidget {
  const _KycRequirementList();

  static const List<String> _items = [
    'Driving Licence',
    'Aadhaar / Identity Proof',
    'PAN Card',
    'Profile Photo',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        _items.length,
        (index) {
          return _KycRequirementTile(
            title: _items[index],
            showTopBorder: index == 0,
          );
        },
      ),
    );
  }
}

// =====================================================================
// SINGLE REQUIREMENT TILE
// =====================================================================

class _KycRequirementTile extends StatelessWidget {
  final String title;
  final bool showTopBorder;

  const _KycRequirementTile({
    required this.title,
    this.showTopBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        border: Border(
          top: showTopBorder
              ? const BorderSide(
                  color: AppColors.border,
                )
              : BorderSide.none,
          bottom: const BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleMedium,
            ),
          ),

          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.check_rounded,
              size: AppSpacing.iconSM,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// BOTTOM BUTTON
// =====================================================================

class _BottomButton extends StatelessWidget {
  const _BottomButton();

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
        child: Consumer<KycIntroViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return AppPrimaryButton(
              title: 'Start Verification',
              isLoading: viewModel.isLoading,
              onPressed: () {
                viewModel.startVerification(
                  onSuccess: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) =>
          const KycVerificationScreen(),
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