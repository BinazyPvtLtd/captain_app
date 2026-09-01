import 'package:flutter/material.dart';

import '../model/vehicle_document_model.dart';

class VehicleDocumentsViewModel
    extends ChangeNotifier {
  // =========================================================
  // DOCUMENTS
  // =========================================================

  final List<VehicleDocumentModel> _documents = [
    VehicleDocumentModel(
      id: 'registration_certificate',
      title: 'Registration Certificate',
      icon: Icons.description_outlined,
    ),
    VehicleDocumentModel(
      id: 'insurance',
      title: 'Insurance',
      icon: Icons.shield_outlined,
    ),
    VehicleDocumentModel(
      id: 'pollution_certificate',
      title: 'Pollution Certificate',
      icon: Icons.air_rounded,
    ),
    VehicleDocumentModel(
      id: 'permit',
      title: 'Permit',
      icon: Icons.badge_outlined,
    ),
    VehicleDocumentModel(
      id: 'fitness_certificate',
      title: 'Fitness Certificate',
      icon: Icons.verified_outlined,
    ),
  ];

  List<VehicleDocumentModel> get documents =>
      List.unmodifiable(_documents);

  // =========================================================
  // LOADING
  // =========================================================

  String? _uploadingDocumentId;

  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  bool isUploading(
    String documentId,
  ) {
    return _uploadingDocumentId ==
        documentId;
  }

  // =========================================================
  // UPLOAD DOCUMENT
  // =========================================================

  Future<void> uploadDocument(
    BuildContext context,
    VehicleDocumentModel document,
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
      // Actual implementation:
      // 1. Open file/image picker
      // 2. Validate selected file
      // 3. Upload through repository/API
      // 4. Save returned URL / file info
      // =====================================================

      await Future.delayed(
        const Duration(
          milliseconds: 600,
        ),
      );

      document.status =
          VehicleDocumentStatus.uploaded;

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
  // REMOVE / REPLACE
  // =========================================================

  void removeDocument(
    VehicleDocumentModel document,
  ) {
    document.status =
        VehicleDocumentStatus.pending;

    document.fileName = null;

    notifyListeners();
  }

  // =========================================================
  // VALIDATION
  // =========================================================

  bool get allRequiredDocumentsUploaded {
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
  // SUBMIT VEHICLE
  // =========================================================

  Future<void> submitVehicle(
    BuildContext context, {
    required VoidCallback onSuccess,
  }) async {
    if (!allRequiredDocumentsUploaded) {
      _showMessage(
        context,
        'Please upload all required vehicle documents.',
      );

      return;
    }

    _setSubmitting(true);

    try {
      // =====================================================
      // TODO:
      // Submit vehicle documents through repository/API.
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
        'Unable to submit vehicle documents.',
      );
    }
  }

  // =========================================================
  // LOADING
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
          content: Text(
            message,
          ),
        ),
      );
  }
}