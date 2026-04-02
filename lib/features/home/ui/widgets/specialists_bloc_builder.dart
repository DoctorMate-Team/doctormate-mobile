import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/home/logic/cubit/home_cubit.dart';
import 'package:doctor_mate/features/home/logic/cubit/home_state.dart';
import 'package:doctor_mate/features/home/ui/widgets/modern_specialists_list.dart';
import 'package:doctor_mate/features/home/ui/widgets/specialists_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialtiesBlocBuilder extends StatelessWidget {
  final String? selectedSpecialtyId;
  final Function(String) onSpecialistTap;
  final Function(String)? onFirstSpecialtyLoaded;

  const SpecialtiesBlocBuilder({
    super.key,
    required this.selectedSpecialtyId,
    required this.onSpecialistTap,
    this.onFirstSpecialtyLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              current is GetSpecialtiesLoading ||
              current is GetSpecialtiesSuccess ||
              current is GetSpecialtiesError,
      builder: (context, state) {
        return state.maybeWhen(
          getSpecialtiesLoading: () => const SpecialistsShimmerLoading(),
          getSpecialtiesSuccess: (specialties) {
            if (specialties.isEmpty) {
              return SizedBox(
                height: 120.h,
                child: Center(
                  child: Text(
                    'No specialties available',
                    style: TextStyles.font14GrayRegular,
                  ),
                ),
              );
            }
            // Notify parent about first specialty if callback provided and no selection yet
            if (onFirstSpecialtyLoaded != null && selectedSpecialtyId == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                onFirstSpecialtyLoaded!(specialties.first.id);
              });
            }
            return ModernSpecialistsList(
              specialties: specialties,
              selectedSpecialtyId: selectedSpecialtyId ?? specialties.first.id,
              onSpecialistTap: onSpecialistTap,
            );
          },
          getSpecialtiesError:
              (message) => SizedBox(
                height: 120.h,
                child: Center(
                  child: Text(message, style: TextStyles.font14GrayRegular),
                ),
              ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
