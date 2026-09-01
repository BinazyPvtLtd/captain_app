import 'dart:io';

import 'package:driver_app/features/onboarding/kyc/view/kyc_intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../view_model/complete_profile_view_model.dart';

class CompleteProfileScreen
    extends StatelessWidget {
  const CompleteProfileScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return ChangeNotifierProvider(
      create: (_) =>
          CompleteProfileViewModel(),
      child:
          const _CompleteProfileView(),
    );
  }
}

// =====================================================================
// VIEW
// =====================================================================

class _CompleteProfileView
    extends StatelessWidget {
  const _CompleteProfileView();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      // =========================================================
      // FIXED CONTINUE BUTTON
      // =========================================================

      bottomNavigationBar:
          const _BottomContinueButton(),

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            const _ProfileHeader(),

            const Divider(
              height: 1,
            ),

            // =====================================================
            // FORM
            // =====================================================

            Expanded(
              child:
                  SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.xxl,
                  AppSpacing.screenHorizontal,
                  AppSpacing.xxxl,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // =============================================
                    // TITLE
                    // =============================================

                    Text(
                      'Complete Your Profile',
                      style:
                          AppTextStyles
                              .displaySmall,
                    ),

                    AppSpacing.gapSM,

                    // =============================================
                    // SUBTITLE
                    // =============================================

                    Text(
                      'Please provide your details to verify your account.',
                      style:
                          AppTextStyles
                              .bodyLargeSecondary,
                    ),

                    AppSpacing.gapXXXL,

                    // =============================================
                    // PHOTO
                    // =============================================

                    const Center(
                      child:
                          _ProfilePhotoPicker(),
                    ),

                    AppSpacing.gapXXXL,

                    // =============================================
                    // FULL NAME
                    // =============================================

                    const _FullNameField(),

                    AppSpacing.gapXL,

                    // =============================================
                    // DATE OF BIRTH
                    // =============================================

                    const _DateOfBirthField(),

                    AppSpacing.gapXL,

                    // =============================================
                    // GENDER
                    // =============================================

                    const _GenderField(),

                    AppSpacing.gapXL,

                    // =============================================
                    // EMAIL
                    // =============================================

                    const _EmailField(),

                    AppSpacing.gapXL,

                    // =============================================
                    // CITY
                    // =============================================

                    const _CityField(),

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
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          // =====================================================
          // BACK BUTTON
          // =====================================================

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

          // =====================================================
          // STEP TEXT
          // =====================================================

          Expanded(
            child: Text(
              'STEP 1 OF 3',
              textAlign: TextAlign.center,
              maxLines: 1,
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 1.5,
              ),
            ),
          ),

          // =====================================================
          // RIGHT SPACER
          // Same width as back button to keep title centered
          // =====================================================

          const SizedBox(
            width: 64,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// PROFILE PHOTO
// =====================================================================

class _ProfilePhotoPicker
    extends StatelessWidget {
  const _ProfilePhotoPicker();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer<
        CompleteProfileViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return GestureDetector(
          onTap:
              viewModel.pickProfileImage,
          behavior:
              HitTestBehavior.opaque,
          child: Container(
            width: 132,
            height: 132,
            decoration: BoxDecoration(
              color:
                  AppColors.surfaceSecondary,
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusLG,
              ),
              border: Border.all(
                color:
                    AppColors.borderDark,
                width: 1.5,
              ),
            ),
            child:
                viewModel.profileImage !=
                        null
                    ? _SelectedImage(
                        image: viewModel
                            .profileImage!,
                      )
                    : const _EmptyPhoto(),
          ),
        );
      },
    );
  }
}

// =====================================================================
// EMPTY PHOTO
// =====================================================================

