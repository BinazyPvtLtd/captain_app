import 'package:flutter/material.dart';

import '../model/verification_item_model.dart';

class VerificationStatusViewModel extends ChangeNotifier {
  // =========================================================
  // VERIFICATION ITEMS
  // =========================================================

  final List<VerificationItemModel> _items = const [
    VerificationItemModel(
      title: 'Identity',
      status: 'SUBMITTED',
    ),
    VerificationItemModel(
      title: 'Driving Licence',
      status: 'SUBMITTED',
    ),
    VerificationItemModel(
      title: 'Vehicle',
      status: 'SUBMITTED',
    ),
  ];

  List<VerificationItemModel> get items =>
      List.unmodifiable(_items);

  // =========================================================
  // VERIFICATION STATUS
  // =========================================================

  String get verificationStatus =>
      'UNDER REVIEW';

  bool get isUnderReview => true;

  // =========================================================
  // VIEW DOCUMENTS
  // =========================================================

  void viewDocuments({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }
}