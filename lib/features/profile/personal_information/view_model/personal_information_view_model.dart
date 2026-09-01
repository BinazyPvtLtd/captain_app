import 'package:flutter/material.dart';

import '../model/personal_information_model.dart';

class PersonalInformationViewModel
    extends ChangeNotifier {
  PersonalInformationViewModel({
    PersonalInformationModel? profile,
  }) : _profile = profile ??
            const PersonalInformationModel(
              name: 'Rahul Kumar',
              mobile: '+91 98XXXXXX21',
              email: 'rahul@gmail.com',
              city: 'Lucknow',
              emergencyContact: '98XXXXXX47',
            );

  final PersonalInformationModel _profile;

  PersonalInformationModel get profile =>
      _profile;

  // =========================================================
  // EDIT PROFILE
  // =========================================================

  void editProfile({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }
}