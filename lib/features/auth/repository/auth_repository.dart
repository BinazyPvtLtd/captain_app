import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
  }) : _auth = firebaseAuth ?? FirebaseAuth.instance;

  // =========================================================
  // SEND OTP
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
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  // =========================================================
  // SIGN IN WITH CREDENTIAL
  // =========================================================

  Future<UserCredential> signInWithCredential(
    PhoneAuthCredential credential,
  ) {
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

  Future<void> signOut() {
    return _auth.signOut();
  }
}