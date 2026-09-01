import 'package:driver_app/features/booking/model/pickup_navigation_model.dart';
import 'package:driver_app/features/booking/view/pickup_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_primary_button.dart';

import '../model/accepted_booking_model.dart';
import '../view_model/booking_accepted_view_model.dart';

class BookingAcceptedScreen extends StatelessWidget {
  final AcceptedBookingModel booking;

  const BookingAcceptedScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingAcceptedViewModel(
        booking: booking,
      ),
      child: const _BookingAcceptedView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _BookingAcceptedView extends StatelessWidget {
  const _BookingAcceptedView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // =========================================================
      // FIXED BOTTOM BUTTON
      // =========================================================

      bottomNavigationBar:
          const _NavigateToPickupSection(),

      body: SafeArea(
        child: Consumer<BookingAcceptedViewModel>(
          builder: (
            context,
            viewModel,
            child,
          ) {
            return SingleChildScrollView(
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
                children: [
                  // =============================================
                  // SUCCESS ICON
                  // =============================================

                  const _SuccessIcon(),

                  AppSpacing.gapXXL,

                  // =============================================
                  // TITLE
                  // =============================================

                  Text(
                    'Booking Accepted',
                    textAlign:
                        TextAlign.center,
                    style:
                        AppTextStyles.displaySmall,
                  ),

                  AppSpacing.gapXXXL,

                  // =============================================
                  // BOOKING CARD
                  // =============================================

                  _BookingDetailsCard(
                    booking:
                        viewModel.booking,
                  ),

                  AppSpacing.gapXXL,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// =====================================================================
// SUCCESS ICON
// =====================================================================

class _SuccessIcon extends StatelessWidget {
  const _SuccessIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusXL,
        ),
      ),
      child: const Icon(
        Icons.check_rounded,
        size: 54,
        color: AppColors.white,
      ),
    );
  }
}

// =====================================================================
// BOOKING DETAILS CARD
// =====================================================================

class _BookingDetailsCard
    extends StatelessWidget {
  final AcceptedBookingModel booking;

  const _BookingDetailsCard({
    required this.booking,
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // =====================================================
          // PICKUP
          // =====================================================

          Text(
            'PICKUP',
            style:
                AppTextStyles.labelLarge.copyWith(
              color:
                  AppColors.textSecondary,
              letterSpacing: 1.4,
            ),
          ),

          AppSpacing.gapSM,

          Text(
            booking.pickup,
            style:
                AppTextStyles.headingLarge,
          ),

          AppSpacing.gapSM,

          Row(
            children: [
              const Icon(
                Icons.navigation_outlined,
                size:
                    AppSpacing.iconSM,
                color:
                    AppColors.textSecondary,
              ),

              AppSpacing.horizontalSM,

              Text(
                booking.pickupDistance,
                style:
                    AppTextStyles.bodyLargeSecondary,
              ),
            ],
          ),

          AppSpacing.gapXL,

          const Divider(
            height: 1,
          ),

          AppSpacing.gapXL,

          // =====================================================
          // CUSTOMER
          // =====================================================

          Row(
            children: [
              // =================================================
              // AVATAR
              // =================================================

              _CustomerAvatar(
                image:
                    booking.customerImage,
                name:
                    booking.customerName,
              ),

              AppSpacing.horizontalMD,

              // =================================================
              // NAME / ID
              // =================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.customerName,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style:
                          AppTextStyles.headingMedium,
                    ),

                    AppSpacing.gapXS,

                    Text(
                      booking.customerId,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style:
                          AppTextStyles.bodyMediumSecondary,
                    ),
                  ],
                ),
              ),

              AppSpacing.horizontalMD,

              // =================================================
              // MESSAGE
              // =================================================

              _CustomerActionButton(
                icon:
                    Icons.chat_bubble_outline_rounded,
                filled: false,
                onPressed: () {
                  context
                      .read<
                          BookingAcceptedViewModel>()
                      .messageCustomer(
                    onPressed: () {
                      debugPrint(
                        'Open customer chat',
                      );
                    },
                  );
                },
              ),

              AppSpacing.horizontalSM,

              // =================================================
              // CALL
              // =================================================

              _CustomerActionButton(
                icon:
                    Icons.phone_outlined,
                filled: true,
                onPressed: () {
                  context
                      .read<
                          BookingAcceptedViewModel>()
                      .callCustomer(
                    onPressed: () {
                      debugPrint(
                        'Call customer',
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// CUSTOMER AVATAR
// =====================================================================

class _CustomerAvatar extends StatelessWidget {
  final String? image;
  final String name;

  const _CustomerAvatar({
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 58;

    if (image != null &&
        image!.isNotEmpty) {
      return ClipRRect(
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusLG,
        ),
        child: Image.network(
          image!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            return _AvatarFallback(
              name: name,
            );
          },
        ),
      );
    }

    return _AvatarFallback(
      name: name,
    );
  }
}

// =====================================================================
// AVATAR FALLBACK
// =====================================================================

class _AvatarFallback
    extends StatelessWidget {
  final String name;

  const _AvatarFallback({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final String initial =
        name.trim().isEmpty
            ? '?'
            : name
                .trim()
                .substring(0, 1)
                .toUpperCase();

    return Container(
      width: 58,
      height: 58,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color:
            AppColors.surfaceSecondary,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusLG,
        ),
        border: Border.all(
          color:
              AppColors.border,
        ),
      ),
      child: Text(
        initial,
        style:
            AppTextStyles.headingMedium,
      ),
    );
  }
}

// =====================================================================
// CUSTOMER ACTION BUTTON
// =====================================================================

class _CustomerActionButton
    extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final VoidCallback onPressed;

  const _CustomerActionButton({
    required this.icon,
    required this.filled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Material(
        color: filled
            ? AppColors.primary
            : AppColors.background,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusMD,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusMD,
          ),
          child: Container(
            alignment:
                Alignment.center,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusMD,
              ),
              border: filled
                  ? null
                  : Border.all(
                      color:
                          AppColors.primary,
                    ),
            ),
            child: Icon(
              icon,
              size:
                  AppSpacing.iconMD,
              color: filled
                  ? AppColors.white
                  : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// BOTTOM NAVIGATE BUTTON
// =====================================================================

class _NavigateToPickupSection
    extends StatelessWidget {
  const _NavigateToPickupSection();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding:
            const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.md,
          AppSpacing.xl,
          AppSpacing.md,
        ),
        decoration:
            const BoxDecoration(
          color:
              AppColors.background,
          border: Border(
            top: BorderSide(
              color:
                  AppColors.divider,
            ),
          ),
        ),
        child: AppPrimaryButton(
          title:
              'NAVIGATE TO PICKUP',
          icon:
              Icons.navigation_outlined,
          onPressed: () {
  final booking = context
      .read<BookingAcceptedViewModel>()
      .booking;

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) =>
          PickupNavigationScreen(
        booking:
            PickupNavigationModel(
          bookingId:
              booking.bookingId,

          eta:
              '8 MIN',

          distance:
              booking.pickupDistance
                  .replaceAll(
                ' away',
                '',
              ),

          pickupAddress:
              '${booking.pickup}, Lucknow',

          customerName:
              booking.customerName,
        ),
      ),
    ),
  );
},
        ),
      ),
    );
  }
}