import 'dart:async';
import 'package:driver_app/features/auth/repository/auth_otp_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class OtpViewModel extends ChangeNotifier {
  final OtpAuthRepository _authRepository;

  OtpViewModel({
    required String verificationId,
    OtpAuthRepository? authRepository,
  })  : _verificationId = verificationId,
        _authRepository = authRepository ?? OtpAuthRepository() {
    _startResendTimer();
  }

  // =========================================================
  // OTP
  // =========================================================

  String _otp = '';

  String get otp => _otp;

  bool get isOtpComplete => _otp.length == 6;

  // =========================================================
  // LOADING
  // =========================================================

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // =========================================================
  // VERIFICATION ID
  // =========================================================

  String? _verificationId;

  String? get verificationId => _verificationId;

  // =========================================================
  // RESEND
  // =========================================================

  bool _canResend = false;

  bool get canResend => _canResend;

  int _resendSeconds = 30;

  int get resendSeconds => _resendSeconds;

  int? _resendToken;

  Timer? _timer;

  // =========================================================
  // SET OTP
  // =========================================================

  void setOtp(String value) {
    _otp = value;
    notifyListeners();
  }

  // =========================================================
  // VERIFY OTP
  // =========================================================

  Future<void> verifyOtp(
    BuildContext context, {
    required String phoneNumber,
    required VoidCallback onSuccess,
  }) async {
    FocusScope.of(context).unfocus();

    if (!isOtpComplete) {
      _showMessage(
        context,
        'Please enter the complete 6-digit OTP.',
      );
      return;
    }

    if (_verificationId == null ||
        _verificationId!.isEmpty) {
      _showMessage(
        context,
        'Verification session expired. Please request a new OTP.',
      );
      return;
    }

    _setLoading(true);

    try {
      debugPrint('========================================');
      debugPrint('🔐 DRIVER OTP VERIFICATION STARTED');
      debugPrint('PHONE: $phoneNumber');
      debugPrint('========================================');

      final PhoneAuthCredential credential =
          _authRepository.createPhoneCredential(
        verificationId: _verificationId!,
        smsCode: _otp,
      );

      final UserCredential userCredential =
          await _authRepository.signInWithCredential(
        credential,
      );

      debugPrint('========================================');
      debugPrint('✅ DRIVER OTP VERIFIED');
      debugPrint(
        'UID: ${userCredential.user?.uid}',
      );
      debugPrint(
        'PHONE: ${userCredential.user?.phoneNumber}',
      );
      debugPrint('========================================');

      _setLoading(false);

      if (!context.mounted) return;

      onSuccess();
    } on FirebaseAuthException catch (error) {
      _setLoading(false);

      debugPrint('========================================');
      debugPrint('❌ OTP VERIFICATION FAILED');
      debugPrint('CODE: ${error.code}');
      debugPrint('MESSAGE: ${error.message}');
      debugPrint('========================================');

      if (!context.mounted) return;

      _showMessage(
        context,
        _firebaseErrorMessage(error),
      );
    } catch (error) {
      _setLoading(false);

      debugPrint(
        '❌ DRIVER OTP ERROR: $error',
      );

      if (!context.mounted) return;

      _showMessage(
        context,
        'Something went wrong. Please try again.',
      );
    }
  }

  // =========================================================
  // RESEND OTP
  // =========================================================

  Future<void> resendOtp(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    if (!_canResend || _isLoading) {
      return;
    }

    _setLoading(true);
    _canResend = false;

    try {
      debugPrint('========================================');
      debugPrint('🔄 DRIVER OTP RESEND STARTED');
      debugPrint('PHONE: $phoneNumber');
      debugPrint('========================================');

      await _authRepository.sendOtp(
        phoneNumber: phoneNumber,
        forceResendingToken: _resendToken,

        // ===================================================
        // AUTO VERIFICATION
        // ===================================================

        verificationCompleted:
            (PhoneAuthCredential credential) async {
          try {
            await _authRepository.signInWithCredential(
              credential,
            );

            debugPrint(
              '✅ DRIVER AUTO VERIFICATION SUCCESS',
            );
          } catch (error) {
            debugPrint(
              '❌ AUTO VERIFICATION ERROR: $error',
            );
          }

          _setLoading(false);
        },

        // ===================================================
        // VERIFICATION FAILED
        // ===================================================

        verificationFailed:
            (FirebaseAuthException error) {
          _isLoading = false;
          _canResend = true;

          notifyListeners();

          if (!context.mounted) return;

          _showMessage(
            context,
            _firebaseErrorMessage(error),
          );
        },

        // ===================================================
        // OTP SENT
        // ===================================================

        codeSent: (
          String verificationId,
          int? resendToken,
        ) {
          _verificationId = verificationId;
          _resendToken = resendToken;

          _isLoading = false;

          _startResendTimer();

          if (!context.mounted) return;

          _showMessage(
            context,
            'A new OTP has been sent.',
          );
        },

        // ===================================================
        // TIMEOUT
        // ===================================================

        codeAutoRetrievalTimeout:
            (String verificationId) {
          _verificationId = verificationId;

          debugPrint(
            '⏱️ OTP AUTO RETRIEVAL TIMEOUT',
          );
        },
      );
    } on FirebaseAuthException catch (error) {
      _isLoading = false;
      _canResend = true;

      notifyListeners();

      if (!context.mounted) return;

      _showMessage(
        context,
        _firebaseErrorMessage(error),
      );
    } catch (error) {
      _isLoading = false;
      _canResend = true;

      notifyListeners();

      debugPrint(
        '❌ RESEND OTP ERROR: $error',
      );

      if (!context.mounted) return;

      _showMessage(
        context,
        'Unable to resend OTP. Please try again.',
      );
    }
  }

  // =========================================================
  // TIMER
  // =========================================================

  void _startResendTimer() {
    _timer?.cancel();

    _canResend = false;
    _resendSeconds = 30;

    notifyListeners();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_resendSeconds > 0) {
          _resendSeconds--;

          notifyListeners();
        } else {
          _canResend = true;

          timer.cancel();

          notifyListeners();
        }
      },
    );
  }

  // =========================================================
  // LOADING
  // =========================================================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // =========================================================
  // FIREBASE ERROR
  // =========================================================

  String _firebaseErrorMessage(
    FirebaseAuthException error,
  ) {
    switch (error.code) {
      case 'invalid-verification-code':
        return 'The OTP you entered is incorrect.';

      case 'session-expired':
        return 'The OTP has expired. Please request a new OTP.';

      case 'invalid-verification-id':
        return 'The verification session is invalid. Please request a new OTP.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later.';

      case 'invalid-phone-number':
        return 'The phone number is invalid.';

      case 'operation-not-allowed':
        return 'Phone authentication is not enabled in Firebase.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      default:
        return error.message ??
            'OTP verification failed.';
    }
  }

  // =========================================================
  // SHOW MESSAGE
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
    _timer?.cancel();

    super.dispose();
  }
}