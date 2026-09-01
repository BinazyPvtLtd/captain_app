enum DriverDocumentStatus {
  approved,
  expiringSoon,
  pending,
  rejected,
}

class DriverDocumentModel {
  final String id;
  final String title;
  final DriverDocumentStatus status;
  final int? daysUntilExpiry;

  const DriverDocumentModel({
    required this.id,
    required this.title,
    required this.status,
    this.daysUntilExpiry,
  });
}