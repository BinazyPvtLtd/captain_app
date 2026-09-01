import 'package:driver_app/features/auth/repository/auth_repository.dart';
import 'package:driver_app/features/auth/view/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  // =========================================================
  // PHONE CONTROLLER
  // =========================================================

  final TextEditingController phoneController =
      TextEditingController();

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
  // PHONE VALIDATION
  // =========================================================

  bool get isPhoneValid {
    final phone = phoneController.text.trim();

    return RegExp(
      r'^[0-9]{10}$',
    ).hasMatch(phone);
  }

  // =========================================================
  // PHONE CHANGED
  // =========================================================

  void onPhoneChanged(String value) {
    notifyListeners();
  }

  // =========================================================
  // CONTINUE LOGIN
  // =========================================================

  Future<void> continueLogin(
    BuildContext context,
  ) async {
    FocusScope.of(context).unfocus();

    final phone = phoneController.text.trim();

    // =========================================================
    // VALIDATION
    // =========================================================

    if (phone.isEmpty) {
      _showError(
        context,
        'Please enter your mobile number.',
      );
      return;
    }

    if (!isPhoneValid) {
      _showError(
        context,
        'Please enter a valid 10-digit mobile number.',
      );
      return;
    }

    _setLoading(true);

    final phoneNumber = '+91$phone';

    debugPrint('========================================');
    debugPrint('📱 FIREBASE OTP STARTED');
    debugPrint('PHONE: $phoneNumber');
    debugPrint('========================================');

    try {
      await _authRepository.sendOtp(
        phoneNumber: phoneNumber,

        // =====================================================
        // AUTOMATIC VERIFICATION
        // =====================================================

        verificationCompleted:
            (PhoneAuthCredential credential) async {
          debugPrint(
            '✅ PHONE VERIFICATION COMPLETED AUTOMATICALLY',
          );

          try {
            final userCredential =
                await _authRepository.signInWithCredential(
              credential,
            );

            debugPrint(
              '✅ USER SIGNED IN AUTOMATICALLY',
            );

            debugPrint(
              'UID: ${userCredential.user?.uid}',
            );
          } catch (e) {
            debugPrint(
              '❌ AUTO SIGN-IN ERROR: $e',
            );
          }
        },

        // =====================================================
        // VERIFICATION FAILED
        // =====================================================

        verificationFailed:
            (FirebaseAuthException error) {
          debugPrint('========================================');
          debugPrint('❌ FIREBASE OTP ERROR');
          debugPrint('CODE: ${error.code}');
          debugPrint('MESSAGE: ${error.message}');
          debugPrint('========================================');

          _setLoading(false);

          if (!context.mounted) return;

          _showError(
            context,
            _firebaseErrorMessage(error),
          );
        },

        // =====================================================
        // OTP SENT
        // =====================================================

        codeSent: (
          String verificationId,
          int? resendToken,
        ) {
          debugPrint('========================================');
          debugPrint('✅ OTP SMS SENT');
          debugPrint('VERIFICATION ID RECEIVED');
          debugPrint('========================================');

          _verificationId = verificationId;

          _setLoading(false);

          if (!context.mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpScreen(
                phoneNumber: phoneNumber,
                verificationId: verificationId,
              ),
            ),
          );
        },

        // =====================================================
        // AUTO RETRIEVAL TIMEOUT
        // =====================================================

        codeAutoRetrievalTimeout:
            (String verificationId) {
          debugPrint(
            '⏱️ AUTO RETRIEVAL TIMEOUT',
          );

          _verificationId = verificationId;
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(
        '❌ SEND OTP FIREBASE EXCEPTION',
      );

      debugPrint(
        'CODE: ${e.code}',
      );

      debugPrint(
        'MESSAGE: ${e.message}',
      );

      _setLoading(false);

      if (!context.mounted) return;

      _showError(
        context,
        _firebaseErrorMessage(e),
      );
    } catch (e) {
      debugPrint(
        '❌ SEND OTP EXCEPTION: $e',
      );

      _setLoading(false);

      if (!context.mounted) return;

      _showError(
        context,
        'Something went wrong. Please try again.',
      );
    }
  }

  // =========================================================
  // SET LOADING
  // =========================================================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // =========================================================
  // FIREBASE ERROR
  // =========================================================

  String _firebaseErrorMessage(
    FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'The phone number is invalid.';

      case 'too-many-requests':
        return 'Too many requests. Please try again later.';

      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later.';

      case 'operation-not-allowed':
        return 'Phone authentication is not enabled in Firebase.';

      case 'app-not-authorized':
        return 'This app is not authorized for Firebase Phone Authentication.';

      case 'captcha-check-failed':
        return 'Firebase verification failed. Please try again.';

      default:
        return e.message ?? 'Failed to send OTP.';
    }
  }

  // =========================================================
  // SHOW ERROR
  // =========================================================

  void _showError(
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
    phoneController.dispose();
    super.dispose();
  }
}