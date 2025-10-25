import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DatePickerFormField extends StatefulWidget {
  const DatePickerFormField({
    super.key,
    required this.hintText,
    this.validator,
    this.controller,
  });

  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  DateTime? _selectedDate;

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorsManager.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller?.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      readOnly: true,
      onTap: _selectDate,
      validator: widget.validator ?? (value) => null,
      style: TextStyle(fontSize: 16.sp, color: Colors.black),
      hintText: widget.hintText,
      suffixIcon: IconButton(
        icon: Icon(
          Iconsax.calendar,
          size: 24.sp,
          color: ColorsManager.primaryColor,
        ),
        onPressed: _selectDate,
      ),
    );
  }
}
