enum EarningsPeriod {
  today,
  week,
  month,
}

class EarningsSummaryModel {
  final String label;
  final int trips;
  final String amount;

  const EarningsSummaryModel({
    required this.label,
    required this.trips,
    required this.amount,
  });
}

class EarningsHistoryModel {
  final String date;
  final int trips;
  final String amount;

  const EarningsHistoryModel({
    required this.date,
    required this.trips,
    required this.amount,
  });
}