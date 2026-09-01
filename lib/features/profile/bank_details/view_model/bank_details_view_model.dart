import 'package:flutter/material.dart';

import '../model/bank_details_model.dart';

class BankDetailsViewModel extends ChangeNotifier {
  BankDetailsViewModel({
    BankDetailsModel? bankDetails,
  }) : _bankDetails = bankDetails ??
            const BankDetailsModel(
              accountHolderName: 'Patgolito Partner',
              bankName: 'Standard Chartered Bank',
              accountNumber: '**** **** **** 1234',
              ifscCode: 'SCBL0036001',
              isVerified: true,
            );

  final BankDetailsModel _bankDetails;

  BankDetailsModel get bankDetails =>
      _bankDetails;

  // =========================================================
  // UPDATE BANK
  // =========================================================

  void updateBankDetails({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }
}