import 'package:driver_app/core/theme/app_colors.dart';
import 'package:driver_app/core/theme/app_spacing.dart';
import 'package:driver_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import '../model/emergency_category_model.dart';
import '../view_model/emergency_help_view_model.dart';

class EmergencyHelpScreen extends StatelessWidget {
  const EmergencyHelpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmergencyHelpViewModel(),
      child: const _EmergencyHelpView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _EmergencyHelpView extends StatelessWidget {
  const _EmergencyHelpView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // =========================================================
      // FIXED CALL SUPPORT
      // =========================================================

      bottomNavigationBar: const _CallSupportSection(),

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
            // CONTENT
            // =====================================================

            Expanded(
              child: Consumer<EmergencyHelpViewModel>(
                builder: (
                  context,
                  viewModel,
                  child,
                ) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenHorizontal,
                      AppSpacing.lg,
                      AppSpacing.screenHorizontal,
                      AppSpacing.xl,
                    ),
                    children: [
                      // ===========================================
                      // SOS CARD
                      // ===========================================

                      const _EmergencyCard(),

                      AppSpacing.gapXL,

                      // ===========================================
                      // CATEGORY TITLE
                      // ===========================================

                      Text(
                        'SUPPORT CATEGORIES',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),

                      AppSpacing.gapMD,

                      // ===========================================
                      // CATEGORY CARD
                      // ===========================================

                      _EmergencyCategoryContainer(
                        categories: viewModel.categories,
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
      height: 68,
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
              'Emergency & Help',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.headingLarge.copyWith(
                fontWeight: FontWeight.w700,
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
// EMERGENCY CARD
// =====================================================================

class _EmergencyCard extends StatelessWidget {
  const _EmergencyCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<EmergencyHelpViewModel>()
            .triggerEmergencyCall(
          onPressed: () {
            debugPrint('SOS emergency call');

            // TODO:
            // url_launcher:
            // launchUrl(Uri.parse('tel:112'));
          },
        );
      },
      borderRadius: BorderRadius.circular(
        AppSpacing.radiusLG,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xl,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusLG,
          ),
        ),
        child: Column(
          children: [
            // =====================================================
            // PHONE ICON
            // =====================================================

            const Icon(
              Icons.phone_in_talk_rounded,
              size: 54,
              color: AppColors.white,
            ),

            AppSpacing.gapLG,

            // =====================================================
            // TITLE
            // =====================================================

            Text(
              'SOS / EMERGENCY CALL',
              textAlign: TextAlign.center,
              style: AppTextStyles.headingLarge.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),

            AppSpacing.gapSM,

            // =====================================================
            // DESCRIPTION
            // =====================================================

            Text(
              'Immediate assistance for on-road issues',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white.withValues(
                  alpha: 0.78,
                ),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// CATEGORY CONTAINER
// =====================================================================

class _EmergencyCategoryContainer extends StatelessWidget {
  final List<EmergencyCategoryModel> categories;

  const _EmergencyCategoryContainer({
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLG,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: List.generate(
          categories.length,
          (index) {
            final category = categories[index];

            return Column(
              children: [
                _EmergencyCategoryRow(
                  category: category,
                ),

                if (index != categories.length - 1)
                  const Divider(
                    height: 1,
                    indent: 0,
                    endIndent: 0,
                    color: AppColors.divider,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// =====================================================================
// CATEGORY ROW
// =====================================================================

class _EmergencyCategoryRow extends StatelessWidget {
  final EmergencyCategoryModel category;

  const _EmergencyCategoryRow({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<EmergencyHelpViewModel>().openCategory(
          category: category,
          onPressed: () {
            debugPrint(
              'Open ${category.title}',
            );

            // TODO:
            // Open specific emergency flow.
          },
        );
      },
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            // =====================================================
            // ICON
            // =====================================================

            SizedBox(
              width: 44,
              child: Icon(
                category.icon,
                size: AppSpacing.iconMD,
                color: AppColors.textPrimary,
              ),
            ),

            AppSpacing.horizontalMD,

            // =====================================================
            // TITLE
            // =====================================================

            Expanded(
              child: Text(
                category.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            AppSpacing.horizontalSM,

            // =====================================================
            // CHEVRON
            // =====================================================

            const Icon(
              Icons.chevron_right_rounded,
              size: AppSpacing.iconMD,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// CALL SUPPORT
// =====================================================================

class _CallSupportSection extends StatelessWidget {
  const _CallSupportSection();

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
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {
              context
                  .read<EmergencyHelpViewModel>()
                  .callSupport(
                onPressed: () {
                  debugPrint(
                    'Call support',
                  );

                  // TODO:
                  // launchUrl(
                  //   Uri.parse('tel:+91XXXXXXXXXX'),
                  // );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppSpacing.radiusSM,
                ),
              ),
            ),
            icon: const Icon(
              Icons.phone_outlined,
              size: AppSpacing.iconSM,
              color: AppColors.white,
            ),
            label: Text(
              'Call Support',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}