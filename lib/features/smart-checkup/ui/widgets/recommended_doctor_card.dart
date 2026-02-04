import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart'
    as home_specialty;
import 'package:doctor_mate/features/home/ui/widgets/doctors_list_for_specialist.dart';
import 'package:doctor_mate/features/smart-checkup/data/models/smart_check_response.dart';
import 'package:flutter/material.dart';

class RecommendedDoctorCard extends StatelessWidget {
  final RecommendedDoctorModel doctor;

  const RecommendedDoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    // Convert RecommendedDoctorModel to DoctorModel
    final doctorModel = DoctorModel(
      id: doctor.id,
      fullName: doctor.fullName,
      specialty: home_specialty.SpecialtyModel(
        id: '',
        name: 'Specialist',
        description: '',
        imageUrl: '',
      ),
      imageUrl: doctor.imageUrl,
      consultationFee: doctor.consultationFee,
      address: doctor.address,
      workingTime: doctor.workingTime,
      qualifications: doctor.qualifications,
      licenseNumber: '',
    );

    return DoctorCard(doctor: doctorModel);
  }
}
