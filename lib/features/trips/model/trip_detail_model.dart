class TripDetailModel {
  final String bookingId;
  final String date;
  final String time;
  final String status;

  final String pickup;
  final String dropoff;

  final String distance;
  final String duration;

  final String goodsType;
  final String vehicleType;

  final String fare;
  final String earning;

  const TripDetailModel({
    required this.bookingId,
    required this.date,
    required this.time,
    required this.status,
    required this.pickup,
    required this.dropoff,
    required this.distance,
    required this.duration,
    required this.goodsType,
    required this.vehicleType,
    required this.fare,
    required this.earning,
  });
}