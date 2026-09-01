import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../model/notification_item_model.dart';
import '../view_model/notifications_view_model.dart';

class NotificationsSheet extends StatelessWidget {
  const NotificationsSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationsViewModel(),
      child: const _NotificationsSheetView(),
    );
  }
}

// =====================================================================
// MAIN SHEET
// =====================================================================

class _NotificationsSheetView extends StatelessWidget {
  const _NotificationsSheetView();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,

          // Around 82–86% screen height.
          constraints: BoxConstraints(
            maxHeight:
                MediaQuery.of(context).size.height * 0.84,
          ),

          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.12,
                ),
                blurRadius: 24,
                offset: const Offset(
                  0,
                  8,
                ),
              ),
            ],
          ),

          child: Column(
            children: [
              // =================================================
              // HEADER
              // =================================================

              const _NotificationsHeader(),

              const Divider(
                height: 1,
                color: AppColors.divider,
              ),

              // =================================================
              // LIST
              // =================================================

              Expanded(
                child:
                    Consumer<NotificationsViewModel>(
                  builder: (
                    context,
                    viewModel,
                    child,
                  ) {
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      physics:
                          const BouncingScrollPhysics(),
                      itemCount:
                          viewModel.notifications.length,

                      separatorBuilder: (
                        context,
                        index,
                      ) {
                        return const Divider(
                          height: 1,
                          color:
                              AppColors.divider,
                        );
                      },

                      itemBuilder: (
                        context,
                        index,
                      ) {
                        final notification =
                            viewModel
                                .notifications[index];

                        return _NotificationItem(
                          notification:
                              notification,
                          onTap: () {
                            viewModel
                                .openNotification(
                              notification:
                                  notification,
                              onPressed: () {
                                debugPrint(
                                  'Open notification ${notification.id}',
                                );

                                // TODO:
                                // booking -> Delivery Request
                                // payment -> Earnings
                                // kyc -> KYC
                                // trip -> Trip details
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
      ),
    );
  }
}

// =====================================================================
// HEADER
// =====================================================================

class _NotificationsHeader
    extends StatelessWidget {
  const _NotificationsHeader();

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
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: AppSpacing.iconMD,
                color:
                    AppColors.textPrimary,
              ),
            ),
          ),

          Expanded(
            child: Text(
              'Notifications',
              style:
                  AppTextStyles.headingLarge.copyWith(
                fontWeight:
                    FontWeight.w700,
              ),
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
// NOTIFICATION ITEM
// =====================================================================

class _NotificationItem
    extends StatelessWidget {
  final NotificationItemModel notification;
  final VoidCallback onTap;

  const _NotificationItem({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal:
              AppSpacing.screenHorizontal,
          vertical:
              AppSpacing.md,
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // =================================================
            // UNREAD DOT
            // =================================================

            SizedBox(
              width: 14,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppSpacing.sm,
                ),
                child: notification.isUnread
                    ? Container(
                        width: 8,
                        height: 8,
                        decoration:
                            const BoxDecoration(
                          color:
                              AppColors.primary,
                          shape:
                              BoxShape.circle,
                        ),
                      )
                    : const SizedBox(),
              ),
            ),

            AppSpacing.horizontalXS,

            // =================================================
            // ICON
            // =================================================

            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color:
                    AppColors.surfaceSecondary,
                borderRadius:
                    BorderRadius.circular(
                  AppSpacing.radiusLG,
                ),
              ),
              child: Icon(
                _notificationIcon(
                  notification.type,
                ),
                size: AppSpacing.iconMD,
                color:
                    notification.isUnread
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
              ),
            ),

            AppSpacing.horizontalMD,

            // =================================================
            // TEXT
            // =================================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          notification.category,
                          style: AppTextStyles
                              .labelLarge
                              .copyWith(
                            color: AppColors
                                .textSecondary,
                            fontWeight:
                                FontWeight.w500,
                            letterSpacing:
                                0.7,
                          ),
                        ),
                      ),

                      AppSpacing.horizontalSM,

                      Text(
                        notification.time,
                        style: AppTextStyles
                            .bodySmall,
                      ),
                    ],
                  ),

                  AppSpacing.gapXS,

                  Text(
                    notification.message,
                    style:
                        AppTextStyles.titleMedium
                            .copyWith(
                      fontWeight:
                          notification.isUnread
                              ? FontWeight.w600
                              : FontWeight.w500,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _notificationIcon(
    NotificationType type,
  ) {
    switch (type) {
      case NotificationType.booking:
        return Icons.local_shipping_rounded;

      case NotificationType.payment:
        return Icons.payments_outlined;

      case NotificationType.kyc:
        return Icons.verified_user_outlined;

      case NotificationType.tripCompleted:
        return Icons.check_circle_outline_rounded;
    }
  }
}