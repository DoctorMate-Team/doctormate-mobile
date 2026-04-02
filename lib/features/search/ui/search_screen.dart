import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart';
import 'package:doctor_mate/features/home/ui/widgets/doctors_shimmer_loading.dart';
import 'package:doctor_mate/features/search/logic/cubit/search_cubit.dart';
import 'package:doctor_mate/features/search/logic/cubit/search_state.dart';
import 'package:doctor_mate/features/search/ui/widgets/doctors_list_widget.dart';
import 'package:doctor_mate/features/search/ui/widgets/filter_chip_item.dart';
import 'package:doctor_mate/features/search/ui/widgets/search_app_bar.dart';
import 'package:doctor_mate/features/search/ui/widgets/search_empty_state.dart';
import 'package:doctor_mate/features/search/ui/widgets/search_error_state.dart';
import 'package:doctor_mate/features/search/ui/widgets/specialty_filter_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final ScrollController _scrollController = ScrollController();

  String _searchQuery = '';
  String? _selectedSpecialtyId;
  String? _selectedSpecialtyName;
  String _sortBy = 'none'; // none, rating

  // Pagination variables
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  List<DoctorModel> _doctors = [];
  List<SpecialtyModel> _specialties = [];

  @override
  void initState() {
    super.initState();
    _searchFocusNode.requestFocus();
    _scrollController.addListener(_onScroll);
    // Fetch specialties for filter
    context.read<SearchCubit>().getSpecialties();
    // Initial search with empty query to get all doctors
    _performSearch('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMoreDoctors();
    }
  }

  void _loadMoreDoctors() {
    if (_isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
      _currentPage++;
    });

    context.read<SearchCubit>().searchDoctors(
      query: _searchQuery,
      specialtyId: _selectedSpecialtyId,
      sort: _sortBy == 'rating' ? 'rating' : null,
      page: _currentPage,
      limit: 10,
    );
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      _currentPage = 1;
      _hasMore = true;
      _doctors.clear();
    });

    context.read<SearchCubit>().searchDoctors(
      query: _searchQuery,
      specialtyId: _selectedSpecialtyId,
      sort: _sortBy == 'rating' ? 'rating' : null,
      page: _currentPage,
      limit: 10,
    );
  }

  void _applyFilters() {
    setState(() {
      _currentPage = 1;
      _hasMore = true;
      _doctors.clear();
    });

    context.read<SearchCubit>().searchDoctors(
      query: _searchQuery,
      specialtyId: _selectedSpecialtyId,
      sort: _sortBy == 'rating' ? 'rating' : null,
      page: _currentPage,
      limit: 10,
    );
  }

  void _clearFilters() {
    setState(() {
      _selectedSpecialtyId = null;
      _selectedSpecialtyName = null;
      _sortBy = 'none';
    });
    _applyFilters();
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
              _applyFilters();
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasActiveFilters = _selectedSpecialtyId != null || _sortBy != 'none';

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            SearchAppBar(),

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
                          isSelected: _sortBy == 'rating',
                          onTap: () {
                            setState(() {
                              _sortBy = _sortBy == 'rating' ? 'none' : 'rating';
                            });
                            _applyFilters();
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
              child: BlocConsumer<SearchCubit, SearchState>(
                listenWhen:
                    (previous, current) =>
                        current is SuccessGetDoctors ||
                        current is ErrorGetDoctors ||
                        current is SuccessGetSpecialties,
                listener: (context, state) {
                  state.whenOrNull(
                    successGetDoctors: (response) {
                      setState(() {
                        if (_currentPage == 1) {
                          _doctors = response.doctors;
                        } else {
                          _doctors.addAll(response.doctors);
                        }
                        _hasMore =
                            response.pagination.page <
                            response.pagination.totalPages;
                        _isLoadingMore = false;
                      });
                    },
                    successGetSpecialties: (specialties) {
                      setState(() {
                        _specialties = specialties;
                      });
                    },
                    errorGetDoctors: (error) {
                      setState(() {
                        _isLoadingMore = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  );
                },
                buildWhen:
                    (previous, current) =>
                        current is LoadingGetDoctors ||
                        current is ErrorGetDoctors ||
                        current is SuccessGetDoctors,
                builder: (context, state) {
                  return state.maybeWhen(
                    loadingGetDoctors: () {
                      if (_currentPage == 1) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: const DoctorsShimmerLoading(),
                        );
                      } else {
                        return _buildDoctorsList();
                      }
                    },
                    successGetDoctors: (_) => _buildDoctorsList(),
                    errorGetDoctors: (error) {
                      if (_doctors.isEmpty) {
                        return SearchErrorState(
                          error: error,
                          onRetry: () => _performSearch(_searchQuery),
                        );
                      } else {
                        return _buildDoctorsList();
                      }
                    },
                    orElse: () => _buildDoctorsList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorsList() {
    if (_doctors.isEmpty) {
      return const SearchEmptyState();
    }

    return DoctorsListWidget(
      doctors: _doctors,
      scrollController: _scrollController,
      isLoadingMore: _isLoadingMore,
    );
  }
}
