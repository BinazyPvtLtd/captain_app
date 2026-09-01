import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileViewModel extends ChangeNotifier {
  // =========================================================
  // CONTROLLERS
  // =========================================================

  final TextEditingController fullNameController =
      TextEditingController();

  final TextEditingController dateOfBirthController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController cityController =
      TextEditingController();

  // =========================================================
  // IMAGE
  // =========================================================

  final ImagePicker _imagePicker = ImagePicker();

  File? _profileImage;

  File? get profileImage => _profileImage;

  // =========================================================
  // GENDER
  // =========================================================

  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  static const List<String> genders = [
    'Male',
    'Female',
    'Other',
  ];

  // =========================================================
  // LOADING
  // =========================================================

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // =========================================================
  // PICK PROFILE IMAGE
  // =========================================================

  Future<void> pickProfileImage() async {
    final XFile? image =
        await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) {
      return;
    }

    _profileImage = File(
      image.path,
    );

    notifyListeners();
  }

  // =========================================================
  // SELECT DATE OF BIRTH
  // =========================================================

  Future<void> selectDateOfBirth(
    BuildContext context,
  ) async {
    final DateTime now =
        DateTime.now();

    final DateTime? selectedDate =
        await showDatePicker(
      context: context,
      initialDate: DateTime(
        now.year - 18,
      ),
      firstDate: DateTime(
        1950,
      ),
      lastDate: DateTime(
        now.year - 18,
        now.month,
        now.day,
      ),
    );

    if (selectedDate == null) {
      return;
    }

    dateOfBirthController.text =
        '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';

    notifyListeners();
  }

  // =========================================================
  // SELECT GENDER
  // =========================================================

  void selectGender(
    String? value,
  ) {
    _selectedGender = value;

    notifyListeners();
  }

  // =========================================================
  // VALIDATION
  // =========================================================

  bool validate(
    BuildContext context,
  ) {
    final String fullName =
        fullNameController.text.trim();

    final String dob =
        dateOfBirthController.text.trim();

    final String email =
        emailController.text.trim();

    final String city =
        cityController.text.trim();

    // if (_profileImage == null) {
    //   _showMessage(
    //     context,
    //     'Please add your profile photo.',
    //   );

    //   return false;
    // }

    if (fullName.isEmpty) {
      _showMessage(
        context,
        'Please enter your full name.',
      );

      return false;
    }

    if (dob.isEmpty) {
      _showMessage(
        context,
        'Please select your date of birth.',
      );

      return false;
    }

    if (_selectedGender == null) {
      _showMessage(
        context,
        'Please select your gender.',
      );

      return false;
    }

    if (email.isEmpty) {
      _showMessage(
        context,
        'Please enter your email address.',
      );

      return false;
    }

    if (!_isValidEmail(email)) {
      _showMessage(
        context,
        'Please enter a valid email address.',
      );

      return false;
    }

    if (city.isEmpty) {
      _showMessage(
        context,
        'Please enter your city.',
      );

      return false;
    }

    return true;
  }

  bool _isValidEmail(
    String email,
  ) {
    return RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    ).hasMatch(email);
  }

  // =========================================================
  // CONTINUE
  // =========================================================

  Future<void> continueProfile(
    BuildContext context, {
    required VoidCallback onSuccess,
  }) async {
    FocusScope.of(context).unfocus();

    if (!validate(context)) {
      return;
    }

    _setLoading(true);

    try {
      // =====================================================
      // TODO:
      // Driver profile API integration will come here.
      //
      // Example data:
      //
      // fullNameController.text
      // dateOfBirthController.text
      // selectedGender
      // emailController.text
      // cityController.text
      // profileImage
      // =====================================================

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      _setLoading(false);

      onSuccess();
    } catch (error) {
      _setLoading(false);

      if (!context.mounted) {
        return;
      }

      _showMessage(
        context,
        'Unable to save profile. Please try again.',
      );
    }
  }

  // =========================================================
  // LOADING
  // =========================================================

  void _setLoading(
    bool value,
  ) {
    _isLoading = value;

    notifyListeners();
  }

  // =========================================================
  // MESSAGE
  // =========================================================

  void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    fullNameController.dispose();
    dateOfBirthController.dispose();
    emailController.dispose();
    cityController.dispose();

    super.dispose();
  }
}