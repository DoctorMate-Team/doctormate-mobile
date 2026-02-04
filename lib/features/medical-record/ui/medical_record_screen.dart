import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:doctor_mate/features/medical-record/logic/cubit/medical_records_cubit.dart';
import 'package:doctor_mate/features/medical-record/logic/cubit/medical_records_state.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/medical_record_app_bar.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/medical_record_card.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/medical_record_empty_state.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/medical_record_error_state.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/medical_record_filter_sheet.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/medical_record_shimmer_loading.dart';
import 'package:doctor_mate/features/medical-record/ui/widgets/record_type_chips_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  String _selectedRecordType = 'All';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchRecords() async {
    context.read<MedicalRecordsCubit>().getPatientMedicalRecords(
      page: 1,
      limit: 10,
    );
  }

  List<MedicalRecordModel> _filterRecordsByType(
    List<MedicalRecordModel> allRecords,
  ) {
    if (_selectedRecordType == 'All') {
      return allRecords;
    }
    return allRecords
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Search functionality coming soon'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        onFilterPressed: _showFilterSheet,
      ),
      body: Column(
        children: [
          // Record type filter chips
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: RecordTypeChipsBar(
              selectedType: _selectedRecordType,
              onTypeChanged: (type) {
                setState(() {
                  _selectedRecordType = type;
                });
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<MedicalRecordsCubit, MedicalRecordsState>(
              buildWhen: (previous, current) => current is LoadingGetMedicalRecords ||
                  current is SuccessGetMedicalRecords ||
                  current is ErrorGetMedicalRecords,
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loadingGetMedicalRecords:
                      () => const MedicalRecordShimmerLoading(),
                  successGetMedicalRecords:
                      (records, hasReachedMax) => _buildRecordsList(records),
                  errorGetMedicalRecords:
                      (message) => MedicalRecordErrorState(
                        message: message,
                        onRetry: _fetchRecords,
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordsList(List<MedicalRecordModel> allRecords) {
    final filteredRecords = _filterRecordsByType(allRecords);

    if (filteredRecords.isEmpty) {
      return MedicalRecordEmptyState(
        recordType: _selectedRecordType,
        onAddPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Add record functionality coming soon'),
              duration: const Duration(seconds: 2),
              backgroundColor: ColorsManager.primaryColor,
            ),
          );
        },
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchRecords,
      color: ColorsManager.primaryColor,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        physics: const BouncingScrollPhysics(),
        itemCount: filteredRecords.length,
        itemBuilder: (context, index) {
          return AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 300 + (index * 100)),
            child: AnimatedSlide(
              offset: Offset.zero,
              duration: Duration(milliseconds: 300 + (index * 100)),
              curve: Curves.easeOutCubic,
              child: MedicalRecordCard(
                record: filteredRecords[index],
                onTap: () {
                  final record = filteredRecords[index];
                  // Navigate to diagnosis screen if record type is diagnosis
                  if (record.recordType.toLowerCase() == 'diagnosis') {
                    // Pass the diagnosis data to the screen
                    if (record.diagnoses != null &&
                        record.diagnoses!.isNotEmpty) {
                      context.push(
                        '${Routes.dignosesScreen}?recordId=${record.id}',
                        extra: record.diagnoses!.first,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No diagnosis details available'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'View ${record.recordType} details - Coming soon',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                onDownload: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Download functionality coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                onShare: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Share functionality coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
