import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:flutter/material.dart';
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

  @override
  State<CustomDropDownFormField> createState() =>
      _CustomDropDownFormFieldState();
}

class _CustomDropDownFormFieldState extends State<CustomDropDownFormField> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      icon: const Icon(FontAwesomeIcons.angleDown),
      decoration: _buildInputDecoration(),
      isExpanded: true,
      onChanged: (value) {
        /*
        setState(() {
          context.read<AuthCubit>().gender = value!;
          _selectedValue = value;
        });
        */
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
      contentPadding: widget.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      isDense: true,
      filled: true,
      fillColor: widget.backgroundColor ?? Colors.white,
      enabledBorder:
          widget.enabledBorder ?? _defaultBorder(const Color(0xFFB8B8B8)),
      focusedBorder:
          widget.focusedBorder ?? _defaultBorder(ColorsManager.primaryColor),
      errorBorder: _defaultBorder(Colors.red),
      focusedErrorBorder: _defaultBorder(Colors.red, borderRadius: 16.0),
      hintText: widget.hintText,
      hintStyle:
          widget.hintStyle ?? const TextStyle(fontSize: 14, color: Colors.grey),
    );
  }

  OutlineInputBorder _defaultBorder(Color color, {double borderRadius = 8.0}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.3),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    return widget.listOfValues.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: widget.textStyle,
        ),
      );
    }).toList();
  }
}
