// import 'dart:async';
// import 'package:driver_app/features/auth/repository/auth_otp_repository.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class OtpViewModel extends ChangeNotifier {
//   final OtpAuthRepository _authRepository;

//   OtpViewModel({
//     required String verificationId,
//     OtpAuthRepository? authRepository,
//   })  : _verificationId = verificationId,
//         _authRepository = authRepository ?? OtpAuthRepository() {
//     _startResendTimer();
//   }

//   // =========================================================
//   // OTP
//   // =========================================================

//   String _otp = '';

//   String get otp => _otp;

//   bool get isOtpComplete => _otp.length == 6;

//   // =========================================================
//   // LOADING
//   // =========================================================

//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   // =========================================================
//   // VERIFICATION ID
//   // =========================================================

//   String? _verificationId;

//   String? get verificationId => _verificationId;

//   // =========================================================
//   // RESEND
//   // =========================================================

//   bool _canResend = false;

//   bool get canResend => _canResend;

//   int _resendSeconds = 30;

//   int get resendSeconds => _resendSeconds;

//   int? _resendToken;

//   Timer? _timer;

//   // =========================================================
//   // SET OTP
//   // =========================================================

//   void setOtp(String value) {
//     _otp = value;
//     notifyListeners();
//   }

//   // =========================================================
//   // VERIFY OTP
//   // =========================================================

//   Future<void> verifyOtp(
//     BuildContext context, {
//     required String phoneNumber,
//     required VoidCallback onSuccess,
//   }) async {
//     FocusScope.of(context).unfocus();

//     if (!isOtpComplete) {
//       _showMessage(
//         context,
//         'Please enter the complete 6-digit OTP.',
//       );
//       return;
//     }

//     if (_verificationId == null ||
//         _verificationId!.isEmpty) {
//       _showMessage(
//         context,
//         'Verification session expired. Please request a new OTP.',
//       );
//       return;
//     }

//     _setLoading(true);

//     try {
//       debugPrint('========================================');
//       debugPrint('🔐 DRIVER OTP VERIFICATION STARTED');
//       debugPrint('PHONE: $phoneNumber');
//       debugPrint('========================================');

//       final PhoneAuthCredential credential =
//           _authRepository.createPhoneCredential(
//         verificationId: _verificationId!,
//         smsCode: _otp,
//       );

//       final UserCredential userCredential =
//           await _authRepository.signInWithCredential(
//         credential,
//       );

//       debugPrint('========================================');
//       debugPrint('✅ DRIVER OTP VERIFIED');
//       debugPrint(
//         'UID: ${userCredential.user?.uid}',
//       );
//       debugPrint(
//         'PHONE: ${userCredential.user?.phoneNumber}',
//       );
//       debugPrint('========================================');

//       _setLoading(false);

//       if (!context.mounted) return;

//       onSuccess();
//     } on FirebaseAuthException catch (error) {
//       _setLoading(false);

//       debugPrint('========================================');
//       debugPrint('❌ OTP VERIFICATION FAILED');
//       debugPrint('CODE: ${error.code}');
//       debugPrint('MESSAGE: ${error.message}');
//       debugPrint('========================================');

//       if (!context.mounted) return;

//       _showMessage(
//         context,
//         _firebaseErrorMessage(error),
//       );
//     } catch (error) {
//       _setLoading(false);

//       debugPrint(
//         '❌ DRIVER OTP ERROR: $error',
//       );

//       if (!context.mounted) return;

//       _showMessage(
//         context,
//         'Something went wrong. Please try again.',
//       );
//     }
//   }

//   // =========================================================
//   // RESEND OTP
//   // =========================================================

//   Future<void> resendOtp(
//     BuildContext context, {
//     required String phoneNumber,

//   }) async {
//     if (!_canResend || _isLoading) {
//       return;
//     }

//     _setLoading(true);
//     _canResend = false;

//     try {
//       debugPrint('========================================');
//       debugPrint('🔄 DRIVER OTP RESEND STARTED');
//       debugPrint('PHONE: $phoneNumber');
//       debugPrint('========================================');

//       await _authRepository.sendOtp(
//         phoneNumber: phoneNumber,
//         forceResendingToken: _resendToken,

//         // ===================================================
//         // AUTO VERIFICATION
//         // ===================================================

//         verificationCompleted:
//             (PhoneAuthCredential credential) async {
//           try {
//             await _authRepository.signInWithCredential(
//               credential,
//             );

