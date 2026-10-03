import 'package:driver_app/features/booking/model/accepted_booking_model.dart';
import 'package:driver_app/features/booking/view/booking_accepted_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';

import '../model/delivery_request_model.dart';
import '../view_model/delivery_request_view_model.dart';

class DeliveryRequestScreen extends StatelessWidget {
  final DeliveryRequestModel request;

  const DeliveryRequestScreen({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeliveryRequestViewModel(
        request: request,
      ),
      child: const _DeliveryRequestView(),
    );
  }
}

// =====================================================================
// VIEW
// =====================================================================

class _DeliveryRequestView extends StatefulWidget {
  const _DeliveryRequestView();

  @override
  State<_DeliveryRequestView> createState() =>
      _DeliveryRequestViewState();
}

class _DeliveryRequestViewState
    extends State<_DeliveryRequestView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!mounted) {
          return;
        }

        context
            .read<DeliveryRequestViewModel>()
            .configureCallbacks(
          onAccept: _handleAccept,
          onReject: _handleReject,
          onExpired: _handleExpired,
        );
      },
    );
  }

  // =========================================================
  // ACCEPT
  // =========================================================

  void _handleAccept() {
  if (!mounted) {
    return;
  }

  final request =
      context
          .read<
              DeliveryRequestViewModel>()
          .request;

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) =>
          BookingAcceptedScreen(
        booking:
            AcceptedBookingModel(
          bookingId:
              request.id,

          pickup:
              request.pickup,

          pickupDistance:
              request.pickupDistance,

         
          customerName:
              'Rahul',

          customerId:
              '#PAT10285',

          customerImage:
              null,
        ),
      ),
    ),
  );
}

  // =========================================================
  // REJECT
  // =========================================================

  void _handleReject() {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();

    debugPrint(
      'BOOKING REJECTED',
    );
  }

  // =========================================================
  // EXPIRED
  // =========================================================

  void _handleExpired() {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();

    debugPrint(
      'BOOKING REQUEST EXPIRED',
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.surfaceSecondary,

    body: SafeArea(
      child: Consumer<DeliveryRequestViewModel>(
        builder: (
          context,
          viewModel,
          child,
        ) {
          return Padding(
            padding: const EdgeInsets.all(
              AppSpacing.sm,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return _DeliveryRequestCard(
                  viewModel: viewModel,
                );
              },
            ),
          );
        },
      ),
    ),
  );
}
}

// =====================================================================
// DELIVERY REQUEST CARD
// =====================================================================

class _DeliveryRequestCard extends StatelessWidget {
  final DeliveryRequestViewModel viewModel;

