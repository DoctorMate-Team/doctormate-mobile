import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizintalDivider extends StatelessWidget {
  const HorizintalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5.h,
      width: double.infinity,
      color: Colors.grey,
    );
  }
}
