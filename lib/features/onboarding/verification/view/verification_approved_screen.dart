import 'package:driver_app/core/widgets/main_navigation/view/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_primary_button.dart';

import '../view_model/verification_approved_view_model.dart';

class VerificationApprovedScreen extends StatelessWidget {
  const VerificationApprovedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          VerificationApprovedViewModel(),
      child:
          const _VerificationApprovedView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _VerificationApprovedView
    extends StatelessWidget {
  const _VerificationApprovedView();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      // =========================================================
      // FIXED START DRIVING BUTTON
      // =========================================================

      bottomNavigationBar:
          const _StartDrivingSection(),

      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              const BouncingScrollPhysics(),

          padding:
              const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.xxxl,
            AppSpacing.xl,
            AppSpacing.xxxl,
          ),

          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.sizeOf(context)
                          .height *
                      0.72,
            ),

            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                // =================================================
                // SUCCESS ICON
                // =================================================

                const _SuccessIcon(),

                AppSpacing.gapXXXL,

                // =================================================
                // TITLE
                // =================================================

                Text(
                  'You’re Approved!',
                  textAlign:
                      TextAlign.center,
                  style:
                      AppTextStyles
                          .displaySmall,
                ),

                AppSpacing.gapMD,

                // =================================================
                // SUBTITLE
                // =================================================

                ConstrainedBox(
                  constraints:
                      const BoxConstraints(
                    maxWidth: 340,
                  ),
                  child: Text(
                    'Your Patgolito Driver account is ready.',
                    textAlign:
                        TextAlign.center,
                    style:
                        AppTextStyles
                            .bodyLargeSecondary,
                  ),
                ),

                AppSpacing.gapXXXL,

                // =================================================
                // DRIVER ILLUSTRATION
                // =================================================

                const _DriverIllustration(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SUCCESS ICON
// =====================================================================

class _SuccessIcon extends StatelessWidget {
  const _SuccessIcon();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: 92,
      height: 92,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.background,
        border: Border.all(
          color: AppColors.primary,
          width: 5,
        ),
      ),
      child: const Icon(
        Icons.check_rounded,
        size: 54,
        color: AppColors.primary,
      ),
    );
  }
}

// =====================================================================
// DRIVER ILLUSTRATION
// =====================================================================

class _DriverIllustration
    extends StatelessWidget {
  const _DriverIllustration();

  @override
  Widget build(
    BuildContext context,
  ) {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(
        maxWidth: 340,
        maxHeight: 280,
      ),
      child: Image.asset(
        AppAssets.driverApprovedIllustration,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}

// =====================================================================
// START DRIVING
// =====================================================================

class _StartDrivingSection
    extends StatelessWidget {
  const _StartDrivingSection();

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      top: false,
      child: Container(
        padding:
            const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.md,
          AppSpacing.xl,
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

        child: Consumer<
            VerificationApprovedViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return AppPrimaryButton(
              title: 'Start Driving',
              isLoading:
                  viewModel.isLoading,

              onPressed: () {
                viewModel.startDriving(
                  onSuccess: () {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (_) =>
          const MainNavigationScreen(),
    ),
    (route) => false,
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