class _EmptyPhoto
    extends StatelessWidget {
  const _EmptyPhoto();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.camera_alt_outlined,
          size: AppSpacing.iconXL,
          color:
              AppColors.textSecondary,
        ),

        AppSpacing.gapMD,

        Text(
          'Add Photo',
          style:
              AppTextStyles.titleMedium
                  .copyWith(
            color:
                AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SELECTED IMAGE
// =====================================================================

class _SelectedImage
    extends StatelessWidget {
  final File image;

  const _SelectedImage({
    required this.image,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(
        AppSpacing.radiusLG - 1,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            image,
            fit: BoxFit.cover,
          ),

          Positioned(
            right: AppSpacing.xs,
            bottom: AppSpacing.xs,
            child: Container(
              width: 34,
              height: 34,
              decoration:
                  const BoxDecoration(
                color:
                    AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit_rounded,
                size: AppSpacing.iconXS,
                color:
                    AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// FULL NAME
// =====================================================================

class _FullNameField
    extends StatelessWidget {
  const _FullNameField();

  @override
  Widget build(
    BuildContext context,
  ) {
    final viewModel = context
        .read<
            CompleteProfileViewModel>();

    return AppTextField(
      controller:
          viewModel.fullNameController,
      label: 'FULL NAME',
      hint:
          'Enter your full legal name',
      textInputAction:
          TextInputAction.next,
      keyboardType:
          TextInputType.name,
    );
  }
}

// =====================================================================
// DOB
// =====================================================================

class _DateOfBirthField
    extends StatelessWidget {
  const _DateOfBirthField();

  @override
  Widget build(
    BuildContext context,
  ) {
    final viewModel = context
        .read<
            CompleteProfileViewModel>();

    return AppTextField(
      controller:
          viewModel
              .dateOfBirthController,
      label: 'DATE OF BIRTH',
      hint: 'dd/mm/yyyy',
      readOnly: true,
      suffixIcon:
          Icons.calendar_today_outlined,
      onTap: () {
        viewModel.selectDateOfBirth(
          context,
        );
      },
      onSuffixTap: () {
        viewModel.selectDateOfBirth(
          context,
        );
      },
    );
  }
}

// =====================================================================
// GENDER
// =====================================================================

class _GenderField
    extends StatelessWidget {
  const _GenderField();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer<
        CompleteProfileViewModel>(
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
              'GENDER',
              style:
                  AppTextStyles.labelLarge,
            ),

            AppSpacing.gapXS,

            DropdownButtonFormField<String>(
              initialValue:
                  viewModel.selectedGender,

              hint: Text(
                'Select gender',
                style:
                    AppTextStyles.inputHint,
              ),

              icon: const Icon(
                Icons
                    .keyboard_arrow_down_rounded,
                color:
                    AppColors.iconPrimary,
              ),

              style:
                  AppTextStyles.input,

              decoration:
                  const InputDecoration(),

              items:
                  CompleteProfileViewModel
                      .genders
                      .map(
                (gender) {
                  return DropdownMenuItem<
                      String>(
                    value: gender,
                    child: Text(
                      gender,
                    ),
                  );
                },
              ).toList(),

              onChanged:
                  viewModel.selectGender,
            ),
          ],
        );
      },
    );
  }
}

// =====================================================================
// EMAIL
// =====================================================================

class _EmailField
    extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(
    BuildContext context,
  ) {
    final viewModel = context
        .read<
            CompleteProfileViewModel>();

    return AppTextField(
      controller:
          viewModel.emailController,
      label: 'EMAIL ADDRESS',
      hint: 'name@example.com',
      keyboardType:
          TextInputType.emailAddress,
      textInputAction:
          TextInputAction.next,
    );
  }
}

// =====================================================================
// CITY
// =====================================================================

class _CityField
    extends StatelessWidget {
  const _CityField();

  @override
  Widget build(
    BuildContext context,
  ) {
    final viewModel = context
        .read<
            CompleteProfileViewModel>();

    return AppTextField(
      controller:
          viewModel.cityController,
      label: 'CITY',
      hint: 'Enter your city',
      textInputAction:
          TextInputAction.done,
      keyboardType:
          TextInputType.streetAddress,
    );
  }
}

// =====================================================================
// BOTTOM CONTINUE
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
          border: Border(
            top: BorderSide(
              color:
                  AppColors.divider,
            ),
          ),
        ),
        child: Consumer<
            CompleteProfileViewModel>(
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
                viewModel.continueProfile(
                  context,
                  onSuccess: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => const KycIntroScreen(),
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