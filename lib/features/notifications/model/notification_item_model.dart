enum NotificationType {
  booking,
  payment,
  kyc,
  tripCompleted,
}

class NotificationItemModel {
  final String id;
  final NotificationType type;
  final String category;
  final String message;
  final String time;
  final bool isUnread;

  const NotificationItemModel({
    required this.id,
    required this.type,
    required this.category,
    required this.message,
    required this.time,
    required this.isUnread,
  });
}