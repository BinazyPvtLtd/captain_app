import 'package:flutter/material.dart';

import '../model/kyc_document_model.dart';

class KycVerificationViewModel
    extends ChangeNotifier {
  // =========================================================
  // DOCUMENTS
  // =========================================================

  final List<KycDocumentModel> _documents = [
    KycDocumentModel(
      id: 'driving_licence',
      title: 'Driving Licence',
      icon: Icons.description_outlined,
      status: KycDocumentStatus.uploaded,
      fileName: 'driving_licence.jpg',
    ),
    KycDocumentModel(
      id: 'aadhaar',
      title: 'Aadhaar Card',
      icon: Icons.badge_outlined,
      status: KycDocumentStatus.uploaded,
      fileName: 'aadhaar_card.jpg',
    ),
    KycDocumentModel(
      id: 'pan',
      title: 'PAN Card',
      icon: Icons.credit_card_outlined,
    ),
    KycDocumentModel(
      id: 'driver_photo',
      title: 'Driver Photo',
      icon: Icons.person_outline_rounded,

      // For now photo can remain optional.
      isRequired: false,

      status: KycDocumentStatus.uploaded,
      fileName: 'driver_photo.jpg',
    ),
  ];

  List<KycDocumentModel> get documents =>
      List.unmodifiable(_documents);

  // =========================================================
  // LOADING
  // =========================================================

  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  String? _uploadingDocumentId;

  bool isUploading(
    String id,
  ) {
    return _uploadingDocumentId == id;
  }

  // =========================================================
  // PROGRESS
  // =========================================================

  int get uploadedCount =>
      _documents
          .where(
            (document) =>
                document.isUploaded,
          )
          .length;

  int get totalCount => _documents.length;

  double get progress {
    if (_documents.isEmpty) {
      return 0;
    }

    return uploadedCount /
        totalCount;
  }

  int get progressPercentage =>
      (progress * 100).round();

  // =========================================================
  // REQUIRED DOCUMENTS
  // =========================================================

  bool get areRequiredDocumentsUploaded {
    return _documents
        .where(
          (document) =>
              document.isRequired,
        )
        .every(
          (document) =>
              document.isUploaded,
        );
  }

  // =========================================================
  // UPLOAD DOCUMENT
  // =========================================================

  Future<void> uploadDocument(
    BuildContext context,
    KycDocumentModel document,
  ) async {
    if (_uploadingDocumentId != null) {
      return;
    }

    _uploadingDocumentId =
        document.id;

    notifyListeners();

    try {
      // =====================================================
      // TODO:
      //
      // Actual document picker will come here later.
      //
      // Driving Licence / Aadhaar / PAN:
      // FilePicker or ImagePicker
      //
      // Driver Photo:
      // ImagePicker camera/gallery
      //
      // Then upload selected file through repository/API.
      // =====================================================

      await Future.delayed(
        const Duration(
          milliseconds: 600,
        ),
      );

      document.status =
          KycDocumentStatus.uploaded;

      document.fileName =
          '${document.id}.jpg';
    } catch (_) {
      if (!context.mounted) {
        return;
      }

      _showMessage(
        context,
        'Unable to upload document.',
      );
    } finally {
      _uploadingDocumentId = null;

      notifyListeners();
    }
  }

  // =========================================================
  // REMOVE DOCUMENT
  // =========================================================

  void removeDocument(
    KycDocumentModel document,
  ) {
    document.status =
        KycDocumentStatus.pending;

    document.fileName = null;

    notifyListeners();
  }

  // =========================================================
  // SUBMIT
  // =========================================================

  Future<void> submitDocuments(
    BuildContext context, {
    required VoidCallback onSuccess,
  }) async {
    if (!areRequiredDocumentsUploaded) {
      _showMessage(
        context,
        'Please upload all required documents.',
      );

      return;
    }

    _setSubmitting(true);

    try {
      // =====================================================
      // TODO:
      // Submit KYC through repository/API.
      // =====================================================

      await Future.delayed(
        const Duration(
          milliseconds: 600,
        ),
      );

      _setSubmitting(false);

      onSuccess();
    } catch (_) {
      _setSubmitting(false);

      if (!context.mounted) {
        return;
      }

      _showMessage(
        context,
        'Unable to submit documents. Please try again.',
      );
    }
  }

  // =========================================================
  // SET SUBMITTING
  // =========================================================

  void _setSubmitting(
    bool value,
  ) {
    _isSubmitting = value;

    notifyListeners();
  }

  // =========================================================
  // MESSAGE
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
}