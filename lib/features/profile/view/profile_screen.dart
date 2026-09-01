import 'package:driver_app/features/profile/bank_details/view/bank_details_screen.dart';
import 'package:driver_app/features/profile/documents/view/documents_screen.dart';
import 'package:driver_app/features/profile/emergency_&_help/view/emergency_help_screen.dart';
import 'package:driver_app/features/profile/help_&_support/view/help_support_screen.dart';
import 'package:driver_app/features/profile/personal_information/view/personal_information_screen.dart';
import 'package:driver_app/features/profile/vehicle_details/view/vehicle_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../view_model/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: const _ProfileView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceSecondary,
        surfaceTintColor: AppColors.surfaceSecondary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,

        title: Text(
          'Profile',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: AppColors.divider),
        ),
      ),
      body: SafeArea(
        child: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: AppSpacing.xl),
              children: [
                // =================================================
                // PROFILE HEADER
                // =================================================
                _ProfileHeader(viewModel: viewModel),

                const Divider(height: 1, color: AppColors.divider),

                // =================================================
                // ACCOUNT
                // =================================================
                const _SectionTitle(title: 'ACCOUNT'),

                _ProfileMenuItem(
                  icon: Icons.person_outline_rounded,
                  title: 'Personal Information',
                  onTap: () {
                    viewModel.openSection(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const PersonalInformationScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),

                _ProfileMenuItem(
                  icon: Icons.verified_user_outlined,
                  title: 'KYC & Documents',
                  onTap: () {
                    viewModel.openSection(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const DocumentsScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),

                _ProfileMenuItem(
  icon: Icons.local_shipping_outlined,
  title: 'Vehicle Details',
  onTap: () {
    viewModel.openSection(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                const VehicleDetailsScreen(),
          ),
        );
      },
    );
  },
),

                _ProfileMenuItem(
  icon: Icons.account_balance_outlined,
  title: 'Bank Details',
  onTap: () {
    viewModel.openSection(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                const BankDetailsScreen(),
          ),
        );
      },
    );
  },
),

                // =================================================
                // SUPPORT & LEGAL
                // =================================================
                const _SectionTitle(
                  title: 'SUPPORT & LEGAL',
                  topSpacing: AppSpacing.xl,
                ),

                _ProfileMenuItem(
  icon: Icons.help_outline_rounded,
  title: 'Help & Support',
  onTap: () {
    viewModel.openSection(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                const HelpSupportScreen(),
          ),
        );
      },
    );
  },
),

               _ProfileMenuItem(
  icon: Icons.emergency_outlined,
  title: 'Emergency Help',
  isDanger: true,
  onTap: () {
    viewModel.openSection(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                const EmergencyHelpScreen(),
          ),
        );
      },
    );
  },
),

                _ProfileMenuItem(
                  icon: Icons.description_outlined,
                  title: 'Terms & Conditions',
                  onTap: () {
                    viewModel.openSection(
                      onPressed: () {
                        debugPrint('Open terms & conditions');
                      },
                    );
                  },
                ),

                _ProfileMenuItem(
                  icon: Icons.lock_outline_rounded,
                  title: 'Privacy Policy',
                  onTap: () {
                    viewModel.openSection(
                      onPressed: () {
                        debugPrint('Open privacy policy');
                      },
                    );
                  },
                ),

                AppSpacing.gapXXL,

                // =================================================
                // LOGOUT
                // =================================================
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal,
                  ),
                  child: _LogoutButton(
                    isLoading: viewModel.isLoggingOut,
                    onPressed: () {
                      viewModel.logout(
                        onSuccess: () {
                          debugPrint('Driver logged out');

                          // TODO:
                          // Navigator.of(context)
                          //     .pushAndRemoveUntil(
                          //   MaterialPageRoute(
                          //     builder: (_) =>
                          //         const LoginScreen(),
                          //   ),
                          //   (route) => false,
                          // );
                        },
                      );
                    },
                  ),
                ),

                AppSpacing.gapLG,
              ],
            );
          },
        ),
      ),
    );
  }
}

