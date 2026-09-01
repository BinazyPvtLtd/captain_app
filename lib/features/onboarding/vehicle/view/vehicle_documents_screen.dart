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

class _VehicleDocumentsView
    extends StatelessWidget {
  const _VehicleDocumentsView();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      bottomNavigationBar:
          const _SubmitVehicleSection(),

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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // =============================================
                    // TITLE
                    // =============================================

                    Text(
                      'Vehicle Documents',
                      style:
                          AppTextStyles
                              .displaySmall,
                    ),

                    AppSpacing.gapSM,

                    // =============================================
                    // SUBTITLE
                    // =============================================

                    Text(
                      'Upload valid vehicle documents for verification.',
                      style:
                          AppTextStyles
                              .bodyLargeSecondary,
                    ),

                    AppSpacing.gapXXL,

                    // =============================================
                    // DOCUMENTS
                    // =============================================

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
                size:
                    AppSpacing.iconLG,
                color:
                    AppColors.textPrimary,
              ),
            ),
          ),

          Expanded(
            child: Text(
              'Vehicle Documents',
              textAlign:
                  TextAlign.center,
              style:
                  AppTextStyles
                      .headingLarge,
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

class _VehicleDocumentCard
    extends StatelessWidget {
  final VehicleDocumentModel document;

  const _VehicleDocumentCard({
    required this.document,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final viewModel = context
        .read<
            VehicleDocumentsViewModel>();

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
          // TITLE + STATUS
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

                document.isUploaded
                    ? const _UploadedStatus()
                    : const _PendingStatus(),
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
      width: 120,
      height: 48,
      child:
          ElevatedButton(
        onPressed:
            onPressed,
            style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
          ),
        ),
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
                : const Row(
                  mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                    children: [
                      Icon(
                        Icons
                            .upload_outlined,
                        size:
                            AppSpacing.iconSM,
                      ),

                      SizedBox(
                        width:
                            AppSpacing.xs,
                      ),

                      Text(
                        'Upload',
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

  const _ViewButton({
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 48,
      child: OutlinedButton(
        onPressed: () {
          _showDocumentSheet(
            context,
          );
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
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
                  style:
                      AppTextStyles.headingMedium,
                ),

                AppSpacing.gapSM,

                Text(
                  document.fileName ??
                      'Uploaded document',
                  style: AppTextStyles
                      .bodyMediumSecondary,
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

class _SubmitVehicleSection
    extends StatelessWidget {
  const _SubmitVehicleSection();

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
            VehicleDocumentsViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return AppPrimaryButton(
              title:
                  'Submit Vehicle',
              isLoading:
                  viewModel.isSubmitting,
              onPressed: () {
                viewModel
                    .submitVehicle(
                  context,
                 onSuccess: () {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (_) =>
          const VerificationStatusScreen(),
    ),
    (route) => false,
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