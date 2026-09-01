import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;

  final TextCapitalization textCapitalization;

  final String? label;
  final String? hint;

  final Widget? prefix;
  final Widget? suffix;

  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final VoidCallback? onSuffixTap;

  final TextInputType keyboardType;
  final TextInputAction? textInputAction;

  final bool obscureText;
  final bool readOnly;
  final bool enabled;

  final int maxLines;
  final int? maxLength;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;

  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.textCapitalization =
    TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty) ...[
          Text(
            label!,
            style: AppTextStyles.labelLarge,
          ),
          AppSpacing.gapXS,
        ],

        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enabled,
          maxLines: obscureText ? 1 : maxLines,
          maxLength: maxLength,
          onChanged: onChanged,
          onTap: onTap,
          validator: validator,
          inputFormatters: inputFormatters,
          style: AppTextStyles.input,
          textCapitalization:textCapitalization,
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            hintText: hint,
            counterText: '',
            prefix: prefix,
            suffix: suffix,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: AppColors.iconSecondary,
                    size: AppSpacing.iconSM,
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: onSuffixTap,
                    icon: Icon(
                      suffixIcon,
                      color: AppColors.iconSecondary,
                      size: AppSpacing.iconSM,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}