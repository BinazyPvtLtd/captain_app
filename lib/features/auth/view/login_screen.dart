
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
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _horizontalPadding(size.width),
                  ),
                  child: Column(
                    children: [
                      // =====================================================
                      // TOP SPACE
                      // =====================================================

                      SizedBox(
                        height: _topSpacing(size.height),
                      ),

                      // =====================================================
                      // APP ICON
                      // =====================================================

                      _buildAppIcon(),

                      // =====================================================
                      // TITLE
                      // =====================================================

                      AppSpacing.gapXXS,

                      Text(
                        'Move goods with ease',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.loginTitle,
                      ),

                      // =====================================================
                      // SUBTITLE
                      // =====================================================

                      SizedBox(
                        height: AppSpacing.sm,
                      ),

                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 390,
                        ),
                        child: Text(
                          'Fast, reliable transportation at your fingertips.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.loginSubtitle,
                        ),
                      ),

                      // =====================================================
                      // TRUCK
                      // =====================================================
                      const SizedBox(
  height: AppSpacing.md, // 12
),


// _buildTruckImage(
//   width: size.width,
//   height: size.height,
// ),

AnimatedDeliveryScene(
  height: size.height < 700
      ? 210
      : size.height < 850
          ? 250
          : 280,
),
                     

                      const SizedBox(
  height: AppSpacing.md, // 12
),

                      const _PhoneInput(),

                      // =====================================================
                      // CONTINUE BUTTON
                      // =====================================================

                      SizedBox(
                        height: AppSpacing.xl,
                      ),

                      const _ContinueButton(),

                      // =====================================================
                      // SIGN UP
                      // =====================================================

                      SizedBox(
                        height: AppSpacing.xxl,
                      ),

                     // _buildSignup(context),

                      // =====================================================
                      // TERMS
                      // =====================================================

                      SizedBox(
                        height: AppSpacing.xxl,
                      ),

                      _buildTerms(),

                      SizedBox(
                        height: AppSpacing.xl,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ===================================================================
  // RESPONSIVE HORIZONTAL PADDING
  // ===================================================================

  double _horizontalPadding(double width) {
    if (width < 360) {
      return AppSpacing.xl;
    }

    if (width < 600) {
      return AppSpacing.xxxl + AppSpacing.xs;
    }

    return AppSpacing.huge;
  }

  // ===================================================================
  // TOP SPACING
  // ===================================================================

  double _topSpacing(double height) {
    if (height < 700) {
      return AppSpacing.lg;
    }

    if (height < 850) {
      return AppSpacing.xl;
    }

    return AppSpacing.xxxl;
  }

  // ===================================================================
  // TRUCK TOP SPACING
  // ===================================================================

  double _truckTopSpacing(double height) {
    if (height < 700) {
      return AppSpacing.xxl;
    }

    if (height < 850) {
      return AppSpacing.xxxl + AppSpacing.xs;
    }

    return AppSpacing.huge + AppSpacing.sm;
  }

  // ===================================================================
  // FORM TOP SPACING
  // ===================================================================

  double _formTopSpacing(double height) {
    if (height < 700) {
      return AppSpacing.lg;
    }

    if (height < 850) {
      return AppSpacing.xxxl;
    }

    return AppSpacing.huge;
  }

  // ===================================================================
  // APP ICON
  // ===================================================================
// Widget _buildAppIcon() {
//   return Container(
//     width: 130,
//     height: 130,
//     decoration: BoxDecoration(
//       color: AppColors.white,
//       borderRadius: BorderRadius.circular(24),
//       boxShadow: const [
//         BoxShadow(
//           color: Color(0x18000000),
//           blurRadius: 16,
//           offset: Offset(0, 6),
//         ),
//       ],
//     ),
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(24),
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Image.asset(
//           AppAssets.patgolitoLogo1,
//           width: double.infinity,
//           height: double.infinity,
//           fit: BoxFit.contain,
//           alignment: Alignment.center,
//         ),
//       ),
//     ),
//   );
// }

Widget _buildAppIcon() {
  return Image.asset(
    AppAssets.patgolitoLogo1,
    width: 230,
    height: 170,
    fit: BoxFit.contain,
  );
}
  // ===================================================================
  // TRUCK IMAGE
  // ===================================================================

  // Widget _buildTruckImage({
  //   required double width,
  //   required double height,
  // }) {
  //   final double imageWidth = width < 380
  //       ? width * 0.78
  //       : width * 0.82;

  //   final double imageHeight = height < 700
  //       ? 210
  //       : height < 850
  //           ? 260
  //           : 300;

  //   return SizedBox(
  //     width: imageWidth,
  //     height: imageHeight,
  //     child: Image.asset(
  //       AppAssets.loginTruck,
  //       fit: BoxFit.contain,
  //     ),
  //   );
  // }

  // ===================================================================
  // SIGN UP
  // ===================================================================

  // Widget _buildSignup(BuildContext context) {
  //   return Wrap(
  //     alignment: WrapAlignment.center,
  //     children: [
  //       Text(
  //         'New to Patgolito? ',
  //         style: AppTextStyles.signupText,
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           // TODO: Navigate to signup screen.
  //         },
  //         child: Text(
  //           'Sign up',
  //           style: AppTextStyles.signupAction,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // ===================================================================
  // TERMS
  // ===================================================================

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
              text: 'By continuing, you agree to Patgolito\'s ',
            ),
            TextSpan(
              text: 'Terms &',
              style: AppTextStyles.termsAction,
            ),
            const TextSpan(
              text: '\n',
            ),
            TextSpan(
              text: 'Privacy Policy.',
              style: AppTextStyles.termsAction,
            ),
          ],
        ),
      ),
    );
  }
}

