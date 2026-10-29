import 'package:driver_app/core/storage/onboarding_progress_storage.dart';
import 'package:driver_app/features/auth/services/captain_logout_service.dart';
import 'package:driver_app/features/auth/view/login_screen.dart';
import 'package:driver_app/features/onboarding/onboarding_steps.dart';
import 'package:driver_app/features/onboarding/vehicle/view/vehicle_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/vehicle_type_selection_view_model.dart';


class VehicleTypeSelectionScreen extends StatelessWidget {
  const VehicleTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          VehicleTypeSelectionViewModel()..fetchVehicleTypes(),
      child: const _VehicleTypeSelectionView(),
    );
  }
}

class _VehicleTypeSelectionView extends StatefulWidget {
  const _VehicleTypeSelectionView();

  @override
  State<_VehicleTypeSelectionView> createState() =>
      _VehicleTypeSelectionViewState();
}

class _VehicleTypeSelectionViewState
    extends State<_VehicleTypeSelectionView> {

  bool _isLoggingOut = false;

  Future<void> _handleLogout() async {
    if (_isLoggingOut) return;

    setState(() {
      _isLoggingOut = true;
    });

    try {
      debugPrint('========== VEHICLE SCREEN LOGOUT ==========');

      await CaptainLogoutService().logout();

      debugPrint('✅ Captain session cleared');

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
        (route) => false,
      );
    } catch (error) {
      debugPrint('Logout failed: ${error.runtimeType}');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout failed. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingOut = false;
        });
      }
    }
  }

  Future<void> _submit(BuildContext context) async {
  final viewModel = context.read<VehicleTypeSelectionViewModel>();

  final selectedVehicleId = viewModel.selectedVehicleId;

  if (selectedVehicleId == null) return;

  final selectedVehicle = viewModel.vehicles.firstWhere(
    (vehicle) => vehicle.id == selectedVehicleId,
  );

  final success = await viewModel.submitSelection();

  if (!context.mounted) return;

  if (success) {
  await OnboardingProgressStorage.saveVehicleType(
    id: selectedVehicle.id,
    name: selectedVehicle.name,
  );

  await OnboardingProgressStorage.saveScreen(
    OnboardingSteps.vehicleDetails,
  );

  if (!context.mounted) return;

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => VehicleDetailsScreen(
        vehicleTypeId: selectedVehicle.id,
        vehicleTypeName: selectedVehicle.name,
      ),
    ),
  );
}
  else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          viewModel.errorMessage ?? 'Unable to submit application',
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text('Select Vehicle Type'),
  actions: [
    IconButton(
      tooltip: 'Logout',
      onPressed: _isLoggingOut ||
        context.watch<VehicleTypeSelectionViewModel>().isSubmitting
    ? null
    : _handleLogout,
      icon: _isLoggingOut
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : const Icon(
              Icons.logout_rounded,
              color: Colors.red,
            ),
    ),
    const SizedBox(width: 8),
  ],
),

      body: Consumer<VehicleTypeSelectionViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (viewModel.errorMessage != null &&
              viewModel.vehicles.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(viewModel.errorMessage!),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: viewModel.fetchVehicleTypes,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.vehicles.isEmpty) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.directions_car_outlined,
          size: 60,
          color: Colors.grey,
        ),

        const SizedBox(height: 16),

        const Text(
          'No vehicle types available',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
  width: 230,
  height: 50,
  child: ElevatedButton.icon(
    onPressed: viewModel.fetchVehicleTypes,
    icon: const Icon(
      Icons.refresh,
      size: 20,
    ),
    label: const Text(
      'Retry',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
),
      ],
    ),
  );
}

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Select the vehicle you want to drive',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = viewModel.vehicles[index];

                    final selected =
                        viewModel.selectedVehicleId == vehicle.id;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: ListTile(
                        title: Text(vehicle.name),
                        leading: Icon(
                          selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                        ),
                        selected: selected,
                        onTap: viewModel.isSubmitting
                            ? null
                            : () {
                                viewModel.selectVehicle(vehicle.id);
                              },
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: viewModel.canSubmit
                        ? () => _submit(context)
                        : null,
                    child: viewModel.isSubmitting
                        ? const CircularProgressIndicator()
                        : const Text('Submit & Continue'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}