import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart';
import 'package:doctor_mate/features/home/ui/widgets/doctors_list_for_specialist.dart';
import 'package:doctor_mate/features/home/ui/widgets/doctors_shimmer_loading.dart';
import 'package:doctor_mate/features/search/ui/widgets/filter_chip_item.dart';
import 'package:doctor_mate/features/search/ui/widgets/search_app_bar.dart';
import 'package:doctor_mate/features/search/ui/widgets/specialty_filter_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  bool _isLoading = false;
  String _searchQuery = '';
  String? _selectedSpecialtyId;
  String? _selectedSpecialtyName;
  String _sortBy = 'none'; // none, highestReview

  // Mock data - will be replaced with API call
  List<DoctorModel> _doctors = [];
  List<SpecialtyModel> _specialties = [];

  @override
  void initState() {
    super.initState();
    _loadMockData();
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _loadMockData() {
    // Mock specialties
    _specialties = [
      SpecialtyModel(
        id: '1',
        name: 'Cardiology',
        description: 'Heart specialists',
        imageUrl: 'https://example.com/cardio.png',
      ),
      SpecialtyModel(
        id: '2',
        name: 'Dermatology',
        description: 'Skin specialists',
        imageUrl: 'https://example.com/derm.png',
      ),
      SpecialtyModel(
        id: '3',
        name: 'Pediatrics',
        description: 'Child specialists',
        imageUrl: 'https://example.com/pedia.png',
      ),
      SpecialtyModel(
        id: '4',
        name: 'Orthopedics',
        description: 'Bone specialists',
        imageUrl: 'https://example.com/ortho.png',
      ),
      SpecialtyModel(
        id: '5',
        name: 'Neurology',
        description: 'Brain specialists',
        imageUrl: 'https://example.com/neuro.png',
      ),
    ];

    // Mock doctors
    _doctors = [
      DoctorModel(
        id: '1',
        fullName: 'Dr. Sarah Johnson',
        specialty: _specialties[0],
        imageUrl:
            'https://res.cloudinary.com/dukkhnflu/image/upload/v1761876798/doctormate/users/lwphifll71jzpgmt8mjs.jpg',
        consultationFee: 850.0,
        address: 'Cairo Medical Center',
        workingTime: '09:00 - 17:00',
        qualifications: 'MD, Ph.D. in Cardiology',
        licenseNumber: 'DOC-123456',
      ),
      DoctorModel(
        id: '2',
        fullName: 'Dr. Michael Chen',
        specialty: _specialties[1],
        imageUrl:
            'https://res.cloudinary.com/dukkhnflu/image/upload/v1761876798/doctormate/users/lwphifll71jzpgmt8mjs.jpg',
        consultationFee: 750.0,
        address: 'Alexandria Hospital',
        workingTime: '10:00 - 18:00',
        qualifications: 'MD in Dermatology',
        licenseNumber: 'DOC-789012',
      ),
      DoctorModel(
        id: '3',
        fullName: 'Dr. Emily Roberts',
        specialty: _specialties[2],
        imageUrl:
            'https://res.cloudinary.com/dukkhnflu/image/upload/v1761876798/doctormate/users/lwphifll71jzpgmt8mjs.jpg',
        consultationFee: 650.0,
        address: 'Giza Children Clinic',
        workingTime: '08:00 - 16:00',
        qualifications: 'MD, Pediatric Specialist',
        licenseNumber: 'DOC-345678',
      ),
      DoctorModel(
        id: '4',
        fullName: 'Dr. Ahmed Hassan',
        specialty: _specialties[0],
        imageUrl:
            'https://res.cloudinary.com/dukkhnflu/image/upload/v1761876798/doctormate/users/lwphifll71jzpgmt8mjs.jpg',
        consultationFee: 900.0,
        address: 'Cairo Heart Institute',
        workingTime: '11:00 - 19:00',
        qualifications: 'MD, Ph.D. Cardiac Surgery',
        licenseNumber: 'DOC-901234',
      ),
      DoctorModel(
        id: '5',
        fullName: 'Dr. Lisa Anderson',
        specialty: _specialties[3],
        imageUrl:
            'https://res.cloudinary.com/dukkhnflu/image/upload/v1761876798/doctormate/users/lwphifll71jzpgmt8mjs.jpg',
        consultationFee: 800.0,
        address: 'Mansoura Orthopedic Center',
        workingTime: '09:00 - 17:00',
        qualifications: 'MD in Orthopedic Surgery',
        licenseNumber: 'DOC-567890',
      ),
    ];
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  List<DoctorModel> _getFilteredDoctors() {
    List<DoctorModel> filtered = List.from(_doctors);

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered =
          filtered
              .where(
                (doctor) => doctor.fullName.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
              )
              .toList();
    }

    // Filter by specialty
    if (_selectedSpecialtyId != null) {
      filtered =
          filtered
              .where((doctor) => doctor.specialty.id == _selectedSpecialtyId)
              .toList();
    }

    // Sort by highest review (mock - random for now)
    if (_sortBy == 'highestReview') {
      filtered.sort((a, b) => b.consultationFee.compareTo(a.consultationFee));
    }

    return filtered;
  }

  void _clearFilters() {
    setState(() {
      _selectedSpecialtyId = null;
      _selectedSpecialtyName = null;
      _sortBy = 'none';
    });
  }

  void _showSpecialtyFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => SpecialtyFilterSheet(
            specialties: _specialties,
            selectedSpecialtyId: _selectedSpecialtyId,
            onSpecialtySelected: (specialty) {
              setState(() {
                _selectedSpecialtyId = specialty.id;
                _selectedSpecialtyName = specialty.name;
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = _getFilteredDoctors();
    final hasActiveFilters = _selectedSpecialtyId != null || _sortBy != 'none';

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            SearchAppBar(onBackPressed: () {}),

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: CustomTextFormField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                hintText: 'Search doctors by name...',
                prefix: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Icon(
                    Iconsax.search_normal_copy,
                    color: Colors.grey.shade600,
                    size: 20.sp,
                  ),
                ),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: Icon(
                            Iconsax.close_circle,
                            color: Colors.grey.shade600,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch('');
                          },
                        )
                        : null,
                onChanged: (value) {
                  _performSearch(value);
                },
                validator: (value) => null,
              ),
            ),

            // Filter Chips
            Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        FilterChipItem(
                          label: _selectedSpecialtyName ?? 'Specialty',
                          icon: Iconsax.category,
                          isSelected: _selectedSpecialtyId != null,
                          onTap: _showSpecialtyFilter,
                        ),
                        horizantialSpacing(8),
                        FilterChipItem(
                          label: 'Highest Review',
                          icon: Iconsax.star_1,
                          isSelected: _sortBy == 'highestReview',
                          onTap: () {
                            setState(() {
                              _sortBy =
                                  _sortBy == 'highestReview'
                                      ? 'none'
                                      : 'highestReview';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  if (hasActiveFilters) ...[
                    horizantialSpacing(8),
                    GestureDetector(
                      onTap: _clearFilters,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.red.shade200,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Iconsax.close_circle,
                              size: 16.sp,
                              color: Colors.red.shade700,
                            ),
                            horizantialSpacing(4),
                            Text(
                              'Clear',
                              style: TextStyles.font12DarkGreenSemiBold
                                  .copyWith(color: Colors.red.shade700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            verticalSpacing(8),

            // Results
            Expanded(
              child:
                  _isLoading
                      ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: const DoctorsShimmerLoading(),
                      )
                      : filteredDoctors.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: filteredDoctors.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: DoctorCard(doctor: filteredDoctors[index]),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.search_normal,
              size: 50.sp,
              color: Colors.grey.shade400,
            ),
          ),
          verticalSpacing(24),
          Text('No doctors found', style: TextStyles.font18DarkGreenBold),
          verticalSpacing(8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: Text(
              'Try adjusting your search or filters to find what you\'re looking for',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
