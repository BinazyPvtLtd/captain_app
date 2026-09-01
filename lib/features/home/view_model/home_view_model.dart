import 'dart:async';

import 'package:flutter/material.dart';

import '../model/home_stats_model.dart';
import '../model/recent_trip_model.dart';

class HomeViewModel extends ChangeNotifier {
  // =========================================================
  // DRIVER
  // =========================================================

  String _driverName = 'Rahul';

  String get driverName => _driverName;

  // =========================================================
  // ONLINE STATUS
  // =========================================================

  bool _isOnline = false;

  bool get isOnline => _isOnline;

  bool _isChangingStatus = false;

  bool get isChangingStatus => _isChangingStatus;

  // =========================================================
  // SEARCHING
  // =========================================================

  bool _isSearchingBooking = false;

  bool get isSearchingBooking =>
      _isSearchingBooking;

  Timer? _searchTimer;

  // =========================================================
  // STATS
  // =========================================================

  final List<HomeStatsModel> _stats = const [
    HomeStatsModel(
      value: '₹1,240',
      label: 'Earnings',
    ),
    HomeStatsModel(
      value: '6',
      label: 'Trips',
    ),
    HomeStatsModel(
      value: '42 km',
      label: 'Distance',
    ),
    HomeStatsModel(
      value: '4h 20m',
      label: 'Online Time',
    ),
  ];

  List<HomeStatsModel> get stats =>
      List.unmodifiable(_stats);

  // =========================================================
  // RECENT TRIP
  // =========================================================

   final RecentTripModel? _recentTrip =
      const RecentTripModel(
    pickup: 'Gomti Nagar',
    drop: 'Hazratganj',
    time: 'Today, 9:45 AM',
    earning: '₹180',
    status: 'COMPLETED',
  );

  RecentTripModel? get recentTrip =>
      _recentTrip;

  // =========================================================
  // GO ONLINE / OFFLINE
  // =========================================================

  Future<void> toggleOnlineStatus(
    BuildContext context, {
    VoidCallback? onBookingFound,
  }) async {
    if (_isChangingStatus) {
      return;
    }

    _setChangingStatus(true);

    try {
      await Future.delayed(
        const Duration(
          milliseconds: 400,
        ),
      );

      _isOnline = !_isOnline;

      if (_isOnline) {
        _startSearching(
          onBookingFound:
              onBookingFound,
        );
      } else {
        _stopSearching();
      }

      notifyListeners();
    } catch (_) {
      if (!context.mounted) {
        return;
      }

      _showMessage(
        context,
        'Unable to update your status.',
      );
    } finally {
      _setChangingStatus(false);
    }
  }

  void openMenu({
  required VoidCallback onPressed,
}) {
  onPressed();
}

// =========================================================
// NOTIFICATIONS
// =========================================================

void openNotifications({
  required VoidCallback onPressed,
}) {
  onPressed();
}

  // =========================================================
  // START SEARCHING
  // =========================================================

  void _startSearching({
    VoidCallback? onBookingFound,
  }) {
    _searchTimer?.cancel();

    _isSearchingBooking = true;

    notifyListeners();

    // =======================================================
    // TEMPORARY DEMO
    //
    // Later Socket/API will trigger this automatically.
    // =======================================================

    _searchTimer = Timer(
      const Duration(
        seconds: 8,
      ),
      () {
        if (!_isOnline) {
          return;
        }

        _isSearchingBooking = false;

        notifyListeners();

        onBookingFound?.call();
      },
    );
  }

  // =========================================================
  // STOP SEARCHING
  // =========================================================

  void _stopSearching() {
    _searchTimer?.cancel();

    _isSearchingBooking = false;

    notifyListeners();
  }

  // =========================================================
  // LOADING
  // =========================================================

  void _setChangingStatus(
    bool value,
  ) {
    _isChangingStatus = value;

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

  

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _searchTimer?.cancel();

    super.dispose();
  }
}