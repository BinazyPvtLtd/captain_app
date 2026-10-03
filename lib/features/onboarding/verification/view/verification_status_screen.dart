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

class VerificationStatusView extends StatelessWidget {
  const VerificationStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VerificationStatusViewModel(),
      child: const _VerificationStatusContent(),
    );
  }
}

class _VerificationStatusContent extends StatelessWidget {
  const _VerificationStatusContent();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final bool compact = screenHeight < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,

      bottomNavigationBar: const _ContinueSection(),

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _Header(),

            const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.divider,
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  compact ? AppSpacing.lg : AppSpacing.xl,
                  AppSpacing.screenHorizontal,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const _VerificationIcon(),

                    SizedBox(
                      height: compact
                          ? AppSpacing.md
                          : AppSpacing.lg,
                    ),

                    Text(
                      'Verification in Progress',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headingLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    AppSpacing.gapXS,

                    Text(
                      'We’re reviewing your documents.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMediumSecondary,
                    ),

                    SizedBox(
                      height: compact
                          ? AppSpacing.lg
                          : AppSpacing.xl,
                    ),

                    const _VerificationCard(),

                    SizedBox(
                      height: compact
                          ? AppSpacing.lg
                          : AppSpacing.xl,
                    ),

                    const AppStatusBadge(
                      text: 'Under Review',
                      type: AppStatusType.neutral,
                    ),

                    AppSpacing.gapSM,

                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 320,
                      ),
                      child: Text(
                        'We’ll notify you when your account is approved.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMediumSecondary,
                      ),
                    ),

                    SizedBox(
                      height: compact
                          ? AppSpacing.lg
                          : AppSpacing.xl,
                    ),

                    SizedBox(
                      width: 190,
                      child: AppSecondaryButton(
                        title: 'View Documents',
                        onPressed: () {
                          context
                              .read<VerificationStatusViewModel>()
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

                    AppSpacing.gapLG,
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

// class VerificationStatusView extends StatelessWidget {
//   const VerificationStatusView();

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.sizeOf(context).height;

//     final bool compact = screenHeight < 700;

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       resizeToAvoidBottomInset: true,

//       bottomNavigationBar: const _ContinueSection(),

//       body: SafeArea(
//         bottom: false,
//         child: Column(
//           children: [
//             const _Header(),

//             const Divider(
//               height: 1,
//               thickness: 1,
//               color: AppColors.divider,
//             ),

//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const ClampingScrollPhysics(),
//                 padding: EdgeInsets.fromLTRB(
//                   AppSpacing.screenHorizontal,
//                   compact
//                       ? AppSpacing.lg
//                       : AppSpacing.xl,
//                   AppSpacing.screenHorizontal,
//                   AppSpacing.xl,
//                 ),
//                 child: Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment.center,
//                   children: [
//                     const _VerificationIcon(),

//                     SizedBox(
//                       height: compact
//                           ? AppSpacing.md
//                           : AppSpacing.lg,
//                     ),

//                     Text(
//                       'Verification in Progress',
//                       textAlign: TextAlign.center,
//                       style:
//                           AppTextStyles.headingLarge.copyWith(
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),

//                     AppSpacing.gapXS,

//                     Text(
//                       'We’re reviewing your documents.',
//                       textAlign: TextAlign.center,
//                       style:
//                           AppTextStyles.bodyMediumSecondary,
//                     ),

//                     SizedBox(
//                       height: compact
//                           ? AppSpacing.lg
//                           : AppSpacing.xl,
//                     ),

//                     const _VerificationCard(),

//                     SizedBox(
//                       height: compact
//                           ? AppSpacing.lg
//                           : AppSpacing.xl,
//                     ),

//                     const AppStatusBadge(
//                       text: 'Under Review',
//                       type: AppStatusType.neutral,
//                     ),

//                     AppSpacing.gapSM,

//                     ConstrainedBox(
//                       constraints: const BoxConstraints(
//                         maxWidth: 320,
//                       ),
//                       child: Text(
//                         'We’ll notify you when your account is approved.',
//                         textAlign: TextAlign.center,
//                         style:
//                             AppTextStyles.bodyMediumSecondary,
//                       ),
//                     ),

//                     SizedBox(
//                       height: compact
//                           ? AppSpacing.lg
//                           : AppSpacing.xl,
//                     ),

//                     SizedBox(
//                       width: 190,
//                       child: AppSecondaryButton(
//                         title: 'View Documents',
//                         onPressed: () {
//                           context
//                               .read<
//                                   VerificationStatusViewModel>()
//                               .viewDocuments(
//                             onPressed: () {
//                               debugPrint(
//                                 'Open submitted documents',
//                               );

//                               // TODO:
//                               // Open submitted documents screen.
//                             },
//                           );
//                         },
//                       ),
//                     ),

//                     AppSpacing.gapLG,
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// =====================================================================
// HEADER
// =====================================================================

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
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
              'Verification Status',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyles.headingMedium.copyWith(
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
// VERIFICATION ICON
// =====================================================================

class _VerificationIcon extends StatelessWidget {
  const _VerificationIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusXL,
        ),
      ),
      child: const Icon(
        Icons.fact_check_outlined,
        size: AppSpacing.iconXXL,
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
    return Consumer<VerificationStatusViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          radius: AppSpacing.radiusLG,
          child: Column(
            children: [
              for (
                int index = 0;
                index < viewModel.items.length;
                index++
              ) ...[
                _VerificationRow(
                  item: viewModel.items[index],
                ),

                if (index !=
                    viewModel.items.length - 1)
                  const Divider(
                    height: 1,
                    color: AppColors.divider,
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
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyles.titleSmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          AppSpacing.horizontalSM,

          Text(
            item.status,
            style:
                AppTextStyles.labelMedium.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),

          AppSpacing.horizontalXS,

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
    final double systemBottomInset =
        MediaQuery.viewPaddingOf(context).bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.divider,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
        AppSpacing.screenHorizontal,
        AppSpacing.sm + systemBottomInset,
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
    );
  }
}
