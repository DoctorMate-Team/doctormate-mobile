import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDropDownFormField extends StatefulWidget {
  const CustomDropDownFormField({
    super.key,
    required this.listOfValues,
    this.backgroundColor,
    this.enabledBorder,
    this.focusedBorder,
    this.contentPadding,
    required this.hintText,
    this.hintStyle,
    this.textStyle,
    required this.validator,
    this.onChanged,
  });

  final List<String> listOfValues;
  final Color? backgroundColor;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final EdgeInsets? contentPadding;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final String? Function(String?) validator;
  final ValueChanged<String?>? onChanged;

  @override
  State<CustomDropDownFormField> createState() =>
      _CustomDropDownFormFieldState();
}

class _CustomDropDownFormFieldState extends State<CustomDropDownFormField> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: _selectedValue,
      icon: const Icon(FontAwesomeIcons.angleDown, size: 16),
      decoration: _buildInputDecoration(),
      isExpanded: true,
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      onSaved: (value) {
        /*
        setState(() {
          context.read<AuthCubit>().gender = value!;
          _selectedValue = value;
        });
        */
      },
      validator: widget.validator,
      items: _buildDropdownItems(),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      contentPadding:
          widget.contentPadding ??
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      isDense: true,
      filled: true,
      fillColor: widget.backgroundColor ?? ColorsManager.moreLighterGray,
      hintText: widget.hintText,
      hintStyle: widget.hintStyle ?? TextStyles.font14GrayRegular,
      enabledBorder:
          widget.enabledBorder ??
          OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorsManager.moreLightGray,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
      focusedBorder:
          widget.focusedBorder ??
          OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorsManager.warningRed,
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorsManager.warningRed,
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    return widget.listOfValues.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value, style: widget.textStyle),
      );
    }).toList();
  }
}
