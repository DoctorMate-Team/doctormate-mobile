import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DetailsScreenAppBar extends StatelessWidget {
  const DetailsScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Iconsax.back_square),
        ),
        Text(
          'Mohamed Ali',
          style: TextStyles.font16WhiteSemiBold.copyWith(color: Colors.black),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.more),
        ),
      ],
    );
  }
}
