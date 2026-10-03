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

class _CompleteProfileView extends StatelessWidget {
  const _CompleteProfileView();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final double screenHeight = mediaQuery.size.height;
    final bool isCompactHeight = screenHeight < 700;

    return Scaffold(
      backgroundColor: AppColors.background,

      
      resizeToAvoidBottomInset: true,

      bottomNavigationBar: const _BottomContinueButton(),

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _ProfileHeader(),

            const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.divider,
            ),

            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  isCompactHeight
                      ? AppSpacing.lg
                      : AppSpacing.md,
                  AppSpacing.screenHorizontal,
                  AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete Your Profile',
                      style: AppTextStyles.headingLarge,
                    ),

                    AppSpacing.gapSM,

                    Text(
                      'Please provide your details to verify your account.',
                      style:
                          AppTextStyles.bodyLargeSecondary,
                    ),

                    SizedBox(
                      height: isCompactHeight
                          ? AppSpacing.md
                          : AppSpacing.lg,
                    ),

                    Center(
                      child: _ProfilePhotoPicker(
                        compact: isCompactHeight,
                      ),
                    ),

                    SizedBox(
                      height: isCompactHeight
                          ? AppSpacing.md
                          : AppSpacing.lg,
                    ),

                    const _FullNameField(),

                    AppSpacing.gapMD,

                    const _DateOfBirthField(),

                    AppSpacing.gapMD,

                    const _GenderField(),

                    AppSpacing.gapMD,

                    const _EmailField(),

                    AppSpacing.gapMD,

                    const _CityField(),

                    AppSpacing.gapMD,
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
      height: 52,
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).maybePop();
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
              'STEP 1 OF 4',
              textAlign: TextAlign.center,
              maxLines: 1,
              style:
                  AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.4,
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
// PROFILE PHOTO
// =====================================================================

class _ProfilePhotoPicker extends StatelessWidget {
  final bool compact;

  const _ProfilePhotoPicker({
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final double size = compact ? 80 : 92;

    return Consumer<CompleteProfileViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return GestureDetector(
          onTap: viewModel.pickProfileImage,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusLG,
              ),
              border: Border.all(
                color: AppColors.borderDark,
                width: 1,
              ),
            ),
            child: viewModel.profileImage != null
                ? _SelectedImage(
                    image: viewModel.profileImage!,
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

        AppSpacing.gapXXS,

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
          textCapitalization: TextCapitalization.words,
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

class _BottomContinueButton extends StatelessWidget {
  const _BottomContinueButton();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.sm,
          AppSpacing.screenHorizontal,
          AppSpacing.sm,
        ),
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(
            top: BorderSide(
              color: AppColors.divider,
            ),
          ),
        ),
        child: Consumer<CompleteProfileViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return AppPrimaryButton(
              title: 'Continue',
              isLoading: viewModel.isLoading,
              onPressed: () {
                viewModel.continueProfile(
                  context,
                  onSuccess: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            const KycIntroScreen(),
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

