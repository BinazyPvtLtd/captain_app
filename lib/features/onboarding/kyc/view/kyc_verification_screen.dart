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

class _KycVerificationView
    extends StatelessWidget {
  const _KycVerificationView();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      // =========================================================
      // FIXED SUBMIT BUTTON
      // =========================================================

      bottomNavigationBar:
          const _SubmitSection(),

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
              child:
                  SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.xl,
                  AppSpacing.screenHorizontal,
                  AppSpacing.xxl,
                ),
                child: Column(
                  children: [
                    // =============================================
                    // PROGRESS
                    // =============================================

                    const _ProgressSection(),

                    AppSpacing.gapXXL,

                    // =============================================
                    // DOCUMENTS
                    // =============================================

                    const _DocumentList(),

                    AppSpacing.gapXXL,

                    // =============================================
                    // INFO
                    // =============================================

                    const _InformationCard(),

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
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .maybePop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: AppSpacing.iconLG,
                color:
                    AppColors.textPrimary,
              ),
            ),
          ),

          Expanded(
            child: Text(
              'KYC Verification',
              textAlign:
                  TextAlign.center,
              style:
                  AppTextStyles
                      .headingLarge,
            ),
          ),

          // Keeps title genuinely centered.
          const SizedBox(
            width: 64,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// PROGRESS
// =====================================================================

class _ProgressSection
    extends StatelessWidget {
  const _ProgressSection();

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
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    'VERIFICATION PROGRESS',
                    style:
                        AppTextStyles
                            .labelLarge
                            .copyWith(
                      color:
                          AppColors
                              .textSecondary,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),

                Text(
                  '${viewModel.uploadedCount} of ${viewModel.totalCount} completed',
                  style:
                      AppTextStyles
                          .titleSmall,
                ),
              ],
            ),

            AppSpacing.gapSM,

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(
                AppSpacing
                    .radiusCircular,
              ),
              child:
                  LinearProgressIndicator(
                value:
                    viewModel.progress,
                minHeight: 7,
                color:
                    AppColors.primary,
                backgroundColor:
                    AppColors.border,
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
                AppSpacing.gapMD,
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

class _DocumentCard
    extends StatelessWidget {
  final KycDocumentModel document;

  const _DocumentCard({
    required this.document,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final viewModel = context
        .read<
            KycVerificationViewModel>();

    final bool uploading =
        viewModel.isUploading(
      document.id,
    );

    return AppCard(
      padding:
          const EdgeInsets.all(
        AppSpacing.md,
      ),
      radius:
          AppSpacing.radiusXL,
      borderColor:
          document.isUploaded
              ? AppColors.border
              : AppColors.primary,
      child: Row(
        children: [
          // =================================================
          // ICON
          // =================================================

          Container(
            width: 58,
            height: 58,
            decoration:
                BoxDecoration(
              color:
                  AppColors
                      .surfaceSecondary,
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusLG,
              ),
            ),
            child: Icon(
              document.icon,
              size:
                  AppSpacing.iconLG,
              color:
                  AppColors.textPrimary,
            ),
          ),

          AppSpacing.horizontalMD,

          // =================================================
          // DOCUMENT DETAILS
          // =================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  document.title,
                  style:
                      AppTextStyles
                          .headingSmall,
                ),

                AppSpacing.gapXS,

                if (document.isUploaded)
                  const _UploadedBadge()
                else
                  _PendingBadge(
                    optional:
                        !document
                            .isRequired,
                  ),
              ],
            ),
          ),

          AppSpacing.horizontalSM,

          // =================================================
          // ACTION
          // =================================================

          if (document.isUploaded)
            _ViewButton(
              document:
                  document,
            )
          else
            _UploadButton(
              isLoading:
                  uploading,
              onPressed:
                  uploading
                      ? null
                      : () {
                          viewModel
                              .uploadDocument(
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

class _UploadedBadge
    extends StatelessWidget {
  const _UploadedBadge();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration:
          BoxDecoration(
        color:
            AppColors.surfaceSecondary,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusXS,
        ),
        border:
            Border.all(
          color:
              AppColors.border,
        ),
      ),
      child: Text(
        'UPLOADED',
        style:
            AppTextStyles.labelMedium
                .copyWith(
          color:
              AppColors.textPrimary,
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }
}

// =====================================================================
// PENDING BADGE
// =====================================================================

class _PendingBadge
    extends StatelessWidget {
  final bool optional;

  const _PendingBadge({
    required this.optional,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration:
          BoxDecoration(
        color:
            AppColors.surfaceSecondary,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusXS,
        ),
        border:
            Border.all(
          color:
              AppColors.border,
        ),
      ),
      child: Text(
        optional
            ? 'OPTIONAL'
            : 'PENDING',
        style:
            AppTextStyles.labelMedium
                .copyWith(
          color:
              AppColors.textSecondary,
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }
}

// =====================================================================
// VIEW BUTTON
// =====================================================================

class _ViewButton
    extends StatelessWidget {
  final KycDocumentModel document;

  const _ViewButton({
    required this.document,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: () {
          _showDocumentSheet(
            context,
          );
        },
        style:
            OutlinedButton.styleFrom(
          minimumSize:
              const Size(
            88,
            48,
          ),
          padding:
              const EdgeInsets.symmetric(
            horizontal:
                AppSpacing.lg,
          ),
        ),
        child: const Text(
          'View',
        ),
      ),
    );
  }

  void _showDocumentSheet(
    BuildContext context,
  ) {
    final viewModel = context
        .read<
            KycVerificationViewModel>();

    showModalBottomSheet<void>(
      context: context,
      backgroundColor:
          AppColors.background,
      showDragHandle: true,
      builder: (
        sheetContext,
      ) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.all(
              AppSpacing
                  .screenHorizontal,
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  document.title,
                  style:
                      AppTextStyles
                          .headingMedium,
                ),

                AppSpacing.gapSM,

                Text(
                  document.fileName ??
                      'Uploaded document',
                  style:
                      AppTextStyles
                          .bodyMediumSecondary,
                ),

                AppSpacing.gapXL,

                AppPrimaryButton(
                  title:
                      'Replace Document',
                  onPressed: () {
                    Navigator.of(
                      sheetContext,
                    ).pop();

                    viewModel
                        .removeDocument(
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

class _UploadButton
    extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const _UploadButton({
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: 100,
      height: 48,
      child: ElevatedButton(
        onPressed:
            onPressed,
        child:
            isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child:
                        CircularProgressIndicator(
                      strokeWidth: 2,
                      color:
                          AppColors.white,
                    ),
                  )
                : const Text(
                    'Upload',
                  ),
      ),
    );
  }
}

// =====================================================================
// INFORMATION CARD
// =====================================================================

class _InformationCard
    extends StatelessWidget {
  const _InformationCard();

  @override
  Widget build(
    BuildContext context,
  ) {
    return AppCard(
      backgroundColor:
          AppColors.surfaceSecondary,
      padding:
          const EdgeInsets.all(
        AppSpacing.lg,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size:
                AppSpacing.iconLG,
            color:
                AppColors.textSecondary,
          ),

          AppSpacing.horizontalMD,

          Expanded(
            child: Text(
              'All documents must be clear and legible. '
              'Verification typically takes 24–48 hours after submission.',
              style:
                  AppTextStyles
                      .bodyMediumSecondary,
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

class _SubmitSection
    extends StatelessWidget {
  const _SubmitSection();

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
          border:
              Border(
            top:
                BorderSide(
              color:
                  AppColors.divider,
            ),
          ),
        ),
        child: Consumer<
            KycVerificationViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return AppPrimaryButton(
              title:
                  'Submit Documents',
              isLoading:
                  viewModel.isSubmitting,
              onPressed: () {
                viewModel
                    .submitDocuments(
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