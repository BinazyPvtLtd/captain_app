import 'package:driver_app/core/theme/app_colors.dart';
import 'package:driver_app/core/theme/app_spacing.dart';
import 'package:driver_app/core/theme/app_text_styles.dart';
import 'package:driver_app/core/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../view_model/personal_information_view_model.dart';

class PersonalInformationScreen
    extends StatelessWidget {
  const PersonalInformationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          PersonalInformationViewModel(),
      child:
          const _PersonalInformationView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _PersonalInformationView
    extends StatelessWidget {
  const _PersonalInformationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      // =========================================================
      // FIXED BOTTOM BUTTON
      // =========================================================

      bottomNavigationBar:
          const _EditProfileSection(),

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            const _Header(),

            const Divider(
              height: 1,
              color:
                  AppColors.divider,
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: Consumer<
                  PersonalInformationViewModel>(
                builder: (
                  context,
                  viewModel,
                  child,
                ) {
                  final profile =
                      viewModel.profile;

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
                      // ===========================================
                      // PROFILE
                      // ===========================================

                      _ProfileSection(
                        name:
                            profile.name,
                        image:
                            profile.profileImage,
                      ),

                      AppSpacing.gapXL,

                      const Divider(
                        height: 1,
                        color:
                            AppColors.divider,
                      ),

                      // ===========================================
                      // DETAILS
                      // ===========================================

                      _InformationRow(
                        label:
                            'NAME',
                        value:
                            profile.name,
                      ),

                      _InformationRow(
                        label:
                            'MOBILE',
                        value:
                            profile.mobile,
                      ),

                      _InformationRow(
                        label:
                            'EMAIL',
                        value:
                            profile.email,
                      ),

                      _InformationRow(
                        label:
                            'CITY',
                        value:
                            profile.city,
                      ),

                      _InformationRow(
                        label:
                            'EMERGENCY CONTACT',
                        value:
                            profile
                                .emergencyContact,
                      ),

                      AppSpacing.gapXL,
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
      height: 55,
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
              'Personal Information',
              textAlign:
                  TextAlign.center,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              style:
                  AppTextStyles.headingLarge
                      .copyWith(
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
// PROFILE SECTION
// =====================================================================

class _ProfileSection
    extends StatelessWidget {
  final String name;
  final String? image;

  const _ProfileSection({
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileImage(
          name: name,
          image: image,
        ),

        AppSpacing.gapLG,

        Text(
          name,
          textAlign:
              TextAlign.center,
          style:
              AppTextStyles.headingLarge
                  .copyWith(
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// PROFILE IMAGE
// =====================================================================

class _ProfileImage extends StatelessWidget {
  final String name;
  final String? image;

  const _ProfileImage({
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 120;

    if (image != null &&
        image!.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        padding:
            const EdgeInsets.all(
          2,
        ),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusXL,
          ),
          border: Border.all(
            color:
                AppColors.border,
          ),
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusLG,
          ),
          child: Image.network(
            image!,
            fit:
                BoxFit.cover,
            errorBuilder: (
              context,
              error,
              stackTrace,
            ) {
              return _ImageFallback(
                name: name,
              );
            },
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      padding:
          const EdgeInsets.all(
        2,
      ),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusXL,
        ),
        border: Border.all(
          color:
              AppColors.border,
        ),
      ),
      child: _ImageFallback(
        name: name,
      ),
    );
  }
}

class _ImageFallback
    extends StatelessWidget {
  final String name;

  const _ImageFallback({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final initial =
        name.trim().isEmpty
            ? '?'
            : name
                .trim()
                .substring(0, 1)
                .toUpperCase();

    return Container(
      alignment:
          Alignment.center,
      decoration: BoxDecoration(
        color:
            AppColors.surfaceSecondary,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusLG,
        ),
      ),
      child: Text(
        initial,
        style:
            AppTextStyles.displayMedium
                .copyWith(
          fontWeight:
              FontWeight.w700,
        ),
      ),
    );
  }
}

// =====================================================================
// INFORMATION ROW
// =====================================================================

class _InformationRow
    extends StatelessWidget {
  final String label;
  final String value;

  const _InformationRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          double.infinity,
      padding:
          const EdgeInsets.symmetric(
        vertical:
            AppSpacing.md,
      ),
      decoration:
          const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color:
                AppColors.divider,
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
                AppTextStyles.labelMedium
                    .copyWith(
              color:
                  AppColors.textSecondary,
              fontWeight:
                  FontWeight.w500,
              letterSpacing:
                  0.8,
            ),
          ),

          AppSpacing.gapSM,

          // =====================================================
          // VALUE
          // =====================================================

          Text(
            value,
            style:
                AppTextStyles.titleLarge
                    .copyWith(
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
// EDIT PROFILE BUTTON
// =====================================================================

class _EditProfileSection
    extends StatelessWidget {
  const _EditProfileSection();

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
              'EDIT PROFILE',
          onPressed: () {
            context
                .read<
                    PersonalInformationViewModel>()
                .editProfile(
              onPressed: () {
                debugPrint(
                  'Open edit profile',
                );

                // TODO:
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (_) =>
                //         const EditProfileScreen(),
                //   ),
                // );
              },
            );
          },
        ),
      ),
    );
  }
}