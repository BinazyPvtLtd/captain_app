import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../model/driver_document_model.dart';
import '../view_model/documents_view_model.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DocumentsViewModel(),
      child: const _DocumentsView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _DocumentsView extends StatelessWidget {
  const _DocumentsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // =========================================================
      // FIXED UPDATE BUTTON
      // =========================================================

      bottomNavigationBar:
          const _UpdateDocumentSection(),

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            const _DocumentsHeader(),

            const Divider(
              height: 1,
              color: AppColors.divider,
            ),

            // =====================================================
            // DOCUMENT LIST
            // =====================================================

            Expanded(
              child: Consumer<DocumentsViewModel>(
                builder: (
                  context,
                  viewModel,
                  child,
                ) {
                  return ListView.separated(
                    physics:
                        const BouncingScrollPhysics(),

                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenHorizontal,
                      AppSpacing.lg,
                      AppSpacing.screenHorizontal,
                      AppSpacing.xl,
                    ),

                    itemCount:
                        viewModel.documents.length,

                    separatorBuilder: (
                      context,
                      index,
                    ) {
                      return const Divider(
                        height: 1,
                        color: AppColors.divider,
                      );
                    },

                    itemBuilder: (
                      context,
                      index,
                    ) {
                      final document =
                          viewModel.documents[index];

                      return _DocumentItem(
                        document: document,
                        onTap: () {
                          viewModel.openDocument(
                            document: document,
                            onPressed: () {
                              debugPrint(
                                'Open ${document.title}',
                              );

                              // TODO:
                              // Open document details screen
                            },
                          );
                        },
                      );
                    },
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

class _DocumentsHeader extends StatelessWidget {
  const _DocumentsHeader();

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
              'Documents',
              textAlign: TextAlign.left,
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
// DOCUMENT ITEM
// =====================================================================

class _DocumentItem extends StatelessWidget {
  final DriverDocumentModel document;
  final VoidCallback onTap;

  const _DocumentItem({
    required this.document,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            // =====================================================
            // ICON
            // =====================================================

            SizedBox(
              width: 48,
              height: 48,
              child: Center(
                child: Icon(
                  _getDocumentIcon(
                    document.id,
                  ),
                  size: AppSpacing.iconMD,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            AppSpacing.horizontalMD,

            // =====================================================
            // DOCUMENT INFO
            // =====================================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    document.title,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style:
                        AppTextStyles.titleLarge.copyWith(
                      fontWeight:
                          FontWeight.w600,
                      color:
                          AppColors.textPrimary,
                    ),
                  ),

                  AppSpacing.gapSM,

                  _DocumentStatusBadge(
                    document: document,
                  ),
                ],
              ),
            ),

            AppSpacing.horizontalSM,

            // =====================================================
            // ARROW
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

  IconData _getDocumentIcon(
    String id,
  ) {
    switch (id) {
      case 'driving_licence':
        return Icons.badge_outlined;

      case 'aadhaar':
        return Icons.badge_outlined;

      case 'pan':
        return Icons.credit_card_outlined;

      case 'vehicle_rc':
        return Icons.directions_car_outlined;

      case 'insurance':
        return Icons.description_outlined;

      case 'pollution':
        return Icons.eco_outlined;

      default:
        return Icons.description_outlined;
    }
  }
}

// =====================================================================
// STATUS BADGE
// =====================================================================

class _DocumentStatusBadge
    extends StatelessWidget {
  final DriverDocumentModel document;

  const _DocumentStatusBadge({
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final bool isExpiring =
        document.status ==
            DriverDocumentStatus.expiringSoon;

    final String label;

    switch (document.status) {
      case DriverDocumentStatus.approved:
        label = 'Approved';
        break;

      case DriverDocumentStatus.expiringSoon:
        label =
            'Expires in ${document.daysUntilExpiry ?? 0} days';
        break;

      case DriverDocumentStatus.pending:
        label = 'Pending';
        break;

      case DriverDocumentStatus.rejected:
        label = 'Rejected';
        break;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: isExpiring
              ? AppColors.primary
              : AppColors.surfaceSecondary,

          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusXS,
          ),
        ),
        child: Text(
          label,
          style:
              AppTextStyles.labelMedium.copyWith(
            color: isExpiring
                ? AppColors.white
                : AppColors.textPrimary,

            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// UPDATE DOCUMENT
// =====================================================================

class _UpdateDocumentSection
    extends StatelessWidget {
  const _UpdateDocumentSection();

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
          height: 54,
          child: OutlinedButton(
            onPressed: () {
              context
                  .read<DocumentsViewModel>()
                  .updateDocument(
                onPressed: () {
                  debugPrint(
                    'Update document',
                  );

                  // TODO:
                  // Open document update/upload screen
                },
              );
            },

            style: OutlinedButton.styleFrom(
              foregroundColor:
                  AppColors.textPrimary,

              backgroundColor:
                  AppColors.background,

              side: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  AppSpacing.radiusSM,
                ),
              ),
            ),

            child: Text(
              'UPDATE DOCUMENT',
              style:
                  AppTextStyles.titleMedium.copyWith(
                fontWeight:
                    FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}