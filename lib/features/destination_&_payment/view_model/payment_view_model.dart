import 'package:flutter/material.dart';

import '../model/payment_model.dart';

class PaymentViewModel extends ChangeNotifier {
  final PaymentModel _payment;

  PaymentViewModel({
    required PaymentModel payment,
  }) : _payment = payment;

  PaymentModel get payment => _payment;

  // =========================================================
  // SLIDE
  // =========================================================

  double _slideOffset = 0;

  double get slideOffset => _slideOffset;

  bool _isProcessing = false;

  bool get isProcessing => _isProcessing;

  // =========================================================
  // UPDATE SLIDE
  // =========================================================

  void updateSlide({
    required double delta,
    required double maxDrag,
  }) {
    if (_isProcessing) {
      return;
    }

    _slideOffset += delta;

    // Sirf left → right.
    _slideOffset = _slideOffset.clamp(
      0.0,
      maxDrag,
    );

    notifyListeners();
  }

  // =========================================================
  // COMPLETE SLIDE
  // =========================================================

  Future<void> completeSlide(
    BuildContext context, {
    required double maxDrag,
    required VoidCallback onSuccess,
  }) async {
    if (_isProcessing) {
      return;
    }

    final double threshold =
        maxDrag * 0.82;

    // Full swipe nahi hua.
    if (_slideOffset < threshold) {
      _slideOffset = 0;
      notifyListeners();
      return;
    }

    _setProcessing(true);

    try {
      // =====================================================
      // TODO:
      // Later backend/payment confirmation
      // =====================================================
      //
      // await paymentRepository.completePayment(
      //   bookingId: _payment.bookingId,
      // );

      await Future.delayed(
        const Duration(
          milliseconds: 450,
        ),
      );

      if (!context.mounted) {
        return;
      }

      onSuccess();
    } catch (_) {
      _slideOffset = 0;

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Unable to complete payment. Please try again.',
            ),
          ),
        );
    } finally {
      _setProcessing(false);
    }
  }

  // =========================================================
  // LOADING
  // =========================================================

  void _setProcessing(
    bool value,
  ) {
    _isProcessing = value;

    notifyListeners();
  }
}