//             debugPrint(
//               '✅ DRIVER AUTO VERIFICATION SUCCESS',
//             );
//           } catch (error) {
//             debugPrint(
//               '❌ AUTO VERIFICATION ERROR: $error',
//             );
//           }

//           _setLoading(false);
//         },

//         // ===================================================
//         // VERIFICATION FAILED
//         // ===================================================

//         verificationFailed:
//             (FirebaseAuthException error) {
//           _isLoading = false;
//           _canResend = true;

//           notifyListeners();

//           if (!context.mounted) return;

//           _showMessage(
//             context,
//             _firebaseErrorMessage(error),
//           );
//         },

//         // ===================================================
//         // OTP SENT
//         // ===================================================

//         codeSent: (
//           String verificationId,
//           int? resendToken,
//         ) {
//           _verificationId = verificationId;
//           _resendToken = resendToken;

//           _isLoading = false;

//           _startResendTimer();

//           if (!context.mounted) return;

//           _showMessage(
//             context,
//             'A new OTP has been sent.',
//           );
//         },

//         // ===================================================
//         // TIMEOUT
//         // ===================================================

//         codeAutoRetrievalTimeout:
//             (String verificationId) {
//           _verificationId = verificationId;

//           debugPrint(
//             '⏱️ OTP AUTO RETRIEVAL TIMEOUT',
//           );
//         },
//       );
//     } on FirebaseAuthException catch (error) {
//       _isLoading = false;
//       _canResend = true;

//       notifyListeners();

//       if (!context.mounted) return;

//       _showMessage(
//         context,
//         _firebaseErrorMessage(error),
//       );
//     } catch (error) {
//       _isLoading = false;
//       _canResend = true;

//       notifyListeners();

//       debugPrint(
//         '❌ RESEND OTP ERROR: $error',
//       );

//       if (!context.mounted) return;

//       _showMessage(
//         context,
//         'Unable to resend OTP. Please try again.',
//       );
//     }
//   }

//   // =========================================================
//   // TIMER
//   // =========================================================

//   void _startResendTimer() {
//     _timer?.cancel();

//     _canResend = false;
//     _resendSeconds = 30;

//     notifyListeners();

//     _timer = Timer.periodic(
//       const Duration(seconds: 1),
//       (timer) {
//         if (_resendSeconds > 0) {
//           _resendSeconds--;

//           notifyListeners();
//         } else {
//           _canResend = true;

//           timer.cancel();

//           notifyListeners();
//         }
//       },
//     );
//   }

//   // =========================================================
//   // LOADING
//   // =========================================================

//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   // =========================================================
//   // FIREBASE ERROR
//   // =========================================================

//   String _firebaseErrorMessage(
//     FirebaseAuthException error,
//   ) {
//     switch (error.code) {
//       case 'invalid-verification-code':
//         return 'The OTP you entered is incorrect.';

//       case 'session-expired':
//         return 'The OTP has expired. Please request a new OTP.';

//       case 'invalid-verification-id':
//         return 'The verification session is invalid. Please request a new OTP.';

//       case 'too-many-requests':
//         return 'Too many attempts. Please try again later.';

//       case 'quota-exceeded':
//         return 'SMS quota exceeded. Please try again later.';

//       case 'invalid-phone-number':
//         return 'The phone number is invalid.';

//       case 'operation-not-allowed':
//         return 'Phone authentication is not enabled in Firebase.';

//       case 'network-request-failed':
//         return 'Please check your internet connection.';

//       default:
//         return error.message ??
//             'OTP verification failed.';
//     }
//   }

//   // =========================================================
//   // SHOW MESSAGE
//   // =========================================================

//   void _showMessage(
//     BuildContext context,
//     String message,
//   ) {
//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(
//           content: Text(message),
//         ),
//       );
//   }

//   // =========================================================
//   // DISPOSE
//   // =========================================================

//   @override
//   void dispose() {
//     _timer?.cancel();

//     super.dispose();
//   }
// }

import 'dart:async';

