import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';

import '../model/recent_trip_model.dart';

class RecentTripCard extends StatelessWidget {
  final RecentTripModel trip;

  const RecentTripCard({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
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
                  '${trip.pickup} → ${trip.drop}',
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      AppTextStyles.titleLarge,
                ),
              ),

              AppSpacing.horizontalMD,

              Text(
                trip.earning,
                style:
                    AppTextStyles.headingLarge,
              ),
            ],
          ),

          AppSpacing.gapXS,

          Text(
            trip.time,
            style: AppTextStyles
                .bodyMediumSecondary,
          ),

          AppSpacing.gapMD,

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xxs,
            ),
            decoration: BoxDecoration(
              color:
                  AppColors.surfaceSecondary,
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusXS,
              ),
              border: Border.all(
                color: AppColors.border,
              ),
            ),
            child: Text(
              trip.status,
              style:
                  AppTextStyles.labelMedium
                      .copyWith(
                color:
                    AppColors.textPrimary,
                fontWeight:
                    FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}