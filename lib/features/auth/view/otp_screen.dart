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
      create: (_) => OtpViewModel(
        verificationId: verificationId,
      ),
      child: _OtpView(
        phoneNumber: phoneNumber,
      ),
    );
  }
}

// =====================================================================
// OTP VIEW
// =====================================================================

class _OtpView extends StatefulWidget {
  final String phoneNumber;

  const _OtpView({
    required this.phoneNumber,
  });

  @override
  State<_OtpView> createState() =>
      _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  late final List<TextEditingController>
      _controllers;

  late final List<FocusNode>
      _focusNodes;

  late final List<FocusNode>
      _keyboardFocusNodes;

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      6,
      (_) => TextEditingController(),
    );

    _focusNodes = List.generate(
      6,
      (_) => FocusNode(),
    );

    _keyboardFocusNodes = List.generate(
      6,
      (_) => FocusNode(),
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    for (final focusNode
        in _keyboardFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  // =========================================================
  // OTP CHANGED
  // =========================================================

  void _onOtpChanged(
    String value,
    int index,
  ) {
    if (value.isNotEmpty &&
        index < 5) {
      _focusNodes[index + 1]
          .requestFocus();
    }

    _updateOtp();
  }

  // =========================================================
  // KEYBOARD BACKSPACE
  // =========================================================

  void _handleKeyEvent(
    int index,
    KeyEvent event,
  ) {
    if (event is! KeyDownEvent) {
      return;
    }

    if (event.logicalKey !=
        LogicalKeyboardKey.backspace) {
      return;
    }

    if (_controllers[index]
        .text
        .isNotEmpty) {
      return;
    }

    if (index <= 0) {
      return;
    }

    _controllers[index - 1]
        .clear();

    _focusNodes[index - 1]
        .requestFocus();

    _updateOtp();
  }

  // =========================================================
  // UPDATE OTP
  // =========================================================

  void _updateOtp() {
    final String otp = _controllers
        .map(
          (controller) =>
              controller.text,
        )
        .join();

    context
        .read<OtpViewModel>()
        .setOtp(
          otp,
        );
  }

  // =========================================================
  // VERIFY OTP
  // =========================================================

  void _verifyOtp() {
    final OtpViewModel viewModel =
        context.read<OtpViewModel>();

    viewModel.verifyOtp(
      context,
      phoneNumber:
          widget.phoneNumber,
      onSuccess:
          _handleOtpSuccess,
    );
  }

  // =========================================================
  // OTP SUCCESS
  // =========================================================

void _handleOtpSuccess() {
  if (!mounted) {
    return;
  }

  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (_) =>
          const CompleteProfileScreen(),
    ),
    (route) => false,
  );
}

  // =========================================================
  // RESEND OTP
  // =========================================================

  void _resendOtp() {
    context
        .read<OtpViewModel>()
        .resendOtp(
          context,
          phoneNumber:
              widget.phoneNumber,
        );
  }

  // =========================================================
  // CHANGE NUMBER
  // =========================================================

  void _changeNumber() {
    Navigator.of(context).pop();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          AppColors.background,
      resizeToAvoidBottomInset:
          true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (
            context,
            constraints,
          ) {
            return SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(
                horizontal:
                    AppSpacing.xxl,
                vertical:
                    AppSpacing.xl,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      constraints.maxHeight -
                          (AppSpacing.xl * 2),
                ),
                child: SizedBox(
                  width:
                      double.infinity,
                  child: Column(
                    children: [
                      // =======================================
                      // TOP SPACE
                      // =======================================

                      AppSpacing.gapXXXL,

                      // =======================================
                      // LOGO
                      // =======================================

                      _buildLogo(),

                      AppSpacing.gapXXS,

                      // =======================================
                      // TITLE
                      // =======================================

                      _buildTitle(),

                      AppSpacing.gapSM,

                      // =======================================
                      // SUBTITLE
                      // =======================================

                      _buildSubtitle(),

                      AppSpacing.gapXXXL,

                      // =======================================
                      // OTP FIELDS
                      // =======================================

                      _buildOtpFields(),

                      AppSpacing.gapXXXL,

                      // =======================================
                      // VERIFY
                      // =======================================

                      _buildVerifyButton(),

                      AppSpacing.gapXL,

                      // =======================================
                      // RESEND
                      // =======================================

                      _buildResend(),

                      AppSpacing.gapLG,

                      // =======================================
                      // CHANGE NUMBER
                      // =======================================

                      _buildChangeNumber(),

                      AppSpacing.gapXL,
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

  // =========================================================
  // LOGO
  // =========================================================

  Widget _buildLogo() {
    return SizedBox(
      width: 230,
      height: 150,
      child: Image.asset(
        AppAssets.patgolitoLogo1,
        fit: BoxFit.contain,
      ),
    );
  }

  // =========================================================
  // TITLE
  // =========================================================

  Widget _buildTitle() {
    return Text(
      'Verify your number',
      textAlign:
          TextAlign.center,
      style:
          AppTextStyles.loginTitle,
    );
  }

  // =========================================================
  // SUBTITLE
  // =========================================================

  Widget _buildSubtitle() {
    return RichText(
      textAlign:
          TextAlign.center,
      text: TextSpan(
        style:
            AppTextStyles.loginSubtitle,
        children: [
          const TextSpan(
            text:
                'Enter the 6-digit code sent to\n',
          ),
          TextSpan(
            text:
                widget.phoneNumber,
            style:
                AppTextStyles.countryCode,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // OTP FIELDS
  // =========================================================

  Widget _buildOtpFields() {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        const double spacing =
            AppSpacing.sm;

        final double availableWidth =
            constraints.maxWidth -
                (spacing * 5);

        final double fieldWidth =
            (availableWidth / 6)
                .clamp(
          42.0,
          58.0,
        );

        return Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
          children:
              List.generate(
            6,
            (index) {
              return _OtpField(
                index: index,
                width:
                    fieldWidth,
                controller:
                    _controllers[
                        index],
                focusNode:
                    _focusNodes[
                        index],
                keyboardFocusNode:
                    _keyboardFocusNodes[
                        index],
                onChanged:
                    _onOtpChanged,
                onKeyEvent:
                    _handleKeyEvent,
                onVerify:
                    _verifyOtp,
              );
            },
          ),
        );
      },
    );
  }

  // =========================================================
  // VERIFY BUTTON
  // =========================================================

  Widget _buildVerifyButton() {
    return Consumer<OtpViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return AppPrimaryButton(
          title:
              'Verify & Continue',
          height: 58,
          isLoading:
              viewModel.isLoading,
          isEnabled:
              !viewModel.isLoading,
          onPressed:
              _verifyOtp,
        );
      },
    );
  }

  // =========================================================
  // RESEND
  // =========================================================

  Widget _buildResend() {
    return Consumer<OtpViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return Wrap(
          alignment:
              WrapAlignment.center,
          crossAxisAlignment:
              WrapCrossAlignment.center,
          children: [
            Text(
              "Didn't receive the code? ",
              style:
                  AppTextStyles
                      .bodyMediumSecondary,
            ),

            GestureDetector(
              onTap:
                  viewModel.canResend &&
                          !viewModel
                              .isLoading
                      ? _resendOtp
                      : null,
              child: Text(
                viewModel.canResend
                    ? 'Resend OTP'
                    : 'Resend in ${viewModel.resendSeconds}s',
                style:
                    AppTextStyles
                        .labelLarge
                        .copyWith(
                  color:
                      viewModel.canResend
                          ? AppColors
                              .textPrimary
                          : AppColors
                              .textSecondary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // CHANGE NUMBER
  // =========================================================

  Widget _buildChangeNumber() {
    return GestureDetector(
      onTap:
          _changeNumber,
      behavior:
          HitTestBehavior.opaque,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          vertical:
              AppSpacing.sm,
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.edit_outlined,
              size:
                  AppSpacing.iconSM,
              color:
                  AppColors
                      .textSecondary,
            ),

            AppSpacing.horizontalSM,

            Text(
              'Change mobile number',
              style:
                  AppTextStyles
                      .labelLarge
                      .copyWith(
                color:
                    AppColors
                        .textSecondary,
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

class _OtpField extends StatelessWidget {
  final int index;
  final double width;

  final TextEditingController
      controller;

  final FocusNode focusNode;

  final FocusNode
      keyboardFocusNode;

  final void Function(
    String value,
    int index,
  ) onChanged;

  final void Function(
    int index,
    KeyEvent event,
  ) onKeyEvent;

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
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: width,
      height: 58,
      child: KeyboardListener(
        focusNode:
            keyboardFocusNode,
        onKeyEvent: (
          event,
        ) {
          onKeyEvent(
            index,
            event,
          );
        },
        child: TextField(
          controller:
              controller,
          focusNode:
              focusNode,
          keyboardType:
              TextInputType.number,
          textInputAction:
              index == 5
                  ? TextInputAction.done
                  : TextInputAction.next,
          textAlign:
              TextAlign.center,
          maxLength: 1,
          inputFormatters: [
            FilteringTextInputFormatter
                .digitsOnly,
            LengthLimitingTextInputFormatter(
              1,
            ),
          ],
          style:
              AppTextStyles
                  .headingMedium,
          cursorColor:
              AppColors.primary,
          decoration:
              InputDecoration(
            counterText: '',
            filled: true,
            fillColor:
                AppColors.white,
            contentPadding:
                EdgeInsets.zero,

            enabledBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusMD,
              ),
              borderSide:
                  const BorderSide(
                color:
                    AppColors.border,
                width: 1.2,
              ),
            ),

            focusedBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusMD,
              ),
              borderSide:
                  const BorderSide(
                color:
                    AppColors.primary,
                width: 1.8,
              ),
            ),

            border:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusMD,
              ),
              borderSide:
                  const BorderSide(
                color:
                    AppColors.border,
              ),
            ),
          ),
          onChanged: (
            value,
          ) {
            onChanged(
              value,
              index,
            );
          },
          onSubmitted: (_) {
            if (index == 5) {
              onVerify();
            }
          },
        ),
      ),
    );
  }
}