import 'package:driver_app/features/auth/repository/auth_otp_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpViewModel extends ChangeNotifier {
  final OtpAuthRepository _authRepository;

  OtpViewModel({
    required String verificationId,
    OtpAuthRepository? authRepository,
  }) : _verificationId = verificationId,
       _authRepository = authRepository ?? OtpAuthRepository() {
    _startResendTimer();
  }

  // =========================================================
  // OTP STATE
  // =========================================================

  String _otp = '';

  String get otp => _otp;

  bool get isOtpComplete => RegExp(r'^[0-9]{6}$').hasMatch(_otp);

  // =========================================================
  // LOADING STATE
  // =========================================================

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // =========================================================
  // VERIFICATION SESSION
  // =========================================================

  String? _verificationId;

  String? get verificationId => _verificationId;

  int? _resendToken;

  // Tracks the latest resend request.
  int _requestGeneration = 0;

  // Prevents duplicate navigation after sign-in.
  bool _hasCompletedSignIn = false;

  bool _isDisposed = false;

  // =========================================================
  // RESEND TIMER
  // =========================================================

  bool _canResend = false;

  bool get canResend => _canResend;

  int _resendSeconds = 30;

  int get resendSeconds => _resendSeconds;

  Timer? _timer;

  // =========================================================
  // SAFE NOTIFICATION
  // =========================================================

  void _notify() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    if (_isDisposed) return;

    _isLoading = value;
    _notify();
  }

  // =========================================================
  // SET OTP
  // =========================================================

  void setOtp(String value) {
    if (_isDisposed || _hasCompletedSignIn) return;

    _otp = value.trim();

    _notify();
  }

  // =========================================================
  // VERIFY OTP
  // =========================================================

  Future<void> verifyOtp(
    BuildContext context, {
    required String phoneNumber,
    required VoidCallback onSuccess,
  }) async {
    if (_isDisposed || _isLoading || _hasCompletedSignIn) {
      return;
    }

    FocusScope.of(context).unfocus();

    if (!isOtpComplete) {
      _showMessage(context, 'Please enter the complete 6-digit OTP.');
      return;
    }

    final currentVerificationId = _verificationId;

    if (currentVerificationId == null || currentVerificationId.isEmpty) {
      _showMessage(
        context,
        'Verification session is unavailable. Please request a new OTP.',
      );
      return;
    }

    final enteredOtp = _otp;

    _setLoading(true);

    try {
      debugPrint('========================================');
      debugPrint('DRIVER OTP VERIFICATION STARTED');
      debugPrint('PHONE: $phoneNumber');
      debugPrint('========================================');

      final PhoneAuthCredential credential = _authRepository
          .createPhoneCredential(
            verificationId: currentVerificationId,
            smsCode: enteredOtp,
          );

      final UserCredential userCredential = await _authRepository
          .signInWithCredential(credential);

      if (_isDisposed || _hasCompletedSignIn) return;

      debugPrint('========================================');
      debugPrint('DRIVER OTP VERIFIED');
      debugPrint('UID: ${userCredential.user?.uid}');
      debugPrint('========================================');

      _hasCompletedSignIn = true;

      _timer?.cancel();
      _setLoading(false);

      if (!context.mounted) return;

      onSuccess();
    } on FirebaseAuthException catch (error) {
      if (_isDisposed || _hasCompletedSignIn) return;

      _setLoading(false);

      debugPrint('========================================');
      debugPrint('OTP VERIFICATION FAILED');
      debugPrint('CODE: ${error.code}');
      debugPrint('MESSAGE: ${error.message}');
      debugPrint('========================================');

      if (!context.mounted) return;

      _showMessage(context, _firebaseErrorMessage(error));
    } catch (error) {
      if (_isDisposed || _hasCompletedSignIn) return;

      _setLoading(false);

      debugPrint('DRIVER OTP ERROR: $error');

      if (!context.mounted) return;

      _showMessage(context, 'Something went wrong. Please try again.');
    }
  }

  // =========================================================
  // RESEND OTP
  // =========================================================

  Future<void> resendOtp(
    BuildContext context, {
    required String phoneNumber,
    required VoidCallback onOtpSent,
    required VoidCallback onSuccess,
  }) async {
    if (_isDisposed || !_canResend || _isLoading || _hasCompletedSignIn) {
      return;
    }

    _setLoading(true);

    _canResend = false;
    _notify();

    final requestGeneration = ++_requestGeneration;

    bool isCurrentRequest() {
      return !_isDisposed &&
          !_hasCompletedSignIn &&
          requestGeneration == _requestGeneration;
    }

    try {
      debugPrint('========================================');
      debugPrint('DRIVER OTP RESEND STARTED');
      debugPrint('PHONE: $phoneNumber');
      debugPrint('========================================');

      await _authRepository.sendOtp(
        phoneNumber: phoneNumber,
        forceResendingToken: _resendToken,

        // =====================================================
        // AUTOMATIC VERIFICATION
        // =====================================================
        verificationCompleted: (PhoneAuthCredential credential) async {
          if (!isCurrentRequest()) return;

          try {
            final UserCredential userCredential = await _authRepository
                .signInWithCredential(credential);

            if (!isCurrentRequest()) return;

            debugPrint('DRIVER AUTO VERIFICATION SUCCESS');

            debugPrint('UID: ${userCredential.user?.uid}');

            _hasCompletedSignIn = true;
            _timer?.cancel();

            _setLoading(false);

            if (!context.mounted) return;

            onSuccess();
          } on FirebaseAuthException catch (error) {
            if (!isCurrentRequest()) return;

            debugPrint('AUTO VERIFICATION FAILED: ${error.code}');

            // Manual OTP entry can still succeed.
            _setLoading(false);
          } catch (error) {
            if (!isCurrentRequest()) return;

            debugPrint('AUTO VERIFICATION ERROR: $error');

            _setLoading(false);
          }
        },

        // =====================================================
        // VERIFICATION FAILED
        // =====================================================
        verificationFailed: (FirebaseAuthException error) {
          if (!isCurrentRequest()) return;

          debugPrint('========================================');
          debugPrint('OTP RESEND FAILED');
          debugPrint('CODE: ${error.code}');
          debugPrint('MESSAGE: ${error.message}');
          debugPrint('========================================');

          _canResend = true;
          _setLoading(false);

          if (!context.mounted) return;

          _showMessage(context, _firebaseErrorMessage(error));
        },

        // =====================================================
        // NEW OTP SENT
        // =====================================================
        codeSent: (String verificationId, int? resendToken) {
          if (!isCurrentRequest()) return;

          debugPrint('========================================');
          debugPrint('NEW OTP SENT SUCCESSFULLY');
          debugPrint('VERIFICATION ID UPDATED');
          debugPrint('========================================');

          // Always use the latest Firebase session.
          _verificationId = verificationId;
          _resendToken = resendToken;

          // Old OTP must not be reused.
          _otp = '';

          _startResendTimer();
          _setLoading(false);

          if (!context.mounted) return;

          // Clears all six OTP TextFields.
          onOtpSent();

          _showMessage(context, 'A new OTP has been sent.');
        },

        // =====================================================
        // AUTO RETRIEVAL TIMEOUT
        // =====================================================
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!isCurrentRequest()) return;

          // Timeout only stops automatic SMS retrieval.
          // It does not automatically invalidate manual OTP.
          if (_verificationId == null || _verificationId!.isEmpty) {
            _verificationId = verificationId;
          }

          debugPrint('OTP AUTO RETRIEVAL TIMEOUT');
        },
      );
    } on FirebaseAuthException catch (error) {
      if (!isCurrentRequest()) return;

      _canResend = true;
      _setLoading(false);

      debugPrint('RESEND OTP FIREBASE ERROR: ${error.code}');

      if (!context.mounted) return;

      _showMessage(context, _firebaseErrorMessage(error));
    } catch (error) {
      if (!isCurrentRequest()) return;

      _canResend = true;
      _setLoading(false);

      debugPrint('RESEND OTP ERROR: $error');

      if (!context.mounted) return;

      _showMessage(context, 'Unable to resend OTP. Please try again.');
    }
  }

  // =========================================================
  // RESEND TIMER
  // =========================================================

  void _startResendTimer() {
    _timer?.cancel();

    _canResend = false;
    _resendSeconds = 30;

    _notify();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isDisposed || _hasCompletedSignIn) {
        timer.cancel();
        return;
      }

      if (_resendSeconds > 1) {
        _resendSeconds--;
      } else {
        _resendSeconds = 0;
        _canResend = true;
        timer.cancel();
      }

      _notify();
    });
  }

  // =========================================================
  // FIREBASE ERROR MESSAGES
  // =========================================================

  String _firebaseErrorMessage(FirebaseAuthException error) {
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

      case 'app-not-authorized':
        return 'This app is not authorized for Firebase Phone Authentication.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'invalid-credential':
        return 'Verification failed. Please request a new OTP.';

      default:
        return error.message ?? 'OTP verification failed. Please try again.';
    }
  }

  // =========================================================
  // SHOW MESSAGE
  // =========================================================

  void _showMessage(BuildContext context, String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _isDisposed = true;
    _requestGeneration++;

    _timer?.cancel();

    super.dispose();
  }
}
