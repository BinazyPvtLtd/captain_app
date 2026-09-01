import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/delivery_arrived_model.dart';

class DeliveryArrivedViewModel extends ChangeNotifier {
  final DeliveryArrivedModel _delivery;

  DeliveryArrivedViewModel({
    required DeliveryArrivedModel delivery,
  }) : _delivery = delivery;

  DeliveryArrivedModel get delivery => _delivery;

  // =========================================================
  // OTP
  // =========================================================

  static const int otpLength = 4;

  final List<TextEditingController> otpControllers =
      List.generate(
    otpLength,
    (_) => TextEditingController(),
  );

  final List<FocusNode> otpFocusNodes =
      List.generate(
    otpLength,
    (_) => FocusNode(),
  );

  bool _isVerifying = false;

  bool get isVerifying => _isVerifying;

  String get otp {
    return otpControllers
        .map(
          (controller) => controller.text,
        )
        .join();
  }

  bool get isOtpComplete =>
      otp.length == otpLength;

  // =========================================================
  // OTP CHANGED
  // =========================================================

  void onOtpChanged({
    required int index,
    required String value,
  }) {
    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        otpFocusNodes[index + 1]
            .requestFocus();
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

    if (otpControllers[index]
            .text
            .isEmpty &&
        index > 0) {
      otpFocusNodes[index - 1]
          .requestFocus();

      otpControllers[index - 1]
          .clear();

      notifyListeners();
    }
  }

  // =========================================================
  // VERIFY DELIVERY OTP
  // =========================================================

  Future<void> verifyDeliveryOtp(
    BuildContext context, {
    required VoidCallback onSuccess,
  }) async {
    FocusScope.of(context).unfocus();

    if (!isOtpComplete) {
      _showMessage(
        context,
        'Please enter the complete 4-digit delivery OTP.',
      );

      return;
    }

    _isVerifying = true;
    notifyListeners();

    try {
      // ================================================
      // BACKEND INTEGRATION LATER
      // ================================================
      //
      // await bookingRepository.verifyDeliveryOtp(
      //   bookingId: delivery.bookingId,
      //   otp: otp,
      // );
      //
      // ================================================

      await Future.delayed(
        const Duration(
          milliseconds: 600,
        ),
      );

      // Temporary for UI testing
      final bool verified = true;

      if (!verified) {
        if (!context.mounted) {
          return;
        }

        _showMessage(
          context,
          'Invalid delivery OTP.',
        );

        return;
      }

      if (!context.mounted) {
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
      _isVerifying = false;
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
  // HELP
  // =========================================================

  void openHelp({
    required VoidCallback onPressed,
  }) {
    onPressed();
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
    for (final controller
        in otpControllers) {
      controller.dispose();
    }

    for (final focusNode
        in otpFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }
}