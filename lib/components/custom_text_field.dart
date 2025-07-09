import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/app_validator.dart';
import 'package:revalesuva/utils/fonts_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.controller,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textAlign = TextAlign.start,
    this.enabled,
    this.maxLine = 1,
    this.minLine,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.onEditComplete,
    this.onChange,
    this.inputFormatters,
    this.fontFamily = FontsConstants.roboto,
    this.fillColor,
    this.border = 1.0,
  });

  final String hint;
  final TextEditingController? controller;
  final int? minLine;
  final int? maxLine;
  final bool? enabled;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String? value)? validator;
  final void Function()? onEditComplete;
  final void Function(String value)? onChange;
  final String fontFamily;
  final Color? fillColor;
  final double border;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      minLines: minLine,
      maxLines: maxLine,
      enabled: enabled,
      textAlign: textAlign,
      inputFormatters: [LengthLimitingTextInputFormatter(163), ...?inputFormatters],
      textInputAction: textInputAction,
      keyboardType: textInputType,
      validator: validator,
      obscureText: obscureText,
      onEditingComplete: onEditComplete,
      onChanged: onChange,
      cursorColor: AppColors.brand,
      style: GoogleFonts.getFont(
        fontFamily,
        textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
              color: AppColors.textPrimary,
            ),
      ),
      decoration: InputDecoration(
        hintText: hint,
        errorMaxLines: 1,
        isDense: true,
        hintStyle: GoogleFonts.getFont(
          FontsConstants.roboto,
          textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
                color: AppColors.textSecondary,
              ),
        ),
        filled: true,
        errorStyle: GoogleFonts.getFont(
          FontsConstants.roboto,
          textStyle: Theme.of(context).textTheme.labelMedium,
          color: Colors.red.withValues(alpha: 0.8),
        ),
        fillColor: fillColor ?? AppColors.surfaceTertiary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: BorderSide(
            color: AppColors.borderTertiary,
            width: border,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: BorderSide(
            color: AppColors.borderTertiary,
            width: border,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: BorderSide(
            color: AppColors.borderTertiary,
            width: border,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: BorderSide(
            color: Colors.red,
            width: border,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: BorderSide(
            color: AppColors.borderTertiary,
            width: border,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: BorderSide(
            color: Colors.red,
            width: border,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 30,
          maxWidth: 50,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 30,
          maxWidth: 35,
        ),
      ),
    );
  }
}

class CustomTextFieldWithButton extends StatelessWidget {
  const CustomTextFieldWithButton({
    super.key,
    required this.hint,
    this.controller,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textAlign = TextAlign.start,
    this.enabled,
    this.maxLine = 1,
    this.minLine,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.onEditComplete,
    this.onChange,
    this.inputFormatters,
    this.fontFamily = FontsConstants.roboto,
  });

  final String hint;
  final TextEditingController? controller;
  final int? minLine;
  final int? maxLine;
  final bool? enabled;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String? value)? validator;
  final void Function()? onEditComplete;
  final void Function(String value)? onChange;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      minLines: minLine,
      maxLines: maxLine,
      enabled: enabled,
      textAlign: textAlign,
      inputFormatters: [LengthLimitingTextInputFormatter(10), ...?inputFormatters],
      textInputAction: textInputAction,
      keyboardType: textInputType,
      validator: validator,
      obscureText: obscureText,
      onEditingComplete: onEditComplete,
      onChanged: onChange,
      cursorColor: AppColors.brand,
      style: GoogleFonts.getFont(
        fontFamily,
        textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
              color: AppColors.textPrimary,
            ),
      ),
      decoration: InputDecoration(
        hintText: hint,
        errorMaxLines: 1,
        hintStyle: GoogleFonts.getFont(
          FontsConstants.roboto,
          textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
                color: AppColors.textSecondary,
              ),
        ),
        isDense: true,
        filled: true,
        errorStyle: GoogleFonts.getFont(
          FontsConstants.roboto,
          textStyle: Theme.of(context).textTheme.labelMedium,
          color: Colors.red.withValues(alpha: 0.8),
        ),
        fillColor: AppColors.surfaceTertiary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: AppColors.borderTertiary,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: AppColors.borderTertiary,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: AppColors.borderTertiary,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: AppColors.borderTertiary,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        suffixIconConstraints: const BoxConstraints(
          minHeight: 45,
          minWidth: 60,
        ),
        prefixIconConstraints: const BoxConstraints(
          minHeight: 25,
          minWidth: 25,
        ),
      ),
    );
  }
}

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    super.key,
    required this.length,
    this.controller,
    this.fontFamily = FontsConstants.roboto,
  });

  final int length;
  final TextEditingController? controller;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      length: length,
      controller: controller,
      defaultPinTheme: PinTheme(
        height: 60,
        width: 60,
        textStyle: GoogleFonts.getFont(
          fontFamily,
          textStyle: Theme.of(context).textTheme.bodyLarge?.apply(
                color: AppColors.textPrimary,
              ),
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(AppCorner.textField),
        ),
      ),
      showCursor: true,
      errorTextStyle: GoogleFonts.getFont(
        FontsConstants.roboto,
        textStyle: Theme.of(context).textTheme.bodyMedium,
        color: Colors.red.withValues(alpha: 0.8),
      ),
      validator: (value) {
        return FormValidate.requiredField(value!, "OTP");
      },
    );
  }
}

