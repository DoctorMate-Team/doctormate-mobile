import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/medical_record_app_bar.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/medical_record_card.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/medical_record_empty_state.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/medical_record_filter_sheet.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/medical_record_shimmer_loading.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/record_type_chips_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  String _selectedRecordType = 'All';
  bool _isLoading = false;
  List<MedicalRecordModel> _allRecords = [];

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  void _fetchRecords() {
    setState(() {
      _isLoading = true;
    });

    // TODO: Fetch from API
    // Simulate loading with mock data
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          // Mock data for demonstration
          _allRecords = [
            MedicalRecordModel(
              id: 'rec_lab_001_2024',
              title: 'Complete Blood Count (CBC)',
              description:
                  'Routine blood test showing all values within normal range. Hemoglobin: 14.5 g/dL, WBC: 7,200/μL, Platelets: 250,000/μL.',
              recordType: 'Lab Results',
              status: 'Completed',
              patientId: 'pat_001',
              patientName: 'Ahmed Hassan',
              doctorId: 'doc_001',
              doctorName: 'Sarah Johnson',
              recordedBy: 'Lab Technician - Mohamed Ali',
              recordedAt:
                  DateTime.now()
                      .subtract(const Duration(days: 2))
                      .toIso8601String(),
            ),
            MedicalRecordModel(
              id: 'rec_presc_002_2024',
              title: 'Antibiotic Prescription',
              description:
                  'Amoxicillin 500mg - Take 3 times daily after meals for 7 days. For upper respiratory tract infection treatment.',
              recordType: 'Prescriptions',
              status: 'Completed',
              patientId: 'pat_001',
              patientName: 'Ahmed Hassan',
              doctorId: 'doc_002',
              doctorName: 'Michael Chen',
              recordedBy: 'Dr. Michael Chen',
              recordedAt:
                  DateTime.now()
                      .subtract(const Duration(days: 5))
                      .toIso8601String(),
            ),
            MedicalRecordModel(
              id: 'rec_img_003_2024',
              title: 'Chest X-Ray',
              description:
                  'Posteroanterior and lateral views. No acute cardiopulmonary abnormality detected. Heart size normal. Lungs clear.',
              recordType: 'Imaging',
              status: 'Reviewed',
              patientId: 'pat_001',
              patientName: 'Ahmed Hassan',
              doctorId: 'doc_003',
              doctorName: 'Emily Rodriguez',
              recordedBy: 'Radiology Department',
              recordedAt:
                  DateTime.now()
                      .subtract(const Duration(days: 10))
                      .toIso8601String(),
            ),
            MedicalRecordModel(
              id: 'rec_diag_004_2024',
              title: 'Type 2 Diabetes Mellitus Diagnosis',
              description:
                  'Diagnosis confirmed based on HbA1c test result of 7.2%. Patient counseled on lifestyle modifications and medication compliance.',
              recordType: 'Diagnosis',
              status: 'Completed',
              patientId: 'pat_001',
              patientName: 'Ahmed Hassan',
              doctorId: 'doc_004',
              doctorName: 'James Wilson',
              recordedBy: 'Dr. James Wilson - Endocrinologist',
              recordedAt:
                  DateTime.now()
                      .subtract(const Duration(days: 15))
                      .toIso8601String(),
            ),
            MedicalRecordModel(
              id: 'rec_vacc_005_2024',
              title: 'Influenza Vaccine 2024',
              description:
                  'Seasonal flu vaccine administered. Quadrivalent inactivated vaccine. No adverse reactions reported. Next dose due in 1 year.',
              recordType: 'Vaccination',
              status: 'Completed',
              patientId: 'pat_001',
              patientName: 'Ahmed Hassan',
              doctorId: 'doc_005',
              doctorName: 'Lisa Anderson',
              recordedBy: 'Nurse - Fatima Ahmed',
              recordedAt:
                  DateTime.now()
                      .subtract(const Duration(days: 30))
                      .toIso8601String(),
            ),
            MedicalRecordModel(
              id: 'rec_surg_006_2024',
              title: 'Appendectomy Surgery Report',
              description:
                  'Laparoscopic appendectomy performed successfully. Operation duration: 45 minutes. Patient recovered well post-op. Discharged after 48 hours.',
              recordType: 'Surgery',
              status: 'Completed',
              patientId: 'pat_001',
              patientName: 'Ahmed Hassan',
              doctorId: 'doc_006',
              doctorName: 'Robert Thompson',
              recordedBy: 'Dr. Robert Thompson - Surgeon',
              recordedAt:
                  DateTime.now()
                      .subtract(const Duration(days: 90))
                      .toIso8601String(),
            ),
            MedicalRecordModel(
              id: 'rec_lab_007_2024',
              title: 'Lipid Profile Test',
              description:
                  'Fasting lipid panel results: Total Cholesterol: 185 mg/dL, LDL: 110 mg/dL, HDL: 55 mg/dL, Triglycerides: 100 mg/dL.',
              recordType: 'Lab Results',
              status: 'Pending',
              patientId: 'pat_001',
              patientName: 'Ahmed Hassan',
              doctorId: 'doc_001',
              doctorName: 'Sarah Johnson',
              recordedBy: 'Lab Technician - Omar Mahmoud',
              recordedAt:
                  DateTime.now()
                      .subtract(const Duration(hours: 6))
                      .toIso8601String(),
            ),
            MedicalRecordModel(
              id: 'rec_presc_008_2024',
              title: 'Metformin Prescription',
              description:
                  'Metformin 500mg - Take twice daily with meals. For blood sugar management. Monitor glucose levels regularly.',
              recordType: 'Prescriptions',
              status: 'Completed',
              patientId: 'pat_001',
              patientName: 'Ahmed Hassan',
              doctorId: 'doc_004',
              doctorName: 'James Wilson',
              recordedBy: 'Dr. James Wilson',
              recordedAt:
                  DateTime.now()
                      .subtract(const Duration(days: 20))
                      .toIso8601String(),
            ),
          ];
        });
      }
    });
  }

  List<MedicalRecordModel> _filterRecordsByType() {
    if (_selectedRecordType == 'All') {
      return _allRecords;
    }
    return _allRecords
        .where(
          (record) =>
              record.recordType.toLowerCase() ==
              _selectedRecordType.toLowerCase(),
        )
        .toList();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => const MedicalRecordFilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: MedicalRecordAppBar(
        onSearchPressed: () {
          // TODO: Implement search
        },
        onFilterPressed: _showFilterSheet,
      ),
      body: Column(
        children: [
          RecordTypeChipsBar(
            selectedType: _selectedRecordType,
            onTypeChanged: (type) {
              setState(() {
                _selectedRecordType = type;
              });
            },
          ),
          Expanded(
            child:
                _isLoading
                    ? const MedicalRecordShimmerLoading()
                    : _buildRecordsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordsList() {
    final filteredRecords = _filterRecordsByType();

    if (filteredRecords.isEmpty) {
      return MedicalRecordEmptyState(
        recordType: _selectedRecordType,
        onAddPressed: () {
          // TODO: Implement add record
        },
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        _fetchRecords();
      },
      color: ColorsManager.primaryColor,
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: filteredRecords.length,
        itemBuilder: (context, index) {
          return MedicalRecordCard(
            record: filteredRecords[index],
            onTap: () {
              // Navigate to diagnosis screen if record type is diagnosis
              if (filteredRecords[index].recordType.toLowerCase() ==
                  'diagnosis') {
                context.push(
                  '${Routes.dignosesScreen}?recordId=${filteredRecords[index].id}',
                );
              } else {
                // TODO: Navigate to other record details
              }
            },
            onDownload: () {
              // TODO: Implement download
            },
            onShare: () {
              // TODO: Implement share
            },
          );
        },
      ),
    );
  }
}