// =====================================================================
// PROFILE HEADER
// =====================================================================

class _ProfileHeader extends StatelessWidget {
  final ProfileViewModel viewModel;

  const _ProfileHeader({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final profile = viewModel.profile;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.xl,
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
      ),
      child: Column(
        children: [
          // =====================================================
          // PROFILE IMAGE
          // =====================================================
          Stack(
            clipBehavior: Clip.none,
            children: [
              _ProfileAvatar(name: profile.name, image: profile.profileImage),

              Positioned(
                right: -2,
                bottom: -2,
                child: Material(
                  color: AppColors.primary,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      viewModel.editProfile(
                        onPressed: () {
                          debugPrint('Edit profile image');
                        },
                      );
                    },
                    child: const SizedBox(
                      width: 38,
                      height: 38,
                      child: Icon(
                        Icons.edit_rounded,
                        size: AppSpacing.iconXS,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          AppSpacing.gapLG,

          // =====================================================
          // DRIVER NAME
          // =====================================================
          Text(
            profile.name,
            textAlign: TextAlign.center,
            style: AppTextStyles.headingLarge.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          AppSpacing.gapSM,

          // =====================================================
          // DRIVER ID + RATING
          // =====================================================
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              Text(
                'ID: ${profile.driverId}',
                style: AppTextStyles.bodyMediumSecondary.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),

              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.borderDark,
                  shape: BoxShape.circle,
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    profile.rating.toStringAsFixed(1),
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  AppSpacing.horizontalXS,

                  const Icon(
                    Icons.star_rounded,
                    size: AppSpacing.iconXS,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// PROFILE AVATAR
// =====================================================================

class _ProfileAvatar extends StatelessWidget {
  final String name;
  final String? image;

  const _ProfileAvatar({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    const double size = 90;

    if (image != null && image!.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
          border: Border.all(color: AppColors.primary, width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
          child: Image.network(
            image!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _AvatarFallback(name: name);
            },
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: _AvatarFallback(name: name),
    );
  }
}

// =====================================================================
// AVATAR FALLBACK
// =====================================================================

class _AvatarFallback extends StatelessWidget {
  final String name;

  const _AvatarFallback({required this.name});

  @override
  Widget build(BuildContext context) {
    final String initial = name.trim().isEmpty
        ? '?'
        : name.trim().substring(0, 1).toUpperCase();

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
      ),
      child: Text(
        initial,
        style: AppTextStyles.headingLarge.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

// =====================================================================
// SECTION TITLE
// =====================================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final double topSpacing;

  const _SectionTitle({required this.title, this.topSpacing = AppSpacing.lg});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        topSpacing,
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
      ),
      child: Text(
        title,
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// =====================================================================
// PROFILE MENU ITEM
// =====================================================================

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDanger;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color foreground = isDanger ? AppColors.error : AppColors.textPrimary;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: AppSpacing.sm,
        ),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.divider)),
        ),
        child: Row(
          children: [
            // =================================================
            // ICON
            // =================================================
            SizedBox(
              width: 36,
              child: Icon(icon, size: AppSpacing.iconMD, color: foreground),
            ),

            AppSpacing.horizontalMD,

            // =================================================
            // TITLE
            // =================================================
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.titleMedium.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            AppSpacing.horizontalSM,

            // =================================================
            // CHEVRON
            // =================================================
            Icon(
              Icons.chevron_right_rounded,
              size: AppSpacing.iconSM,
              color: isDanger ? AppColors.error : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// LOGOUT BUTTON
// =====================================================================

class _LogoutButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _LogoutButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          backgroundColor: AppColors.background,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
          ),
        ),
        icon: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              )
            : const Icon(Icons.logout_rounded, size: AppSpacing.iconSM),
        label: Text(
          isLoading ? 'LOGGING OUT...' : 'LOGOUT',
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}
