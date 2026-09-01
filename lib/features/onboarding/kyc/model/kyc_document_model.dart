import 'package:flutter/material.dart';

enum KycDocumentStatus {
  pending,
  uploaded,
}

class KycDocumentModel {
  final String id;
  final String title;
  final IconData icon;
  final bool isRequired;

  KycDocumentStatus status;
  String? fileName;

  KycDocumentModel({
    required this.id,
    required this.title,
    required this.icon,
    this.isRequired = true,
    this.status = KycDocumentStatus.pending,
    this.fileName,
  });

  bool get isUploaded =>
      status == KycDocumentStatus.uploaded;
}