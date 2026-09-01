import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/pickup_task_model.dart';

class PickupTaskViewModel extends ChangeNotifier {
  final PickupTaskModel _task;

  PickupTaskViewModel({
    required PickupTaskModel task,
  }) : _task = task;

  PickupTaskModel get task => _task;

  // =========================================================
  // OTP
  // =========================================================

  static const int otpLength = 4;

  final List<TextEditingController> otpControllers =
      List.generate(
    otpLength,
    (_) => TextEditingController(),
  );

  final List<FocusNode> otpFocusNodes = List.generate(
    otpLength,
    (_) => FocusNode(),
  );

  // =========================================================
  // LOADING
  // =========================================================

  bool _isVerifying = false;

  bool get isVerifying => _isVerifying;

  // =========================================================
  // OTP VALUE
  // =========================================================

  String get otp {
    return otpControllers
        .map(
          (controller) => controller.text,
        )
        .join();
  }

  bool get isOtpComplete {
    return otp.length == otpLength;
  }

  // =========================================================
  // OTP CHANGED
  // =========================================================

  void onOtpChanged({
    required BuildContext context,
    required int index,
    required String value,
  }) {
    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        otpFocusNodes[index + 1].requestFocus();
      } else {
        otpFocusNodes[index].unfocus();
      }
    }

    notifyListeners();
  }

  // =========================================================
  // BACKSPACE
  // =========================================================

  void onOtpKeyEvent({
    required int index,
    required KeyEvent event,
  }) {
    if (event is! KeyDownEvent) {
      return;
    }

    if (event.logicalKey !=
        LogicalKeyboardKey.backspace) {
      return;
    }

    if (otpControllers[index].text.isEmpty &&
        index > 0) {
      otpFocusNodes[index - 1].requestFocus();

      otpControllers[index - 1].clear();

      notifyListeners();
    }
  }

  // =========================================================
  // CALL CUSTOMER
  // =========================================================

  void callCustomer({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // VERIFY OTP
  // =========================================================

  Future<void> verifyPickupOtp(
    BuildContext context, {
    required VoidCallback onSuccess,
  }) async {
    FocusScope.of(context).unfocus();

    if (!isOtpComplete) {
      _showMessage(
        context,
        'Please enter the complete 4-digit pickup OTP.',
      );

      return;
    }

    _setVerifying(true);

    try {
      // =====================================================
      // TODO:
      //
      // Backend integration:
      //
      // await bookingRepository.verifyPickupOtp(
      //   bookingId: _task.bookingId,
      //   otp: otp,
      // );
      //
      // =====================================================

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      // Temporary testing.
      // Later backend response decide karega.
      final bool verified = true;

      if (!verified) {
        if (!context.mounted) {
          return;
        }

        _showMessage(
          context,
          'Invalid pickup OTP.',
        );

        return;
      }

      onSuccess();
    } catch (_) {
      if (!context.mounted) {
        return;
      }

      _showMessage(
        context,
        'Unable to verify OTP. Please try again.',
      );
    } finally {
      _setVerifying(false);
    }
  }

  // =========================================================
  // LOADING
  // =========================================================

  void _setVerifying(
    bool value,
  ) {
    _isVerifying = value;

    notifyListeners();
  }

  // =========================================================
  // MESSAGE
  // =========================================================

  void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final focusNode in otpFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }
}