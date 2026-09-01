import 'package:flutter/material.dart';

import '../model/support_category_model.dart';

class HelpSupportViewModel extends ChangeNotifier {
  // =========================================================
  // SEARCH
  // =========================================================

  final TextEditingController searchController =
      TextEditingController();

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  // =========================================================
  // SUPPORT CATEGORIES
  // =========================================================

  final List<SupportCategoryModel> _categories = const [
    SupportCategoryModel(
      id: 'trip',
      title: 'Trip Issues',
      icon: Icons.route_rounded,
    ),
    SupportCategoryModel(
      id: 'payment',
      title: 'Payment Issues',
      icon: Icons.payments_outlined,
    ),
    SupportCategoryModel(
      id: 'account',
      title: 'Account & KYC',
      icon: Icons.manage_accounts_outlined,
    ),
    SupportCategoryModel(
      id: 'vehicle',
      title: 'Vehicle Issues',
      icon: Icons.local_shipping_outlined,
    ),
    SupportCategoryModel(
      id: 'app',
      title: 'App Issues',
      icon: Icons.phone_android_rounded,
    ),
  ];

  List<SupportCategoryModel> get categories {
    if (_searchQuery.trim().isEmpty) {
      return List.unmodifiable(_categories);
    }

    final query = _searchQuery.toLowerCase();

    return _categories
        .where(
          (item) => item.title
              .toLowerCase()
              .contains(query),
        )
        .toList();
  }

  // =========================================================
  // SEARCH CHANGED
  // =========================================================

  void onSearchChanged(
    String value,
  ) {
    _searchQuery = value.trim();

    notifyListeners();
  }

  // =========================================================
  // OPEN CATEGORY
  // =========================================================

  void openCategory({
    required SupportCategoryModel category,
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // CHAT SUPPORT
  // =========================================================

  void chatSupport({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // CALL SUPPORT
  // =========================================================

  void callSupport({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // OPEN LINK
  // =========================================================

  void openSupportLink({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }
}