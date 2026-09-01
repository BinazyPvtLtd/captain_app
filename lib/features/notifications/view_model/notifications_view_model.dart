import 'package:flutter/material.dart';

import '../model/notification_item_model.dart';

class NotificationsViewModel extends ChangeNotifier {
  final List<NotificationItemModel> _notifications = const [
    NotificationItemModel(
      id: '1',
      type: NotificationType.booking,
      category: 'NEW BOOKING',
      message: 'You have a delivery request nearby.',
      time: '2 min ago',
      isUnread: true,
    ),

    NotificationItemModel(
      id: '2',
      type: NotificationType.payment,
      category: 'PAYMENT',
      message: '₹1,240 has been added to your earnings.',
      time: '1 hour ago',
      isUnread: false,
    ),

    NotificationItemModel(
      id: '3',
      type: NotificationType.kyc,
      category: 'KYC UPDATE',
      message: 'Your Driving Licence has been approved.',
      time: 'Yesterday',
      isUnread: false,
    ),

    NotificationItemModel(
      id: '4',
      type: NotificationType.tripCompleted,
      category: 'TRIP COMPLETED',
      message: 'Booking #PAT10285 was completed.',
      time: 'Yesterday',
      isUnread: false,
    ),
  ];

  List<NotificationItemModel> get notifications =>
      List.unmodifiable(_notifications);

  void openNotification({
    required NotificationItemModel notification,
    required VoidCallback onPressed,
  }) {
    onPressed();
  }
}