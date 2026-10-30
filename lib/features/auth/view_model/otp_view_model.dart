import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/storage/token_storage.dart';
import '../services/laravel_auth_service.dart';

class OtpViewModel extends ChangeNotifier {
  final LaravelAuthService _authService = LaravelAuthService();

  String _otp = '';
  bool _isLoading = false;
  bool _canResend = false;
  bool _hasCompletedSignIn = false;
  bool _isDisposed = false;

  int _resendSeconds = 30;

  Timer? _timer;

  OtpViewModel() {
    _startResendTimer();
  }

  // =========================================================
  // GETTERS
  // =========================================================

  String get otp => _otp;

  bool get isOtpComplete => _otp.length == 6;

  bool get isLoading => _isLoading;

  bool get canResend => _canResend;

  int get resendSeconds => _resendSeconds;

  // =========================================================
  // NOTIFY LISTENERS
  // =========================================================

  void _notify() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  // =========================================================
  // SET OTP
  // =========================================================

  void setOtp(String value) {
    if (_hasCompletedSignIn || _isDisposed) return;

    _otp = value.trim();
    _notify();
  }

  // =========================================================
  // VERIFY OTP API
  // =========================================================

  Future<void> verifyOtp(
    BuildContext context, {
    required String phoneNumber,
    required VoidCallback onSuccess,
  }) async {
    if (_isLoading || _hasCompletedSignIn || _isDisposed) {
      return;
    }

    if (!isOtpComplete) {
      _showMessage(
        context,
        'Enter the complete 6-digit OTP.',
      );
      return;
    }

    _isLoading = true;
    _notify();

    try {
      debugPrint('========== CAPTAIN VERIFY OTP ==========');

      // 1. Call Laravel Verify OTP API (only once).
      final response = await _authService.verifyOtp(
        phone: phoneNumber,
        otp: _otp,
      );

      // 2. Validate API response.
      if (response['success'] != true) {
        throw Exception(
          response['message'] ?? 'OTP verification failed',
        );
      }

      final data = response['data'];

      if (data is! Map) {
        throw Exception('Invalid authentication response');
      }

      // 3. Extract authentication token.
      final token = data['token'];

      if (token is! String || token.isEmpty) {
        throw Exception('Authentication token missing');
      }

      // 4. Save token securely.
      await TokenStorage.saveToken(token);

      debugPrint('✅ Captain App OTP verified successfully');
      debugPrint('✅ Authentication token saved');

      try {
  debugPrint('🔍 Fetching current user details...');

  await _authService.getCurrentUser();

  debugPrint('✅ Current user API completed');
} catch (error) {
  debugPrint(
    '❌ Current user API failed: ${error.runtimeType}',
  );
}


      // 5. Mark OTP verification complete.
      _hasCompletedSignIn = true;

      // Stop resend timer.
      _timer?.cancel();

      // 6. Navigate to Captain onboarding.
      if (context.mounted && !_isDisposed) {
        onSuccess();
      }
    } catch (error) {
      debugPrint(
        '❌ Captain OTP verification failed: ${error.runtimeType}',
      );

      if (context.mounted && !_isDisposed) {
        _showMessage(
          context,
          error.toString(),
        );
      }
    } finally {
      _isLoading = false;
      _notify();
    }
  }

  // =========================================================
  // RESEND OTP API
  // =========================================================

  Future<void> resendOtp(
    BuildContext context, {
    required String phoneNumber,
    required VoidCallback onOtpSent,
    required VoidCallback onSuccess,
  }) async {
    if (!_canResend || _isLoading || _isDisposed) {
      return;
    }

    _isLoading = true;
    _notify();

    try {
      debugPrint('========== CAPTAIN RESEND OTP ==========');

      final response = await _authService.sendOtp(
        phone: phoneNumber,
      );

      if (response['success'] != true) {
        throw Exception(
          response['message'] ?? 'Failed to resend OTP',
        );
      }

      // Clear old OTP.
      _otp = '';

      // Restart timer.
      _startResendTimer();

      if (context.mounted && !_isDisposed) {
        onOtpSent();

        _showMessage(
          context,
          'New OTP sent successfully.',
        );
      }

      debugPrint('✅ Captain OTP resent successfully');
    } catch (error) {
      debugPrint(
        '❌ Captain OTP resend failed: ${error.runtimeType}',
      );

      if (context.mounted && !_isDisposed) {
        _showMessage(
          context,
          error.toString(),
        );
      }
    } finally {
      _isLoading = false;
      _notify();
    }
  }

  // =========================================================
  // RESEND TIMER
  // =========================================================

  void _startResendTimer() {
    _timer?.cancel();

    _canResend = false;
    _resendSeconds = 30;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_isDisposed || _hasCompletedSignIn) {
          timer.cancel();
          return;
        }

        if (_resendSeconds > 0) {
          _resendSeconds--;
        } else {
          _canResend = true;
          timer.cancel();
        }

        _notify();
      },
    );

    _notify();
  }

  // =========================================================
  // SHOW MESSAGE
  // =========================================================

  void _showMessage(
    BuildContext context,
    String message,
  ) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
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
    _isDisposed = true;
    _timer?.cancel();

    super.dispose();
  }
}