enum TripStatus {
  completed,
  cancelled,
}

class TripHistoryModel {
  final String id;
  final String pickup;
  final String dropoff;
  final String time;
  final String amount;
  final String section;
  final TripStatus status;

  const TripHistoryModel({
    required this.id,
    required this.pickup,
    required this.dropoff,
    required this.time,
    required this.amount,
    required this.section,
    required this.status,
  });
}