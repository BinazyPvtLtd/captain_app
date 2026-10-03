
import 'package:driver_app/core/constants/app_assets.dart';
import 'package:driver_app/core/widgets/animatd_delivery%20screen.dart';
import 'package:driver_app/features/auth/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double height = constraints.maxHeight;
            final double width = constraints.maxWidth;

            // Real device responsive breakpoints
            final bool compactHeight = height < 700;
            final bool mediumHeight =
                height >= 700 && height < 820;

            final double horizontalPadding =
    width < 360 ? 16 : AppSpacing.screenHorizontal;


            final double logoHeight = compactHeight
    ? 82
    : mediumHeight
        ? 92
        : 104;

final double truckHeight = compactHeight
    ? 165
    : mediumHeight
        ? 190
        : 210;
            final double topGap = compactHeight
    ? 8
    : mediumHeight
        ? 12
        : 16;

final double sectionGap = compactHeight
    ? 10
    : mediumHeight
        ? 12
        : 16;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                children: [
                  SizedBox(height: topGap),

                  // ============================
                  // LOGO
                  // ============================

                  SizedBox(
                    height: logoHeight,
                    width: double.infinity,
                    child: Image.asset(
                      AppAssets.patgolitoLogo1,
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(
                    height: compactHeight ? 4 : 8,
                  ),

                  // ============================
                  // TITLE
                  // ============================

                  Text(
  'Move goods with ease',
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.visible,
  style: AppTextStyles.loginTitle,
),

                  SizedBox(
                    height: compactHeight ? 6 : 10,
                  ),

                  // ============================
                  // SUBTITLE
                  // ============================

                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 390,
                    ),
                    child: Text(
                      'Fast, reliable transportation at your fingertips.',
                      textAlign: TextAlign.center,
                      style:
                          AppTextStyles.loginSubtitle,
                    ),
                  ),

                  SizedBox(height: sectionGap),

                  // ============================
                  // TRUCK
                  // ============================

                  AnimatedDeliveryScene(
                    height: truckHeight,
                  ),

                  SizedBox(height: sectionGap),

                  // ============================
                  // PHONE
                  // ============================

                  const _PhoneInput(),

                  SizedBox(
                    height: compactHeight ? 12 : 18,
                  ),

                  // ============================
                  // CONTINUE
                  // ============================

                  const _ContinueButton(),

                  // Push terms towards bottom
                  const Spacer(),

                  // ============================
                  // TERMS
                  // ============================

                  _buildTerms(),

                  SizedBox(
                    height: compactHeight ? 8 : 12,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTerms() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 360,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyles.termsText,
          children: [
            const TextSpan(
              text:
                  'By continuing, you agree to Patgolito\'s ',
            ),
            TextSpan(
              text: 'Terms & ',
              style:
                  AppTextStyles.termsAction,
            ),
            TextSpan(
              text: 'Privacy Policy.',
              style:
                  AppTextStyles.termsAction,
            ),
          ],
        ),
      ),
    );
  }
}


class _PhoneInput extends StatelessWidget {
  const _PhoneInput();

  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel =
        context.read<LoginViewModel>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        height: AppSpacing.inputHeight,
        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius: BorderRadius.circular(32),

          border: Border.all(
            color: AppColors.primary.withValues(
              alpha: 0.35,
            ),
            width: 1.3,
          ),
        ),
        child: Row(
          children: [
            // =========================================
            // COUNTRY CODE
            // =========================================

            Padding(
              padding: const EdgeInsets.only(
  left: AppSpacing.lg,
  right: AppSpacing.sm,
),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '+91',
                    style: AppTextStyles.countryCode,
                  ),

                  const SizedBox(
                    width: AppSpacing.xs,
                  ),

                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 22,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),

            // =========================================
            // DIVIDER
            // =========================================

            Container(
              width: 1,
              height: 30,
              color: AppColors.border,
            ),

            // =========================================
            // PHONE FIELD
            // =========================================

            Expanded(
              child: TextField(
                controller:
                    viewModel.phoneController,

                keyboardType:
                    TextInputType.phone,

                maxLength: 10,

                onChanged:
                    viewModel.onPhoneChanged,

                style:
                    AppTextStyles.phoneInput,

                textAlignVertical:
                    TextAlignVertical.center,

                decoration:
                    const InputDecoration(
                  counterText: '',

                  hintText:
                      '10-digit number',

                  // Very important
                  border:
                      InputBorder.none,
                  enabledBorder:
                      InputBorder.none,
                  focusedBorder:
                      InputBorder.none,

                  filled: false,

                  isDense: true,

                  contentPadding: const EdgeInsets.symmetric(
  horizontal: AppSpacing.md,
  vertical: 0,
),
                ),
              ),
            ),

            const SizedBox(
              width: AppSpacing.sm,
            ),
          ],
        ),
      ),
    );
  }
}


// =======================================================================
// CONTINUE BUTTON
// =======================================================================

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonHeight,
          child: ElevatedButton(
            onPressed: viewModel.isLoading
                ? null
                : () => viewModel.continueLogin(
                      context,
                    ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              disabledBackgroundColor:
                  AppColors.primary.withValues(
                alpha: 0.6,
              ),
              elevation: 5,
              shadowColor:
                  AppColors.primary.withValues(
                alpha: 0.3,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.xxl,),
              ),
            ),
            child: viewModel.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue',
                        style:
                            AppTextStyles.buttonText,
                      ),

                      const SizedBox(
                        width: AppSpacing.sm,
                      ),

                      const Icon(
  Icons.arrow_forward_rounded,
  size: AppSpacing.iconMD,
),
                    ],
                  ),
          ),
        );
      },
    );
  }
}