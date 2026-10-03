import 'package:driver_app/features/onboarding/vehicle/view/vehicle_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_primary_button.dart';

import '../model/kyc_document_model.dart';
import '../view_model/kyc_verification_view_model.dart';

class KycVerificationScreen
    extends StatelessWidget {
  const KycVerificationScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return ChangeNotifierProvider(
      create: (_) =>
          KycVerificationViewModel(),
      child:
          const _KycVerificationView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _KycVerificationView extends StatelessWidget {
  const _KycVerificationView();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final bool compact = screenHeight < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,

      bottomNavigationBar: const _SubmitSection(),

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
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  compact ? AppSpacing.lg : AppSpacing.xl,
                  AppSpacing.screenHorizontal,
                  AppSpacing.xl,
                ),
                child: Column(
                  children: [
                    const _ProgressSection(),

                    SizedBox(
                      height: compact
                          ? AppSpacing.lg
                          : AppSpacing.xl,
                    ),

                    const _DocumentList(),

                    AppSpacing.gapXL,

                    const _InformationCard(),

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
              'KYC Verification',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.headingMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(width: 56),
        ],
      ),
    );
  }
}

// =====================================================================
// PROGRESS
// =====================================================================

class _ProgressSection extends StatelessWidget {
  const _ProgressSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<KycVerificationViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'VERIFICATION PROGRESS',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),

                AppSpacing.horizontalSM,

                Text(
                  '${viewModel.uploadedCount}/${viewModel.totalCount} completed',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            AppSpacing.gapSM,

            ClipRRect(
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusCircular,
              ),
              child: LinearProgressIndicator(
                value: viewModel.progress,
                minHeight: 6,
                color: AppColors.primary,
                backgroundColor: AppColors.border,
              ),
            ),
          ],
        );
      },
    );
  }
}
// =====================================================================
// DOCUMENT LIST
// =====================================================================

class _DocumentList
    extends StatelessWidget {
  const _DocumentList();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer<
        KycVerificationViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return Column(
          children: [
            for (
              int index = 0;
              index <
                  viewModel
                      .documents.length;
              index++
            ) ...[
              _DocumentCard(
                document:
                    viewModel
                        .documents[index],
              ),

              if (index !=
                  viewModel
                          .documents
                          .length -
                      1)
                AppSpacing.gapSM,
            ],
          ],
        );
      },
    );
  }
}

// =====================================================================
// DOCUMENT CARD
// =====================================================================

class _DocumentCard extends StatelessWidget {
  final KycDocumentModel document;

  const _DocumentCard({
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.read<KycVerificationViewModel>();

    final bool uploading = viewModel.isUploading(
      document.id,
    );

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.sm),
      radius: AppSpacing.radiusLG,

      // All cards visually consistent.
      borderColor: document.isUploaded
          ? AppColors.border
          : AppColors.borderDark,

      child: Row(
        children: [
          // ICON
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMD,
              ),
            ),
            child: Icon(
              document.icon,
              size: AppSpacing.iconMD,
              color: AppColors.textPrimary,
            ),
          ),

          AppSpacing.horizontalSM,

          // TITLE + STATUS
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                AppSpacing.gapXS,

                if (document.isUploaded)
                  const _UploadedBadge()
                else
                  _PendingBadge(
                    optional: !document.isRequired,
                  ),
              ],
            ),
          ),

          AppSpacing.horizontalSM,

          if (document.isUploaded)
            _ViewButton(
              document: document,
            )
          else
            _UploadButton(
              isLoading: uploading,
              onPressed: uploading
                  ? null
                  : () {
                      viewModel.uploadDocument(
                        context,
                        document,
                      );
                    },
            ),
        ],
      ),
    );
  }
}

// =====================================================================
// UPLOADED BADGE
// =====================================================================

class _UploadedBadge extends StatelessWidget {
  const _UploadedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusXS,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Text(
        'UPLOADED',
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// =====================================================================
// PENDING BADGE
// =====================================================================

class _PendingBadge extends StatelessWidget {
  final bool optional;

  const _PendingBadge({
    required this.optional,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusXS,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Text(
        optional ? 'OPTIONAL' : 'PENDING',
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// =====================================================================
// VIEW BUTTON
// =====================================================================

class _ViewButton extends StatelessWidget {
  final KycDocumentModel document;

  const _ViewButton({
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 42,
      child: OutlinedButton(
        onPressed: () {
          _showDocumentSheet(context);
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(76, 42),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusMD,
            ),
          ),
        ),
        child: Text(
          'View',
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  void _showDocumentSheet(
    BuildContext context,
  ) {
    final viewModel =
        context.read<KycVerificationViewModel>();

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.background,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              AppSpacing.screenHorizontal,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  document.title,
                  style: AppTextStyles.headingMedium,
                ),

                AppSpacing.gapSM,

                Text(
                  document.fileName ??
                      'Uploaded document',
                  style:
                      AppTextStyles.bodyMediumSecondary,
                ),

                AppSpacing.gapXL,

                AppPrimaryButton(
                  title: 'Replace Document',
                  onPressed: () {
                    Navigator.of(sheetContext).pop();

                    viewModel.removeDocument(
                      document,
                    );
                  },
                ),

                AppSpacing.gapMD,
              ],
            ),
          ),
        );
      },
    );
  }
}

// =====================================================================
// UPLOAD BUTTON
// =====================================================================

class _UploadButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const _UploadButton({
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 42,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(76, 42),
          elevation: 0,
          tapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusMD,
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Text(
                'Upload',
                style:
                    AppTextStyles.labelLarge.copyWith(
                  color: AppColors.white,
                ),
              ),
      ),
    );
  }
}
// =====================================================================
// INFORMATION CARD
// =====================================================================

class _InformationCard extends StatelessWidget {
  const _InformationCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.surfaceSecondary,
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),
      radius: AppSpacing.radiusLG,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: AppSpacing.iconSM,
            color: AppColors.textSecondary,
          ),

          AppSpacing.horizontalSM,

          Expanded(
            child: Text(
              'All documents must be clear and legible. '
              'Verification typically takes 24–48 hours after submission.',
              style:
                  AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SUBMIT
// =====================================================================

class _SubmitSection extends StatelessWidget {
  const _SubmitSection();

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
        child: Consumer<KycVerificationViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return AppPrimaryButton(
              title: 'Submit Documents',
              isLoading: viewModel.isSubmitting,
              onPressed: () {
                viewModel.submitDocuments(
                  context,
                  onSuccess: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            const VehicleDetailsScreen(),
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