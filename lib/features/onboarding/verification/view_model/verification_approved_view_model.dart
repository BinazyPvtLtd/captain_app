import 'package:flutter/material.dart';

class VerificationApprovedViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> startDriving({
    required VoidCallback onSuccess,
  }) async {
    if (_isLoading) {
      return;
    }

    _setLoading(true);

    try {
      // =====================================================
      // TODO:
      // Later:
      // - refresh driver profile
      // - save onboarding completed locally
      // - fetch driver online status
      // - navigate to main navigation
      // =====================================================

      await Future.delayed(
        const Duration(
          milliseconds: 400,
        ),
      );

      onSuccess();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(
    bool value,
  ) {
    _isLoading = value;

    notifyListeners();
  }
}