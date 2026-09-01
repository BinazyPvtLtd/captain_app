import 'package:driver_app/core/widgets/app_primary_button.dart';
import 'package:driver_app/features/onboarding/verification/view/verification_approved_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_secondary_button.dart';
import '../../../../core/widgets/app_status_badge.dart';

import '../model/verification_item_model.dart';
import '../view_model/verification_status_view_model.dart';

class VerificationStatusScreen extends StatelessWidget {
  const VerificationStatusScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          VerificationStatusViewModel(),
      child: const _VerificationStatusView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _VerificationStatusView extends StatelessWidget {
  const _VerificationStatusView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      bottomNavigationBar: const _ContinueSection(),

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            const _Header(),

            const Divider(
              height: 1,
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
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

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: [
                    // =============================================
                    // VERIFICATION ICON
                    // =============================================

                    const _VerificationIcon(),

                    AppSpacing.gapXXL,

                    // =============================================
                    // TITLE
                    // =============================================

                    Text(
                      'Verification in Progress',
                      textAlign: TextAlign.center,
                      style:
                          AppTextStyles.displaySmall,
                    ),

                    AppSpacing.gapSM,

                    // =============================================
                    // SUBTITLE
                    // =============================================

                    Text(
                      'We’re reviewing your documents.',
                      textAlign: TextAlign.center,
                      style:
                          AppTextStyles.bodyLargeSecondary,
                    ),

                    AppSpacing.gapXXXL,

                    // =============================================
                    // STATUS CARD
                    // =============================================

                    const _VerificationCard(),

                    AppSpacing.gapXXL,

                    // =============================================
                    // UNDER REVIEW
                    // =============================================

                    const AppStatusBadge(
                      text: 'Under Review',
                      type: AppStatusType.neutral,
                    ),

                    AppSpacing.gapMD,

                    // =============================================
                    // INFO
                    // =============================================

                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 360,
                      ),
                      child: Text(
                        'We’ll notify you when your account is approved.',
                        textAlign: TextAlign.center,
                        style:
                            AppTextStyles.bodyMediumSecondary,
                      ),
                    ),

                    AppSpacing.gapXXL,

                    // =============================================
                    // VIEW DOCUMENTS
                    // =============================================

                    SizedBox(
                      width: 220,
                      child: AppSecondaryButton(
                        title: 'View Documents',
                        onPressed: () {
                          context
                              .read<
                                  VerificationStatusViewModel>()
                              .viewDocuments(
                            onPressed: () {
                              debugPrint(
                                'Open submitted documents',
                              );

                              // TODO:
                              // Open submitted documents screen.
                            },
                          );
                        },
                      ),
                    ),

                    AppSpacing.gapXL,
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
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

          Expanded(
            child: Text(
              'Verification Status',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyles.headingLarge,
            ),
          ),

          const SizedBox(
            width: 64,
          ),
        ],
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
      width: 118,
      height: 118,
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusXL,
        ),
      ),
      child: const Icon(
        Icons.fact_check_outlined,
        size: 64,
        color: AppColors.textPrimary,
      ),
    );
  }
}

// =====================================================================
// VERIFICATION CARD
// =====================================================================

class _VerificationCard extends StatelessWidget {
  const _VerificationCard();

  @override
  Widget build(BuildContext context) {
    return Consumer<
        VerificationStatusViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          radius: AppSpacing.radiusXL,
          child: Column(
            children: [
              for (
                int index = 0;
                index < viewModel.items.length;
                index++
              ) ...[
                _VerificationRow(
                  item:
                      viewModel.items[index],
                ),

                if (index !=
                    viewModel.items.length - 1)
                  const Divider(
                    height: 1,
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}



// =====================================================================
// VERIFICATION ROW
// =====================================================================

class _VerificationRow extends StatelessWidget {
  final VerificationItemModel item;

  const _VerificationRow({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          // =================================================
          // TITLE
          // =================================================

          Expanded(
            child: Text(
              item.title,
              style:
                  AppTextStyles.titleMedium,
            ),
          ),

          // =================================================
          // STATUS
          // =================================================

          Text(
            item.status,
            style:
                AppTextStyles.labelMedium.copyWith(
              color:
                  AppColors.textSecondary,
              fontWeight:
                  FontWeight.w600,
              letterSpacing: 0.7,
            ),
          ),

          AppSpacing.horizontalSM,

          // =================================================
          // CHECK
          // =================================================

          const Icon(
            Icons.check_rounded,
            size: AppSpacing.iconSM,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
  // =====================================================================
// CONTINUE BUTTON - TEMPORARY
// =====================================================================

class _ContinueSection extends StatelessWidget {
  const _ContinueSection();

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
        child: AppPrimaryButton(
          title: 'Continue',
          onPressed: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) =>
          const VerificationApprovedScreen(),
    ),
  );
},
        ),
      ),
    );
  }
}