// =======================================================================
// PHONE INPUT
// =======================================================================

// class _PhoneInput extends StatelessWidget {
//   const _PhoneInput();

//   @override
//   Widget build(BuildContext context) {
//     final LoginViewModel viewModel =
//         context.read<LoginViewModel>();

//     return Container(
//       height: 64,
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(
//   AppSpacing.radiusCircular,
// ),
//         border: Border.all(
//           color: AppColors.primary.withValues(
//             alpha: 0.35,
//           ),
//           width: 1.3,
//         ),
//       ),
//       child: Row(
//         children: [
//           // ===========================================================
//           // COUNTRY CODE
//           // ===========================================================

//           Padding(
//             padding: const EdgeInsets.only(
//               left: AppSpacing.lg,
//               right: AppSpacing.md,
//             ),
//             child: Row(
//               children: [
//                 Text(
//                   '+91',
//                   style: AppTextStyles.countryCode,
//                 ),

//                 const SizedBox(
//                   width: AppSpacing.sm,
//                 ),

//                 Icon(
//                   Icons.keyboard_arrow_down_rounded,
//                   size: 24,
//                   color: AppColors.textPrimary,
//                 ),
//               ],
//             ),
//           ),

//           // ===========================================================
//           // DIVIDER
//           // ===========================================================

//           Container(
//             width: 1,
//             height: 34,
//             color: AppColors.primary.withValues(
//               alpha: 0.25,
//             ),
//           ),

//           // ===========================================================
//           // PHONE NUMBER
//           // ===========================================================

//           Expanded(
//             child: TextField(
//               controller: viewModel.phoneController,
//               keyboardType: TextInputType.phone,
//               maxLength: 10,
//               onChanged: viewModel.onPhoneChanged,
//               style: AppTextStyles.phoneInput,
//               decoration: const InputDecoration(
//                 counterText: '',
//                 hintText: '10-digit number',
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: AppSpacing.lg,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _PhoneInput extends StatelessWidget {
  const _PhoneInput();

  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel =
        context.read<LoginViewModel>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        height: 64,
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
                left: AppSpacing.xl,
                right: AppSpacing.md,
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

                  contentPadding:
                      EdgeInsets.symmetric(
                    horizontal:
                        AppSpacing.lg,
                    vertical: 20,
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
          height: 64,
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
                        size: 28,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}