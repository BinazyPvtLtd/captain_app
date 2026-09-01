import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';

import '../model/home_stats_model.dart';

class HomeStatsCard extends StatelessWidget {
  final HomeStatsModel stat;

  const HomeStatsCard({
    super.key,
    required this.stat,
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
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Text(
            stat.value,
            style:
                AppTextStyles.headingLarge,
          ),

          AppSpacing.gapXS,

          Text(
            stat.label,
            style: AppTextStyles
                .bodyMediumSecondary,
          ),
        ],
      ),
    );
  }
}