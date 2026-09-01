import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_secondary_button.dart';

import '../view_model/home_view_model.dart';

class DriverStatusCard extends StatelessWidget {
  final VoidCallback? onBookingFound;

  const DriverStatusCard({
    super.key,
    this.onBookingFound,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 300,
          ),
          child: viewModel.isOnline
              ? _OnlineCard(
                  key: const ValueKey(
                    'online',
                  ),
                  viewModel:
                      viewModel,
                  onBookingFound:
                      onBookingFound,
                )
              : _OfflineCard(
                  key: const ValueKey(
                    'offline',
                  ),
                  viewModel:
                      viewModel,
                  onBookingFound:
                      onBookingFound,
                ),
        );
      },
    );
  }
}

class _OfflineCard extends StatelessWidget {
  final HomeViewModel viewModel;
  final VoidCallback? onBookingFound;

  const _OfflineCard({
    super.key,
    required this.viewModel,
    this.onBookingFound,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor:
          AppColors.surfaceSecondary,
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      radius: AppSpacing.radiusXL,
      child: Column(
        children: [
          Text(
            'YOU’RE OFFLINE',
            textAlign: TextAlign.center,
            style:
                AppTextStyles.headingLarge,
          ),

          AppSpacing.gapMD,

          Text(
            'Go online to start receiving bookings.',
            textAlign: TextAlign.center,
            style: AppTextStyles
                .bodyLargeSecondary,
          ),

          AppSpacing.gapXL,

          AppPrimaryButton(
            title: 'GO ONLINE',
            isLoading:
                viewModel.isChangingStatus,
            onPressed: () {
              viewModel.toggleOnlineStatus(
                context,
                onBookingFound:
                    onBookingFound,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _OnlineCard extends StatelessWidget {
  final HomeViewModel viewModel;
  final VoidCallback? onBookingFound;

  const _OnlineCard({
    super.key,
    required this.viewModel,
    this.onBookingFound,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor:
          AppColors.background,
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      radius: AppSpacing.radiusXL,
      child: Column(
        children: [
          // =====================================================
          // STATUS
          // =====================================================

          Text(
            'YOU’RE ONLINE',
            textAlign:
                TextAlign.center,
            style:
                AppTextStyles.headingMedium,
          ),

          AppSpacing.gapXXL,

          // =====================================================
          // SEARCHING BOX
          // =====================================================

          const _SearchingAnimationBox(),

          AppSpacing.gapXXL,

          // =====================================================
          // TITLE
          // =====================================================

          Text(
            'Finding nearby deliveries...',
            textAlign:
                TextAlign.center,
            style:
                AppTextStyles.headingLarge,
          ),

          AppSpacing.gapSM,

          // =====================================================
          // SUBTITLE
          // =====================================================

          ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxWidth: 330,
            ),
            child: Text(
              'Stay near your vehicle. We’ll notify you when a booking is available.',
              textAlign:
                  TextAlign.center,
              style: AppTextStyles
                  .bodyLargeSecondary,
            ),
          ),

          AppSpacing.gapXXL,

          // =====================================================
          // OFFLINE BUTTON
          // =====================================================

          AppSecondaryButton(
            title: 'GO OFFLINE',
            onPressed:
                viewModel.isChangingStatus
                    ? null
                    : () {
                        viewModel
                            .toggleOnlineStatus(
                          context,
                          onBookingFound:
                              onBookingFound,
                        );
                      },
          ),
        ],
      ),
    );
  }
}

class _SearchingAnimationBox
    extends StatefulWidget {
  const _SearchingAnimationBox();

  @override
  State<_SearchingAnimationBox>
      createState() =>
          _SearchingAnimationBoxState();
}

class _SearchingAnimationBoxState
    extends State<_SearchingAnimationBox>
    with
        SingleTickerProviderStateMixin {
  late final AnimationController
      _controller;

  late final Animation<double>
      _scaleAnimation;

  late final Animation<double>
      _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1300,
      ),
    );

    _scaleAnimation =
        Tween<double>(
      begin: 0.65,
      end: 1.25,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _fadeAnimation =
        Tween<double>(
      begin: 0.8,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        color:
            AppColors.surfaceSecondary,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusXL,
        ),
        border: Border.all(
          color:
              AppColors.primary,
          width: 1.5,
        ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation:
              _controller,
          builder: (
            context,
            child,
          ) {
            return Stack(
              alignment:
                  Alignment.center,
              children: [
                FadeTransition(
                  opacity:
                      _fadeAnimation,
                  child:
                      ScaleTransition(
                    scale:
                        _scaleAnimation,
                    child:
                        Container(
                      width: 86,
                      height: 86,
                      decoration:
                          BoxDecoration(
                        shape:
                            BoxShape.circle,
                        border:
                            Border.all(
                          color:
                              AppColors.primary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 64,
                  height: 64,
                  decoration:
                      const BoxDecoration(
                    shape:
                        BoxShape.circle,
                    color:
                        AppColors.primary,
                  ),
                  child:
                      const Icon(
                    Icons
                        .location_searching_rounded,
                    color:
                        AppColors.white,
                    size: 30,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}