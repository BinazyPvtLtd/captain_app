import 'package:flutter/material.dart';

import '../model/driver_document_model.dart';

class DocumentsViewModel extends ChangeNotifier {
  // =========================================================
  // DOCUMENTS
  // =========================================================

  final List<DriverDocumentModel> _documents = const [
    DriverDocumentModel(
      id: 'driving_licence',
      title: 'Driving Licence',
      status: DriverDocumentStatus.approved,
    ),
    DriverDocumentModel(
      id: 'aadhaar',
      title: 'Aadhaar Card',
      status: DriverDocumentStatus.approved,
    ),
    DriverDocumentModel(
      id: 'pan',
      title: 'PAN Card',
      status: DriverDocumentStatus.approved,
    ),
    DriverDocumentModel(
      id: 'vehicle_rc',
      title: 'Vehicle RC',
      status: DriverDocumentStatus.approved,
    ),
    DriverDocumentModel(
      id: 'insurance',
      title: 'Insurance',
      status: DriverDocumentStatus.approved,
    ),
    DriverDocumentModel(
      id: 'pollution',
      title: 'Pollution Certificate',
      status: DriverDocumentStatus.expiringSoon,
      daysUntilExpiry: 18,
    ),
  ];

  List<DriverDocumentModel> get documents =>
      List.unmodifiable(_documents);

  // =========================================================
  // OPEN DOCUMENT
  // =========================================================

  void openDocument({
    required DriverDocumentModel document,
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // UPDATE DOCUMENT
  // =========================================================

  void updateDocument({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }
}