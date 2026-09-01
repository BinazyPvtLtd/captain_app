import 'package:firebase_auth/firebase_auth.dart';

class OtpAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // =========================================================
  // SEND / RESEND OTP
  // =========================================================

  Future<void> sendOtp({
    required String phoneNumber,
    required void Function(
      PhoneAuthCredential credential,
    ) verificationCompleted,
    required void Function(
      FirebaseAuthException error,
    ) verificationFailed,
    required void Function(
      String verificationId,
      int? resendToken,
    ) codeSent,
    required void Function(
      String verificationId,
    ) codeAutoRetrievalTimeout,
    int? forceResendingToken,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      forceResendingToken: forceResendingToken,
    );
  }

  // =========================================================
  // CREATE PHONE CREDENTIAL
  // =========================================================

  PhoneAuthCredential createPhoneCredential({
    required String verificationId,
    required String smsCode,
  }) {
    return PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  // =========================================================
  // SIGN IN WITH CREDENTIAL
  // =========================================================

  Future<UserCredential> signInWithCredential(
    PhoneAuthCredential credential,
  ) async {
    return _auth.signInWithCredential(
      credential,
    );
  }

  // =========================================================
  // CURRENT USER
  // =========================================================

  User? get currentUser => _auth.currentUser;

  // =========================================================
  // SIGN OUT
  // =========================================================

  Future<void> signOut() async {
    await _auth.signOut();
  }
}