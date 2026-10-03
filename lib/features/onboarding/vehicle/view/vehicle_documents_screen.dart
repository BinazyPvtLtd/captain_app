import 'package:driver_app/features/onboarding/verification/view/verification_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_primary_button.dart';

import '../model/vehicle_document_model.dart';
import '../view_model/vehicle_documents_view_model.dart';

class VehicleDocumentsScreen
    extends StatelessWidget {
  const VehicleDocumentsScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return ChangeNotifierProvider(
      create: (_) =>
          VehicleDocumentsViewModel(),
      child:
          const _VehicleDocumentsView(),
    );
  }
}

// =====================================================================
// VIEW
// =====================================================================

class _VehicleDocumentsView extends StatelessWidget {
  const _VehicleDocumentsView();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final bool compact = screenHeight < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,

      bottomNavigationBar: const _SubmitVehicleSection(),

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vehicle Documents',
                      style: AppTextStyles.headingLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    AppSpacing.gapXS,

                    Text(
                      'Upload valid vehicle documents for verification.',
                      style:
                          AppTextStyles.bodyMediumSecondary.copyWith(
                        height: 1.45,
                      ),
                    ),

                    SizedBox(
                      height: compact
                          ? AppSpacing.lg
                          : AppSpacing.xl,
                    ),

                    const _DocumentList(),

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
      height: 50,
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
              'Vehicle Documents',
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
        VehicleDocumentsViewModel>(
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
              _VehicleDocumentCard(
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

class _VehicleDocumentCard extends StatelessWidget {
  final VehicleDocumentModel document;

  const _VehicleDocumentCard({
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.read<VehicleDocumentsViewModel>();

    final bool uploading =
        viewModel.isUploading(document.id);

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      radius: AppSpacing.radiusLG,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool narrow = constraints.maxWidth < 330;

          if (narrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _DocumentIcon(
                      icon: document.icon,
                    ),

                    AppSpacing.horizontalMD,

                    Expanded(
                      child: _DocumentInfo(
                        document: document,
                      ),
                    ),
                  ],
                ),

                AppSpacing.gapMD,

                SizedBox(
                  width: double.infinity,
                  child: document.isUploaded
                      ? _ViewButton(
                          document: document,
                          fullWidth: true,
                        )
                      : _UploadButton(
                          isLoading: uploading,
                          fullWidth: true,
                          onPressed: uploading
                              ? null
                              : () {
                                  viewModel.uploadDocument(
                                    context,
                                    document,
                                  );
                                },
                        ),
                ),
              ],
            );
          }

          return Row(
            children: [
              _DocumentIcon(
                icon: document.icon,
              ),

              AppSpacing.horizontalMD,

              Expanded(
                child: _DocumentInfo(
                  document: document,
                ),
              ),

              AppSpacing.horizontalSM,

              document.isUploaded
                  ? _ViewButton(
                      document: document,
                    )
                  : _UploadButton(
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
          );
        },
      ),
    );
  }
}

class _DocumentIcon extends StatelessWidget {
  final IconData icon;

  const _DocumentIcon({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusMD,
        ),
      ),
      child: Icon(
        icon,
        size: AppSpacing.iconMD,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _DocumentInfo extends StatelessWidget {
  final VehicleDocumentModel document;

  const _DocumentInfo({
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          document.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        AppSpacing.gapXXS,

        document.isUploaded
            ? const _UploadedStatus()
            : const _PendingStatus(),
      ],
    );
  }
}

// =====================================================================
// PENDING STATUS
// =====================================================================

class _PendingStatus
    extends StatelessWidget {
  const _PendingStatus();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal:
            AppSpacing.sm,
        vertical:
            AppSpacing.xxs,
      ),
      decoration:
          BoxDecoration(
        color:
            AppColors
                .surfaceSecondary,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusXS,
        ),
      ),
      child: Text(
        'PENDING',
        style:
            AppTextStyles
                .labelMedium
                .copyWith(
          color:
              AppColors
                  .textSecondary,
          fontWeight:
              FontWeight.w600,
          letterSpacing:
              0.5,
        ),
      ),
    );
  }
}

// =====================================================================
// UPLOADED STATUS
// =====================================================================

class _UploadedStatus
    extends StatelessWidget {
  const _UploadedStatus();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal:
            AppSpacing.sm,
        vertical:
            AppSpacing.xxs,
      ),
      decoration:
          BoxDecoration(
        color:
            AppColors
                .surfaceSecondary,
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
      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          const Icon(
            Icons
                .check_circle_rounded,
            size:
                AppSpacing.iconXS,
            color:
                AppColors.primary,
          ),

          AppSpacing.horizontalXXS,

          Text(
            'UPLOADED',
            style:
                AppTextStyles
                    .labelMedium
                    .copyWith(
              color:
                  AppColors
                      .textPrimary,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// UPLOAD BUTTON
// =====================================================================

class _UploadButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final bool fullWidth;

  const _UploadButton({
    required this.isLoading,
    required this.onPressed,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : 104,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor:
              AppColors.primary.withValues(alpha: 0.55),
          disabledForegroundColor: AppColors.white,

          elevation: 0,

          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
          ),

          // Same rounded style as Login Screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.xxl,
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
            : const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_outlined,
                    size: AppSpacing.iconSM,
                  ),
                  SizedBox(
                    width: AppSpacing.xs,
                  ),
                  Text(
                    'Upload',
                    style: AppTextStyles.primaryButton,
                  ),
                ],
              ),
      ),
    );
  }
}
// =====================================================================
// VIEW BUTTON
// =====================================================================

class _ViewButton extends StatelessWidget {
  final VehicleDocumentModel document;
  final bool fullWidth;

  const _ViewButton({
    required this.document,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : 88,
      height: 44,
      child: OutlinedButton(
        onPressed: () {
          _showDocumentSheet(context);
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.primary,

          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
          ),

         
          side: BorderSide(
            color: AppColors.primary.withValues(
              alpha: 0.35,
            ),
            width: 1.3,
          ),

          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.xxl,
            ),
          ),
        ),
        child: Text(
          'View',
          style: AppTextStyles.secondaryButton,
        ),
      ),
    );
  }

  void _showDocumentSheet(
    BuildContext context,
  ) {
    final viewModel =
        context.read<VehicleDocumentsViewModel>();

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.background,
      showDragHandle: true,
      isScrollControlled: true,
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
                    Navigator.of(
                      sheetContext,
                    ).pop();

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
// SUBMIT VEHICLE
// =====================================================================

class _SubmitVehicleSection extends StatelessWidget {
  const _SubmitVehicleSection();

  @override
  Widget build(BuildContext context) {
    final double keyboardInset =
        MediaQuery.viewInsetsOf(context).bottom;

    final double systemBottomInset =
        MediaQuery.viewPaddingOf(context).bottom;

    // Normally this screen has no text input,
    // but keeping it safe for future changes.
    final bool keyboardOpen = keyboardInset > 0;

    if (keyboardOpen) {
      return const SizedBox.shrink();
    }

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
      child: Consumer<VehicleDocumentsViewModel>(
        builder: (
          context,
          viewModel,
          child,
        ) {
          return AppPrimaryButton(
            title: 'Submit Vehicle',
            isLoading: viewModel.isSubmitting,
            onPressed: () {
              FocusManager.instance.primaryFocus
                  ?.unfocus();

              viewModel.submitVehicle(
                context,
                onSuccess: () {
                  Navigator.of(context)
                      .pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) =>
                          const VerificationStatusView(),
                    ),
                    (route) => false,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}