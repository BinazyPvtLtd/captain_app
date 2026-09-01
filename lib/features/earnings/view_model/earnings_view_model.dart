import 'package:flutter/material.dart';

import '../model/earnings_model.dart';

class EarningsViewModel extends ChangeNotifier {
  // =========================================================
  // SELECTED PERIOD
  // =========================================================

  EarningsPeriod _selectedPeriod =
      EarningsPeriod.week;

  EarningsPeriod get selectedPeriod =>
      _selectedPeriod;

  // =========================================================
  // CURRENT PERIOD DATA
  // =========================================================

  String get currentTitle {
    switch (_selectedPeriod) {
      case EarningsPeriod.today:
        return 'Today';

      case EarningsPeriod.week:
        return 'This Week';

      case EarningsPeriod.month:
        return 'This Month';
    }
  }

  String get currentAmount {
    switch (_selectedPeriod) {
      case EarningsPeriod.today:
        return '₹1,240';

      case EarningsPeriod.week:
        return '₹8,450';

      case EarningsPeriod.month:
        return '₹31,680';
    }
  }

  String get comparisonText {
    switch (_selectedPeriod) {
      case EarningsPeriod.today:
        return '+8% vs yesterday';

      case EarningsPeriod.week:
        return '+12% vs last week';

      case EarningsPeriod.month:
        return '+10% vs last month';
    }
  }

  // =========================================================
  // SUMMARY
  // =========================================================

  final List<EarningsSummaryModel> summary =
      const [
    EarningsSummaryModel(
      label: 'Today',
      trips: 6,
      amount: '₹1,240',
    ),
    EarningsSummaryModel(
      label: 'Week',
      trips: 39,
      amount: '₹8,450',
    ),
    EarningsSummaryModel(
      label: 'Month',
      trips: 142,
      amount: '₹31,680',
    ),
  ];

  // =========================================================
  // HISTORY
  // =========================================================

  final List<EarningsHistoryModel> history =
      const [
    EarningsHistoryModel(
      date: '22 Aug',
      trips: 6,
      amount: '₹1,240',
    ),
    EarningsHistoryModel(
      date: '21 Aug',
      trips: 8,
      amount: '₹1,610',
    ),
    EarningsHistoryModel(
      date: '20 Aug',
      trips: 5,
      amount: '₹980',
    ),
  ];

  // =========================================================
  // SELECT PERIOD
  // =========================================================

  void selectPeriod(
    EarningsPeriod period,
  ) {
    if (_selectedPeriod == period) {
      return;
    }

    _selectedPeriod = period;

    notifyListeners();
  }

  // =========================================================
  // MENU
  // =========================================================

  void openMenu({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }
}