import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/home/logic/cubit/home_cubit.dart';
import 'package:doctor_mate/features/home/logic/cubit/home_state.dart';
import 'package:doctor_mate/features/home/ui/widgets/doctors_list_for_specialist.dart';
import 'package:doctor_mate/features/home/ui/widgets/doctors_shimmer_loading.dart';
import 'package:doctor_mate/features/home/ui/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsBlocBuilder extends StatelessWidget {
  const DoctorsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              current is GetDoctorsBySpecialtyLoading ||
              current is GetDoctorsBySpecialtySuccess ||
              current is GetDoctorsBySpecialtyError,
      builder: (context, state) {
        return state.maybeWhen(
          getDoctorsBySpecialtyLoading:
              () => Column(
                children: [
                  const SectionHeader(
                    title: 'Best Doctors',
                    actionText: 'View All',
                  ),
                  verticalSpacing(12),
                  const DoctorsShimmerLoading(),
                  verticalSpacing(20),
                ],
              ),
          getDoctorsBySpecialtySuccess:
              (doctors) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Best Doctors',
                    actionText: 'View All',
                  ),
                  verticalSpacing(12),
                  DoctorsListForSpecialist(doctors: doctors),
                  verticalSpacing(20),
                ],
              ),
          getDoctorsBySpecialtyError:
              (message) => Column(
                children: [
                  const SectionHeader(
                    title: 'Best Doctors',
                    actionText: 'View All',
                  ),
                  verticalSpacing(12),
                  Center(
                    child: Text(message, style: TextStyles.font14GrayRegular),
                  ),
                  verticalSpacing(20),
                ],
              ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