class CustomTextField2 extends StatelessWidget {
  const CustomTextField2({
    super.key,
    required this.hint,
    this.controller,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textAlign = TextAlign.center,
    this.enabled,
    this.maxLine = 1,
    this.minLine,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.onEditComplete,
    this.onChange,
    this.inputFormatters,
    this.fontFamily = FontsConstants.roboto,
    this.fillColor = Colors.transparent,
  });

  final String hint;
  final TextEditingController? controller;
  final int? minLine;
  final int? maxLine;
  final bool? enabled;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String? value)? validator;
  final void Function()? onEditComplete;
  final void Function(String value)? onChange;
  final String fontFamily;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      minLines: minLine,
      maxLines: maxLine,
      enabled: enabled,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      validator: validator,
      obscureText: obscureText,
      onEditingComplete: onEditComplete,
      onChanged: onChange,
      cursorColor: AppColors.brand,
      style: GoogleFonts.getFont(
        fontFamily,
        textStyle: Theme.of(context).textTheme.labelLarge?.apply(
              color: AppColors.textPrimary,
              fontSizeDelta: 8,
              fontWeightDelta: 2,
            ),
      ),
      decoration: InputDecoration(
        errorMaxLines: 1,
        label: Align(
          alignment: Alignment.center,
          child: Text(
            hint,
            style: Theme.of(context).textTheme.bodySmall?.apply(
                  color: AppColors.textPrimary,
                  fontSizeDelta: -1,
                ),
            textAlign: textAlign,
          ),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        filled: true,
        errorStyle: GoogleFonts.getFont(
          FontsConstants.roboto,
          textStyle: Theme.of(context).textTheme.labelMedium,
          color: Colors.red.withValues(alpha: 0.8),
        ),
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: AppColors.borderSecondary,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: AppColors.borderSecondary,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: AppColors.borderSecondary,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: AppColors.borderSecondary,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppCorner.textField),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 30,
          maxWidth: 40,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 30,
          maxWidth: 35,
        ),
      ),
    );
  }
}

class CustomTextArea extends StatelessWidget {
  const CustomTextArea({
    super.key,
    required this.hint,
    this.controller,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textAlign = TextAlign.start,
    this.enabled,
    this.maxLine = 1,
    this.minLine,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.onEditComplete,
    this.onChange,
    this.inputFormatters,
    this.fontFamily = FontsConstants.roboto,
    this.fillColor,
    this.border = 1.0,
  });

  final String hint;
  final TextEditingController? controller;
  final int? minLine;
  final int? maxLine;
  final bool? enabled;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String? value)? validator;
  final void Function()? onEditComplete;
  final void Function(String value)? onChange;
  final String fontFamily;
  final Color? fillColor;
  final double border;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      minLines: minLine,
      maxLines: maxLine,
      enabled: enabled,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      validator: validator,
      obscureText: obscureText,
      onEditingComplete: onEditComplete,
      onChanged: onChange,
      cursorColor: AppColors.brand,
      style: GoogleFonts.getFont(
        fontFamily,
        textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
              color: AppColors.textPrimary,
            ),
      ),
      decoration: InputDecoration(
        hintText: hint,
        errorMaxLines: 1,
        isDense: true,
        hintStyle: GoogleFonts.getFont(
          FontsConstants.roboto,
          textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
                color: AppColors.textSecondary,
              ),
        ),
        filled: true,
        errorStyle: GoogleFonts.getFont(
          FontsConstants.roboto,
          textStyle: Theme.of(context).textTheme.labelMedium,
          color: Colors.red.withValues(alpha: 0.8),
        ),
        fillColor: fillColor ?? AppColors.surfaceTertiary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 30,
          maxWidth: 40,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 30,
          maxWidth: 35,
        ),
      ),
    );
  }
}
