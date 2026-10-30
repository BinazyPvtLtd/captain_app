import 'dart:convert';

import 'package:driver_app/features/onboarding/vehicle/services/captain_documents_service.dart';
import 'package:driver_app/features/onboarding/vehicle/services/document_storage_service.dart';
import 'package:flutter/material.dart';

import '../model/vehicle_document_model.dart';
import 'package:file_picker/file_picker.dart';

class VehicleDocumentsViewModel
    extends ChangeNotifier {


      final CaptainDocumentsService _documentsService =
    CaptainDocumentsService();

    final DocumentStorageService _storageService =
    DocumentStorageService();

bool _isLoadingDocuments = false;

bool get isLoadingDocuments => _isLoadingDocuments;

String? _documentsError;

String? get documentsError => _documentsError;

// static const Set<String> supportedDocumentTypes = {
//   'government_id',
//   'driving_licence',
//   'pan',
//   'profile_photo',
// };
  // =========================================================
  // DOCUMENTS
  // =========================================================

  final List<VehicleDocumentModel> _documents = [
    VehicleDocumentModel(
      id: 'vehicle_rc',
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

  // =========================================================
// DRIVER DOCUMENTS
// =========================================================

final List<VehicleDocumentModel> _driverDocuments = [
  VehicleDocumentModel(
  id: 'government_id',
  title: 'Aadhaar Card',
  icon: Icons.badge_outlined,
),
  VehicleDocumentModel(
  id: 'driving_licence',
  title: 'Driving Licence',
  icon: Icons.credit_card_outlined,
),
VehicleDocumentModel(
    id: 'pan',
    title: 'PAN Card',
    icon: Icons.credit_card_rounded,
  ),
  
  VehicleDocumentModel(
  id: 'profile_photo',
  title: 'Driver Profile Photo',
  icon: Icons.person_outline,
),

];

List<VehicleDocumentModel> get driverDocuments =>
    List.unmodifiable(_driverDocuments);

bool get areAllDocumentsUploaded {
  final allDocuments = [
    ...documents,
    ...driverDocuments,
  ];

  return allDocuments.isNotEmpty &&
      allDocuments.every((document) => document.isUploaded);
}

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
//   if (!supportedDocumentTypes.contains(document.id)) {
//   debugPrint(
//     'UPLOAD BLOCKED: Unsupported document type ${document.id}',
//   );

//   if (context.mounted) {
//     _showMessage(
//       context,
//       '${document.title} upload API is not available yet.',
//     );
//   }

//   return;
// }
  if (_uploadingDocumentId != null) return;

  _uploadingDocumentId = document.id;
  notifyListeners();

  try {
    // STEP 1: Select file
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf',
      ],
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    final file = result.files.first;

    if (file.path == null || file.path!.isEmpty) {
      throw Exception(
        'Unable to access selected file.',
      );
    }

    if (file.size > 10 * 1024 * 1024) {
      throw Exception(
        'Please select a file smaller than 10 MB.',
      );
    }

    // STEP 2: Multipart POST API
    final response = await _documentsService.uploadDocument(
      documentType: document.id,
      filePath: file.path!,
      fileName: file.name,
    );

    debugPrint(
      'UPLOAD RESPONSE (${document.id}): $response',
    );

    if (response is! Map || response['success'] != true) {
      throw Exception(
        response is Map
            ? response['message']?.toString() ??
                'Document upload failed.'
            : 'Document upload failed.',
      );
    }

    // STEP 3: Update UI after backend success
    document.fileName = file.name;
    document.filePath = null;
    document.status = VehicleDocumentStatus.uploaded;

    notifyListeners();

    if (context.mounted) {
      _showMessage(
        context,
        '${document.title} uploaded successfully.',
      );
    }

    // STEP 4: Refresh document statuses from backend
    await fetchCaptainDocuments();
  } catch (e) {
    debugPrint(
      'DOCUMENT UPLOAD ERROR (${document.id}): $e',
    );

    if (context.mounted) {
      _showMessage(
        context,
        'Unable to upload ${document.title}.',
      );
    }
  } finally {
    _uploadingDocumentId = null;
    notifyListeners();
  }
}

   // =========================================================
  // REMOVE / REPLACE
  // =========================================================

  void removeDocument(VehicleDocumentModel document) {
  document.status = VehicleDocumentStatus.pending;
  document.fileName = null;
  document.filePath = null;
  document.fileUrl = null;

  notifyListeners();
}

  // =========================================================
  // VALIDATION
  // =========================================================

  bool get allRequiredDocumentsUploaded {
  final allDocuments = [
    ..._documents,
    ..._driverDocuments,
  ];

  return allDocuments
      .where((document) => document.isRequired)
      .every((document) => document.isUploaded);
}

  // =========================================================
  // SUBMIT VEHICLE
  // =========================================================

  Future<void> submitVehicle(
  BuildContext context, {
  required VoidCallback onSuccess,
}) async {
  if (!areAllDocumentsUploaded) {
    _showMessage(
      context,
      'Please upload all required vehicle and driver documents.',
    );
    return;
  }

  _setSubmitting(true);

  try {
    await fetchCaptainDocuments();

    if (_documentsError != null) {
      throw Exception(_documentsError);
    }

    if (!areAllDocumentsUploaded) {
      throw Exception('Some documents are missing.');
    }

    if (!context.mounted) return;

    onSuccess();
  } catch (error) {
    if (context.mounted) {
      _showMessage(
        context,
        'Unable to verify documents. Please try again.',
      );
    }
  } finally {
    _setSubmitting(false);
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

  Future<void> fetchCaptainDocuments() async {
  if (_isLoadingDocuments) return;

  _isLoadingDocuments = true;
  _documentsError = null;
  notifyListeners();

  try {
    final response = await _documentsService.getDocuments();

    // Print complete GET API response
    debugPrint(
      '========== GET CAPTAIN DOCUMENTS API ==========',
    );

    const encoder = JsonEncoder.withIndent('  ');

    debugPrint(
      encoder.convert(response),
      wrapWidth: 1024,
    );

    debugPrint(
      '===============================================',
    );

    if (response is! Map || response['success'] != true) {
      throw Exception(
        'Unable to fetch captain documents.',
      );
    }

    final data = response['data'];

    if (data is! List) {
      throw Exception(
        'Invalid documents response.',
      );
    }

    final allDocuments = [
      ..._documents,
      ..._driverDocuments,
    ];

    for (final item in data) {
      if (item is! Map) continue;

      final documentType =
          item['document_type']?.toString();

      final verificationStatus =
          item['verification_status']?.toString();

      if (documentType == null) continue;

      for (final document in allDocuments) {
        if (document.id != documentType) continue;

        final isSubmitted = {
  'pending',
  'approved',
  'verified',
}.contains(verificationStatus);

        document.status = isSubmitted
            ? VehicleDocumentStatus.uploaded
            : VehicleDocumentStatus.pending;

        // Update filename only if backend returns it.
        final fileName = item['file_name']?.toString();

        if (fileName != null && fileName.isNotEmpty) {
          document.fileName = fileName;
        }

        // Update file URL only if backend returns it.
        final fileUrl = item['file_url']?.toString();

        if (fileUrl != null && fileUrl.isNotEmpty) {
          document.fileUrl = fileUrl;
        }

        debugPrint(
          'Document: $documentType | '
          'Status: $verificationStatus',
        );

        break;
      }
    }
  } catch (error) {
    _documentsError = error.toString();

    debugPrint(
      'GET CAPTAIN DOCUMENTS ERROR: $error',
    );
  } finally {
    _isLoadingDocuments = false;
    notifyListeners();
  }
}

// Future<bool> saveCaptainDocument({
//   required VehicleDocumentModel document,
//   required String fileUrl,
// }) async {
//   if (_uploadingDocumentId != null) return false;

//   _uploadingDocumentId = document.id;
//   notifyListeners();

//   try {
//     final response = await _documentsService.uploadDocument(
//   documentType: document.id,
//   fileUrl: fileUrl,
// );

// debugPrint('POST CAPTAIN DOCUMENT: $response');

//     debugPrint(
//       'POST DOCUMENT RESPONSE (${document.id}): $response',
//     );

//     if (response is Map && response['success'] == false) {
//       throw Exception(
//         response['message'] ?? 'Document save failed.',
//       );
//     }

//     document.fileUrl = fileUrl;
//     document.status = VehicleDocumentStatus.uploaded;

//     notifyListeners();
//     return true;
//   } catch (error) {
//     debugPrint(
//       'POST DOCUMENT ERROR (${document.id}): $error',
//     );

//     return false;
//   } finally {
//     _uploadingDocumentId = null;
//     notifyListeners();
//   }
// }
}