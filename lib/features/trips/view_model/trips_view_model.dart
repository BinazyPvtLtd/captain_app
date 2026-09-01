import 'package:flutter/material.dart';

import '../model/trip_history_model.dart';

enum TripFilter {
  all,
  completed,
  cancelled,
}

class TripsViewModel extends ChangeNotifier {
  // =========================================================
  // FILTER
  // =========================================================

  TripFilter _selectedFilter = TripFilter.all;

  TripFilter get selectedFilter => _selectedFilter;

  // =========================================================
  // MOCK TRIPS
  // Later API se aayenge
  // =========================================================

  final List<TripHistoryModel> _trips = const [
    TripHistoryModel(
      id: 'PAT10285',
      pickup: 'Gomti Nagar',
      dropoff: 'Hazratganj',
      time: '10:42 AM',
      amount: '₹240',
      section: 'TODAY',
      status: TripStatus.completed,
    ),

    TripHistoryModel(
      id: 'PAT10284',
      pickup: 'Aliganj',
      dropoff: 'Indira Nagar',
      time: '09:15 AM',
      amount: '₹185',
      section: 'TODAY',
      status: TripStatus.completed,
    ),

    TripHistoryModel(
      id: 'PAT10283',
      pickup: 'Aminabad',
      dropoff: 'Gomti Nagar',
      time: '05:30 PM',
      amount: '₹210',
      section: 'YESTERDAY',
      status: TripStatus.cancelled,
    ),
  ];

  // =========================================================
  // FILTERED TRIPS
  // =========================================================

  List<TripHistoryModel> get filteredTrips {
    switch (_selectedFilter) {
      case TripFilter.completed:
        return _trips
            .where(
              (trip) =>
                  trip.status ==
                  TripStatus.completed,
            )
            .toList();

      case TripFilter.cancelled:
        return _trips
            .where(
              (trip) =>
                  trip.status ==
                  TripStatus.cancelled,
            )
            .toList();

      case TripFilter.all:
        return List.unmodifiable(_trips);
    }
  }

  // =========================================================
  // SECTIONS
  // =========================================================

  Map<String, List<TripHistoryModel>>
      get groupedTrips {
    final Map<
        String,
        List<TripHistoryModel>> grouped = {};

    for (final trip in filteredTrips) {
      grouped.putIfAbsent(
        trip.section,
        () => [],
      );

      grouped[trip.section]!.add(
        trip,
      );
    }

    return grouped;
  }

  // =========================================================
  // CHANGE FILTER
  // =========================================================

  void changeFilter(
    TripFilter filter,
  ) {
    if (_selectedFilter == filter) {
      return;
    }

    _selectedFilter = filter;

    notifyListeners();
  }

  // =========================================================
  // TRIP DETAILS
  // =========================================================

  void openTrip({
    required TripHistoryModel trip,
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // MENU
  // =========================================================

  void openMenu({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // NOTIFICATION
  // =========================================================

  
}