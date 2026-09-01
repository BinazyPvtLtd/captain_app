import 'package:driver_app/core/theme/app_colors.dart';
import 'package:driver_app/core/theme/app_spacing.dart';
import 'package:driver_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import '../model/support_category_model.dart';
import '../view_model/help_support_view_model.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HelpSupportViewModel(),
      child: const _HelpSupportView(),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _HelpSupportView extends StatelessWidget {
  const _HelpSupportView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            const _Header(),

            const Divider(
              height: 1,
              color: AppColors.divider,
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: Consumer<HelpSupportViewModel>(
                builder: (
                  context,
                  viewModel,
                  child,
                ) {
                  return ListView(
                    physics:
                        const BouncingScrollPhysics(),

                    padding:
                        const EdgeInsets.fromLTRB(
                      AppSpacing.screenHorizontal,
                      AppSpacing.lg,
                      AppSpacing.screenHorizontal,
                      AppSpacing.xl,
                    ),

                    children: [
                      // ===========================================
                      // SEARCH
                      // ===========================================

                      const _SupportSearchField(),

                      AppSpacing.gapXXL,

                      // ===========================================
                      // CATEGORIES TITLE
                      // ===========================================

                      Text(
                        'Support Categories',
                        style:
                            AppTextStyles.headingLarge
                                .copyWith(
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),

                      AppSpacing.gapLG,

                      // ===========================================
                      // CATEGORY GRID
                      // ===========================================

                      _SupportCategoryGrid(
                        categories:
                            viewModel.categories,
                      ),

                      AppSpacing.gapXXL,

                      const Divider(
                        height: 1,
                        color: AppColors.divider,
                      ),

                      AppSpacing.gapXXL,

                      // ===========================================
                      // CONTACT SUPPORT
                      // ===========================================

                      Text(
                        'Contact Support',
                        style:
                            AppTextStyles.headingLarge
                                .copyWith(
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),

                      AppSpacing.gapLG,

                      // ===========================================
                      // CHAT
                      // ===========================================

                      _SupportButton(
                        title:
                            'CHAT WITH SUPPORT',
                        icon:
                            Icons.chat_bubble_outline_rounded,
                        isPrimary:
                            true,
                        onPressed: () {
                          viewModel.chatSupport(
                            onPressed: () {
                              debugPrint(
                                'Chat with support',
                              );

                              // TODO:
                              // Open support chat
                            },
                          );
                        },
                      ),

                      AppSpacing.gapMD,

                      // ===========================================
                      // CALL
                      // ===========================================

                      _SupportButton(
                        title:
                            'CALL SUPPORT',
                        icon:
                            Icons.phone_outlined,
                        isPrimary:
                            false,
                        onPressed: () {
                          viewModel.callSupport(
                            onPressed: () {
                              debugPrint(
                                'Call support',
                              );

                              // TODO:
                              // url_launcher / tel:
                            },
                          );
                        },
                      ),

                      AppSpacing.gapXXL,

                      const Divider(
                        height: 1,
                        color: AppColors.divider,
                      ),

                      AppSpacing.gapXL,

                      // ===========================================
                      // LINKS
                      // ===========================================

                      _SupportLinkItem(
                        title:
                            'Frequently Asked Questions',
                        onTap: () {
                          viewModel.openSupportLink(
                            onPressed: () {
                              debugPrint(
                                'Open FAQ',
                              );
                            },
                          );
                        },
                      ),

                      _SupportLinkItem(
                        title:
                            'Terms & Conditions',
                        onTap: () {
                          viewModel.openSupportLink(
                            onPressed: () {
                              debugPrint(
                                'Open Terms & Conditions',
                              );
                            },
                          );
                        },
                      ),

                      _SupportLinkItem(
                        title:
                            'Privacy Policy',
                        onTap: () {
                          viewModel.openSupportLink(
                            onPressed: () {
                              debugPrint(
                                'Open Privacy Policy',
                              );
                            },
                          );
                        },
                      ),
                    ],
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

class _Header extends StatelessWidget {
  const _Header();

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
              'Help & Support',
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              style:
                  AppTextStyles.headingLarge
                      .copyWith(
                fontWeight:
                    FontWeight.w700,
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
// SEARCH FIELD
// =====================================================================

class _SupportSearchField
    extends StatelessWidget {
  const _SupportSearchField();

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.read<HelpSupportViewModel>();

    return TextField(
      controller:
          viewModel.searchController,

      onChanged:
          viewModel.onSearchChanged,

      textInputAction:
          TextInputAction.search,

      style:
          AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
      ),

      decoration: InputDecoration(
        hintText:
            'How can we help?',

        hintStyle:
            AppTextStyles.bodyLargeSecondary
                .copyWith(
          fontWeight: FontWeight.w400,
        ),

        prefixIcon: const Icon(
          Icons.search_rounded,
          size: AppSpacing.iconMD,
          color: AppColors.textSecondary,
        ),

        filled: true,

        fillColor:
            AppColors.background,

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal:
              AppSpacing.md,
          vertical:
              AppSpacing.md,
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusSM,
          ),
          borderSide:
              const BorderSide(
            color:
                AppColors.border,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusSM,
          ),
          borderSide:
              const BorderSide(
            color:
                AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SUPPORT GRID
// =====================================================================

class _SupportCategoryGrid
    extends StatelessWidget {
  final List<SupportCategoryModel>
      categories;

  const _SupportCategoryGrid({
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return Padding(
        padding:
            const EdgeInsets.symmetric(
          vertical:
              AppSpacing.xl,
        ),
        child: Center(
          child: Text(
            'No support category found.',
            style:
                AppTextStyles.bodyMediumSecondary,
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,

      physics:
          const NeverScrollableScrollPhysics(),

      itemCount:
          categories.length,

      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        crossAxisSpacing:
            AppSpacing.md,

        mainAxisSpacing:
            AppSpacing.md,

        childAspectRatio:
            1.45,
      ),

      itemBuilder: (
        context,
        index,
      ) {
        final category =
            categories[index];

        return _SupportCategoryCard(
          category: category,
        );
      },
    );
  }
}

// =====================================================================
// CATEGORY CARD
// =====================================================================

class _SupportCategoryCard
    extends StatelessWidget {
  final SupportCategoryModel category;

  const _SupportCategoryCard({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.read<HelpSupportViewModel>();

    return InkWell(
      onTap: () {
        viewModel.openCategory(
          category: category,

          onPressed: () {
            debugPrint(
              'Open ${category.title}',
            );

            // TODO:
            // Open category-specific support screen.
          },
        );
      },

      borderRadius:
          BorderRadius.circular(
        AppSpacing.radiusMD,
      ),

      child: Container(
        padding:
            const EdgeInsets.all(
          AppSpacing.md,
        ),

        decoration: BoxDecoration(
          color:
              AppColors.background,

          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusMD,
          ),

          border: Border.all(
            color:
                AppColors.border,
          ),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

          children: [
            Icon(
              category.icon,

              size:
                  AppSpacing.iconLG,

              color:
                  AppColors.textPrimary,
            ),

            Text(
              category.title,

              maxLines: 2,

              overflow:
                  TextOverflow.ellipsis,

              style:
                  AppTextStyles.titleMedium
                      .copyWith(
                fontWeight:
                    FontWeight.w600,
                color:
                    AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// SUPPORT BUTTON
// =====================================================================

class _SupportButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _SupportButton({
    required this.title,
    required this.icon,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          double.infinity,
      height: 56,

      child: isPrimary
          ? ElevatedButton.icon(
              onPressed:
                  onPressed,

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.primary,

                foregroundColor:
                    AppColors.white,

                elevation: 0,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusSM,
                  ),
                ),
              ),

              icon: Icon(
                icon,
                size:
                    AppSpacing.iconSM,
              ),

              label: Text(
                title,

                style:
                    AppTextStyles.titleMedium
                        .copyWith(
                  color:
                      AppColors.white,

                  fontWeight:
                      FontWeight.w600,

                  letterSpacing:
                      0.6,
                ),
              ),
            )
          : OutlinedButton.icon(
              onPressed:
                  onPressed,

              style:
                  OutlinedButton.styleFrom(
                foregroundColor:
                    AppColors.textPrimary,

                side:
                    const BorderSide(
                  color:
                      AppColors.primary,
                  width:
                      1.5,
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusSM,
                  ),
                ),
              ),

              icon: Icon(
                icon,
                size:
                    AppSpacing.iconSM,
              ),

              label: Text(
                title,

                style:
                    AppTextStyles.titleMedium
                        .copyWith(
                  fontWeight:
                      FontWeight.w600,

                  letterSpacing:
                      0.6,
                ),
              ),
            ),
    );
  }
}

// =====================================================================
// SUPPORT LINK ITEM
// =====================================================================

class _SupportLinkItem
    extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _SupportLinkItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          onTap,

      child: Container(
        height: 64,

        padding:
            const EdgeInsets.symmetric(
          vertical:
              AppSpacing.md,
        ),

        decoration:
            const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  AppColors.divider,
            ),
          ),
        ),

        child: Row(
          children: [
            Expanded(
              child: Text(
                title,

                style:
                    AppTextStyles.titleLarge
                        .copyWith(
                  color:
                      AppColors.textPrimary,

                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ),

            AppSpacing.horizontalSM,

            const Icon(
              Icons.chevron_right_rounded,

              size:
                  AppSpacing.iconMD,

              color:
                  AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}