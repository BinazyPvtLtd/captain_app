import 'package:driver_app/core/constants/app_assets.dart';
import 'package:driver_app/features/onboarding/view/complete_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../view_model/otp_view_model.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtpViewModel(verificationId: verificationId),
      child: _OtpView(phoneNumber: phoneNumber),
    );
  }
}

class _OtpView extends StatefulWidget {
  final String phoneNumber;

  const _OtpView({required this.phoneNumber});

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  late final List<FocusNode> _keyboardFocusNodes;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(6, (_) => TextEditingController());

    _focusNodes = List.generate(6, (_) => FocusNode());

    _keyboardFocusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    for (final focusNode in _keyboardFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }

    _updateOtp();
  }

  void _handleKeyEvent(int index, KeyEvent event) {
    if (event is! KeyDownEvent) return;

    if (event.logicalKey != LogicalKeyboardKey.backspace) {
      return;
    }

    if (_controllers[index].text.isNotEmpty) {
      return;
    }

    if (index <= 0) return;

    _controllers[index - 1].clear();
    _focusNodes[index - 1].requestFocus();

    _updateOtp();
  }

  void _updateOtp() {
    final otp = _controllers.map((controller) => controller.text).join();

    context.read<OtpViewModel>().setOtp(otp);
  }

  void _verifyOtp() {
    final viewModel = context.read<OtpViewModel>();

    FocusScope.of(context).unfocus();

    viewModel.verifyOtp(
      context,
      phoneNumber: widget.phoneNumber,
      onSuccess: _handleOtpSuccess,
    );
  }

  void _handleOtpSuccess() {
    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const CompleteProfileScreen()),
      (route) => false,
    );
  }

  void _resendOtp() {
    context.read<OtpViewModel>().resendOtp(
      context,
      phoneNumber: widget.phoneNumber,
      onOtpSent: () {
        if (!mounted) return;

        for (final controller in _controllers) {
          controller.clear();
        }

        // Synchronize OTP state with cleared fields.
        context.read<OtpViewModel>().setOtp('');

        // Focus first OTP field.
        _focusNodes.first.requestFocus();
      },
      onSuccess: _handleOtpSuccess,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;

            // Same responsive strategy as login screen.
            final bool compactHeight = height < 700;
            final bool mediumHeight = height >= 700 && height < 820;

            final double horizontalPadding = width < 360
                ? AppSpacing.md
                : AppSpacing.screenHorizontal;

            final double logoHeight = compactHeight
                ? 92
                : mediumHeight
                ? 105
                : 115;

            final double topGap = compactHeight
                ? AppSpacing.lg
                : mediumHeight
                ? AppSpacing.xl
                : AppSpacing.xxl;

            final double largeGap = compactHeight
                ? AppSpacing.lg
                : mediumHeight
                ? AppSpacing.xl
                : AppSpacing.xxl;

            final double otpGap = width < 360 ? 6.0 : 8.0;

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: height),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(height: topGap),

                      // =========================
                      // LOGO
                      // =========================
                      SizedBox(
                        height: logoHeight,
                        width: double.infinity,
                        child: Image.asset(
                          AppAssets.patgolitoLogo1,
                          fit: BoxFit.contain,
                        ),
                      ),

                      SizedBox(
                        height: compactHeight ? AppSpacing.xs : AppSpacing.sm,
                      ),

                      // =========================
                      // TITLE
                      // =========================
                      Text(
                        'Verify your number',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: AppTextStyles.loginTitle,
                      ),

                      AppSpacing.gapXS,

                      // =========================
                      // SUBTITLE
                      // =========================
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 360),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppTextStyles.loginSubtitle,
                            children: [
                              const TextSpan(
                                text: 'Enter the 6-digit code sent to\n',
                              ),
                              TextSpan(
                                text: widget.phoneNumber,
                                style: AppTextStyles.countryCode,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: largeGap),

                      // =========================
                      // OTP
                      // =========================
                      _buildOtpFields(
                        availableWidth: width - (horizontalPadding * 2),
                        spacing: otpGap,
                      ),

                      SizedBox(height: largeGap),

                      // =========================
                      // VERIFY BUTTON
                      // =========================
                      _buildVerifyButton(),

                      SizedBox(
                        height: compactHeight ? AppSpacing.md : AppSpacing.lg,
                      ),

                      // =========================
                      // RESEND
                      // =========================
                      _buildResend(),

                      SizedBox(
                        height: compactHeight ? AppSpacing.sm : AppSpacing.md,
                      ),

                      // =========================
                      // CHANGE NUMBER
                      // =========================
                      _buildChangeNumber(),

                      // Fills remaining space without
                      // creating huge fixed gaps.
                      const Spacer(),

                      SizedBox(
                        height: compactHeight ? AppSpacing.sm : AppSpacing.lg,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOtpFields({
    required double availableWidth,
    required double spacing,
  }) {
    // Standard OTP sizing.
    // Normal phones: 50 x 56
    // Narrow phones: width automatically reduce hogi.

    const double preferredWidth = 44.0;
    const double minWidth = 38.0;

    final double requiredWidth = (preferredWidth * 6) + (spacing * 5);

    final double fieldWidth = requiredWidth <= availableWidth
        ? preferredWidth
        : ((availableWidth - (spacing * 5)) / 6).clamp(
            minWidth,
            preferredWidth,
          );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Padding(
          padding: EdgeInsets.only(right: index == 5 ? 0 : spacing),
          child: _OtpField(
            index: index,
            width: fieldWidth,
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardFocusNode: _keyboardFocusNodes[index],
            onChanged: _onOtpChanged,
            onKeyEvent: _handleKeyEvent,
            onVerify: _verifyOtp,
          ),
        );
      }),
    );
  }

  Widget _buildVerifyButton() {
    return Consumer<OtpViewModel>(
      builder: (context, viewModel, child) {
        return AppPrimaryButton(
          title: 'Verify & Continue',
          isLoading: viewModel.isLoading,
          isEnabled: viewModel.isOtpComplete && !viewModel.isLoading,
          onPressed: _verifyOtp,
        );
      },
    );
  }

  Widget _buildResend() {
    return Consumer<OtpViewModel>(
      builder: (context, viewModel, child) {
        return Wrap(
          alignment: WrapAlignment.center,

          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "Didn't receive the code? ",
              style: AppTextStyles.bodyMediumSecondary,
            ),
            GestureDetector(
              onTap: viewModel.canResend && !viewModel.isLoading
                  ? _resendOtp
                  : null,
              child: Text(
                viewModel.canResend
                    ? 'Resend OTP'
                    : 'Resend in ${viewModel.resendSeconds}s',
                style: AppTextStyles.labelLarge.copyWith(
                  color: viewModel.canResend
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // CHANGE MOBILE NUMBER
  // =========================================================

  void _changeNumber() {
    if (!mounted) return;

    Navigator.of(context).pop();
  }

  Widget _buildChangeNumber() {
    return GestureDetector(
      onTap: _changeNumber,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.edit_outlined,
              size: AppSpacing.iconSM,
              color: AppColors.textSecondary,
            ),
            AppSpacing.horizontalSM,
            Flexible(
              child: Text(
                'Change mobile number',
                textAlign: TextAlign.center,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textSecondary,
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
// SINGLE OTP FIELD
// =====================================================================

class _OtpField extends StatefulWidget {
  final int index;
  final double width;

  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode keyboardFocusNode;

  final void Function(String value, int index) onChanged;

  final void Function(int index, KeyEvent event) onKeyEvent;

  final VoidCallback onVerify;

  const _OtpField({
    required this.index,
    required this.width,
    required this.controller,
    required this.focusNode,
    required this.keyboardFocusNode,
    required this.onChanged,
    required this.onKeyEvent,
    required this.onVerify,
  });

  @override
  State<_OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<_OtpField> {
  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);

    super.dispose();
  }

  void _onFocusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocused = widget.focusNode.hasFocus;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),

      width: widget.width,
      height: 48,

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(
          color: isFocused ? AppColors.primary : AppColors.border,
          width: isFocused ? 1.5 : 1.0,
        ),
      ),

      alignment: Alignment.center,

      child: KeyboardListener(
        focusNode: widget.keyboardFocusNode,

        onKeyEvent: (event) {
          widget.onKeyEvent(widget.index, event);
        },

        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,

          keyboardType: TextInputType.number,

          textInputAction: widget.index == 5
              ? TextInputAction.done
              : TextInputAction.next,

          textAlign: TextAlign.center,

          textAlignVertical: TextAlignVertical.center,

          maxLength: 1,

          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],

          style: AppTextStyles.headingSmall.copyWith(fontSize: 18, height: 1.0),

          cursorColor: AppColors.primary,

          cursorHeight: 20,

          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            filled: false,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),

          onChanged: (value) {
            widget.onChanged(value, widget.index);
          },

          onSubmitted: (_) {
            if (widget.index == 5) {
              widget.onVerify();
            }
          },
        ),
      ),
    );
  }
}
