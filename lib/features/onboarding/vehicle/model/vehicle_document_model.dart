import 'package:flutter/material.dart';

enum VehicleDocumentStatus {
  pending,
  uploaded,
}

class VehicleDocumentModel {
  final String id;
  final String title;
  final IconData icon;
  final bool isRequired;

  VehicleDocumentStatus status;
  String? fileName;

  VehicleDocumentModel({
    required this.id,
    required this.title,
    required this.icon,
    this.isRequired = true,
    this.status = VehicleDocumentStatus.pending,
    this.fileName,
  });

  bool get isUploaded =>
      status == VehicleDocumentStatus.uploaded;
}