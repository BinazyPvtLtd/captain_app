import 'package:driver_app/features/earnings/view/earnings_screen.dart';
import 'package:driver_app/features/home/view/home_screen.dart';
import 'package:driver_app/features/profile/view/profile_screen.dart';
import 'package:driver_app/features/trips/view/trips_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/main_navigation_view_model.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({
    super.key,
  });

  static const List<Widget> _screens = [
    HomeScreen(),

   TripsScreen()
,
    EarningsScreen(),

    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainNavigationViewModel(),
      child: const _MainNavigationView(),
    );
  }
}

class _MainNavigationView extends StatelessWidget {
  const _MainNavigationView();

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavigationViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return Scaffold(
          body: IndexedStack(
            index: viewModel.selectedIndex,
            children: MainNavigationScreen._screens,
          ),

          bottomNavigationBar: NavigationBar(
            selectedIndex: viewModel.selectedIndex,

            onDestinationSelected: (
              index,
            ) {
              viewModel.changeTab(index);
            },

            destinations: const [
              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                ),
                selectedIcon: Icon(
                  Icons.home_rounded,
                ),
                label: 'Home',
              ),

              NavigationDestination(
                icon: Icon(
                  Icons.local_shipping_outlined,
                ),
                selectedIcon: Icon(
                  Icons.local_shipping_rounded,
                ),
                label: 'Trips',
              ),

              NavigationDestination(
                icon: Icon(
                  Icons.account_balance_wallet_outlined,
                ),
                selectedIcon: Icon(
                  Icons.account_balance_wallet_rounded,
                ),
                label: 'Earnings',
              ),

              NavigationDestination(
                icon: Icon(
                  Icons.person_outline_rounded,
                ),
                selectedIcon: Icon(
                  Icons.person_rounded,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}