  const _DeliveryRequestCard({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final request = viewModel.request;

    return AppCard(
      padding: EdgeInsets.zero,
      radius: AppSpacing.radiusLG,
      showShadow: true,
      child: Column(
        children: [
          const _RequestHeader(),

          const Divider(height: 1),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Column(
                children: [
                  // EARNING
                  Text(
                    request.earning,
                    textAlign: TextAlign.center,
                    style:
                        AppTextStyles.displaySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                    'ESTIMATED EARNINGS',
                    style:
                        AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
                    ),
                  ),

                  AppSpacing.gapMD,

                  // PICKUP + DROP
                  _RouteSection(
                    pickup: request.pickup,
                    drop: request.drop,
                    pickupDistance:
                        request.pickupDistance,
                  ),

                  AppSpacing.gapMD,

                  // DISTANCE + TIME
                  Row(
                    children: [
                      Expanded(
                        child: _TripInfoCard(
                          icon: Icons.route_outlined,
                          label: 'TRIP DISTANCE',
                          value: request.tripDistance,
                        ),
                      ),

                      AppSpacing.horizontalSM,

                      Expanded(
                        child: _TripInfoCard(
                          icon: Icons.schedule_outlined,
                          label: 'ESTIMATED TIME',
                          value: request.estimatedTime,
                        ),
                      ),
                    ],
                  ),

                  AppSpacing.gapMD,

                  const Divider(height: 1),

                  AppSpacing.gapSM,

                  _DetailsRow(
                    icon: Icons.category_outlined,
                    label: 'Goods Type',
                    value: request.goodsType,
                  ),

                  AppSpacing.gapSM,

                  _DetailsRow(
                    icon: Icons.local_shipping_outlined,
                    label: 'Vehicle Req.',
                    value: request.vehicleRequired,
                  ),

                  const Spacer(),

                  // TIMER
                  _TimerSection(
                    viewModel: viewModel,
                  ),

                  AppSpacing.gapSM,

                  // ALWAYS VISIBLE
                  _FullWidthBookingSwipe(
                    viewModel: viewModel,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// =====================================================================
// HEADER
// =====================================================================

class _RequestHeader extends StatelessWidget {
  const _RequestHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMD,
              ),
            ),
            child: const Icon(
              Icons.notifications_active_outlined,
              size: AppSpacing.iconSM,
              color: AppColors.textPrimary,
            ),
          ),

          AppSpacing.horizontalSM,

          Expanded(
            child: Text(
              'NEW DELIVERY REQUEST',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// ROUTE
// =====================================================================

class _RouteSection extends StatelessWidget {
  final String pickup;
  final String drop;
  final String pickupDistance;

  const _RouteSection({
    required this.pickup,
    required this.drop,
    required this.pickupDistance,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const Icon(
              Icons.my_location_rounded,
              size: AppSpacing.iconSM,
              color: AppColors.primary,
            ),

            Container(
              width: 1.5,
              height: 42,
              color: AppColors.borderDark,
            ),

            const Icon(
              Icons.location_on_outlined,
              size: AppSpacing.iconMD,
              color: AppColors.primary,
            ),
          ],
        ),

        AppSpacing.horizontalMD,

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'PICKUP',
                style:
                    AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7,
                ),
              ),

              AppSpacing.gapXXS,

              Text(
                pickup,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              AppSpacing.gapXXS,

              Text(
                pickupDistance,
                style:
                    AppTextStyles.bodySmall,
              ),

              AppSpacing.gapXS,

              const Divider(height: 1),

              AppSpacing.gapXS,

              Text(
                'DROP',
                style:
                    AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7,
                ),
              ),

              AppSpacing.gapXXS,

              Text(
                drop,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// TRIP INFO CARD
// =====================================================================

class _TripInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _TripInfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.sm,
      ),
      radius: AppSpacing.radiusLG,
      child: Row(
        children: [
          Icon(
            icon,
            size: AppSpacing.iconSM,
            color: AppColors.textSecondary,
          ),

          AppSpacing.horizontalSM,

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),

                AppSpacing.gapXXS,

                Text(
                  value,
                  style:
                      AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// =====================================================================
// DETAILS ROW
// =====================================================================

class _DetailsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailsRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppSpacing.iconSM,
          color: AppColors.textSecondary,
        ),

        AppSpacing.horizontalSM,

        Text(
          label,
          style: AppTextStyles.bodyMediumSecondary,
        ),

        const Spacer(),

        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style:
                AppTextStyles.titleSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
class _FullWidthBookingSwipe extends StatelessWidget {
  final DeliveryRequestViewModel viewModel;

  const _FullWidthBookingSwipe({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        const double handleSize = 48;

        final double maxDrag =
            constraints.maxWidth - handleSize;

        return Column(
          children: [
            Text(
              'Swipe to respond',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            AppSpacing.gapXS,

            Container(
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(
                  AppSpacing.radiusCircular,
                ),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // =================================================
                  // CENTER LABELS
                  // =================================================

                  // Positioned.fill(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: AppSpacing.xl,
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment:
                  //           MainAxisAlignment.spaceBetween,
                  //       // children: [
                  //       //   Text(
                  //       //     'ACCEPT',
                  //       //     style:
                  //       //         AppTextStyles.labelMedium.copyWith(
                  //       //       color:
                  //       //           AppColors.textSecondary,
                  //       //       letterSpacing: 0.8,
                  //       //     ),
                  //       //   ),
                  //       //   Text(
                  //       //     'REJECT',
                  //       //     style:
                  //       //         AppTextStyles.labelMedium.copyWith(
                  //       //       color:
                  //       //           AppColors.textSecondary,
                  //       //       letterSpacing: 0.8,
                  //       //     ),
                  //       //   ),
                  //       // ],
                  //     ),
                  //   ),
                  // ),

                  // =================================================
                  // GREEN ACCEPT HANDLE
                  // Starts LEFT → moves RIGHT
                  // =================================================

                  Positioned(
                    left: 0,
                    child: Transform.translate(
                      offset: Offset(
                        viewModel.acceptOffset,
                        0,
                      ),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragUpdate: (
                          details,
                        ) {
                          viewModel.updateAcceptSwipe(
                            delta: details.delta.dx,
                            maxDrag: maxDrag,
                          );
                        },
                        onHorizontalDragEnd: (_) {
                          viewModel.completeAcceptSwipe(
                            maxDrag,
                          );
                        },
                        child: Container(
                          width: handleSize,
                          height: handleSize,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: AppColors.white,
                            size: AppSpacing.iconMD,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // =================================================
                  // RED REJECT HANDLE
                  // Starts RIGHT → moves LEFT
                  // =================================================

                  Positioned(
                    right: 0,
                    child: Transform.translate(
                      offset: Offset(
                        viewModel.rejectOffset,
                        0,
                      ),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragUpdate: (
                          details,
                        ) {
                          viewModel.updateRejectSwipe(
                            delta: details.delta.dx,
                            maxDrag: maxDrag,
                          );
                        },
                        onHorizontalDragEnd: (_) {
                          viewModel.completeRejectSwipe(
                            maxDrag,
                          );
                        },
                        child: Container(
                          width: handleSize,
                          height: handleSize,
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: AppColors.white,
                            size: AppSpacing.iconLG,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            AppSpacing.gapXS,

            Row(
              children: [
                Expanded(
                  child: Text(
                    'Swipe green → to accept',
                    textAlign: TextAlign.left,
                    style:
                        AppTextStyles.labelSmall.copyWith(
                      color:
                          AppColors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Swipe red ← to reject',
                    textAlign: TextAlign.right,
                    style:
                        AppTextStyles.labelSmall.copyWith(
                      color:
                          AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// =====================================================================
// TIMER
// =====================================================================

class _TimerSection extends StatelessWidget {
  final DeliveryRequestViewModel viewModel;

  const _TimerSection({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.timer_outlined,
              size:
                  AppSpacing.iconSM,
              color:
                  AppColors.error,
            ),

            AppSpacing.horizontalXS,

            Text(
              'RESPOND WITHIN ${viewModel.remainingSeconds} S',
              style:
                  AppTextStyles.labelLarge.copyWith(
                color:
                    AppColors.error,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),

        AppSpacing.gapSM,

        ClipRRect(
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusCircular,
          ),
          child: LinearProgressIndicator(
            value:
                viewModel.timerProgress,
            minHeight: 6,
            backgroundColor:
                AppColors.border,
            color:
                AppColors.primary,
          ),
        ),
      ],
    );
  }
}

