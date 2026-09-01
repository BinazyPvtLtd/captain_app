import 'package:flutter/material.dart';

import '../model/emergency_category_model.dart';

class EmergencyHelpViewModel extends ChangeNotifier {
  // =========================================================
  // CATEGORIES
  // =========================================================

  final List<EmergencyCategoryModel> _categories = const [
    EmergencyCategoryModel(
      id: 'accident',
      title: 'Accident Report',
      icon: Icons.car_crash_outlined,
    ),
    EmergencyCategoryModel(
      id: 'breakdown',
      title: 'Vehicle Breakdown',
      icon: Icons.car_repair_outlined,
    ),
    EmergencyCategoryModel(
      id: 'safety',
      title: 'Safety Concern',
      icon: Icons.health_and_safety_outlined,
    ),
    EmergencyCategoryModel(
      id: 'customer',
      title: 'Customer Issue',
      icon: Icons.support_agent_outlined,
    ),
  ];

  List<EmergencyCategoryModel> get categories =>
      List.unmodifiable(_categories);

  // =========================================================
  // OPEN CATEGORY
  // =========================================================

  void openCategory({
    required EmergencyCategoryModel category,
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // SOS
  // =========================================================

  void triggerEmergencyCall({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // SUPPORT CALL
  // =========================================================

  void callSupport({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }
}