import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/ui/widgets/doctors_shimmer_loading.dart';
import 'package:doctor_mate/features/search/logic/cubit/search_cubit.dart';
import 'package:doctor_mate/features/search/logic/cubit/search_state.dart';
import 'package:doctor_mate/features/search/ui/widgets/search_empty_state.dart';
import 'package:doctor_mate/features/search/ui/widgets/search_error_state.dart';
import 'package:doctor_mate/features/home/ui/widgets/doctors_list_for_specialist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ViewAllScreen extends StatefulWidget {
  /// Optional pre-selected specialty ID to filter doctors on first load.
  final String? specialtyId;

  const ViewAllScreen({super.key, this.specialtyId});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  final ScrollController _scrollController = ScrollController();

  // Pagination state
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  List<DoctorModel> _doctors = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadFirstPage();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  void _loadFirstPage() {
    setState(() {
      _currentPage = 1;
      _hasMore = true;
      _doctors.clear();
    });
    context.read<SearchCubit>().searchDoctors(
      query: '',
      specialtyId: widget.specialtyId,
      page: 1,
      limit: 10,
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  void _loadMore() {
    if (_isLoadingMore || !_hasMore) return;
    setState(() {
      _isLoadingMore = true;
      _currentPage++;
    });
    context.read<SearchCubit>().searchDoctors(
      query: '',
      specialtyId: widget.specialtyId,
      page: _currentPage,
      limit: 10,
    );
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──────────────────────────────────────────────────
            _buildAppBar(context),

            // ── Fake Search Bar (tappable → SearchScreen) ────────────────
            _buildSearchBar(context),

            verticalSpacing(8),

            // ── Doctor List ──────────────────────────────────────────────
            Expanded(
              child: BlocConsumer<SearchCubit, SearchState>(
                listenWhen: (_, current) =>
                    current is SuccessGetDoctors || current is ErrorGetDoctors,
                listener: (context, state) {
                  state.whenOrNull(
                    successGetDoctors: (response) {
                      setState(() {
                        if (_currentPage == 1) {
                          _doctors = response.doctors;
                        } else {
                          _doctors.addAll(response.doctors);
                        }
                        _hasMore = response.pagination.page <
                            response.pagination.totalPages;
                        _isLoadingMore = false;
                      });
                    },
                    errorGetDoctors: (error) {
                      setState(() => _isLoadingMore = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  );
                },
                buildWhen: (_, current) =>
                    current is LoadingGetDoctors ||
                    current is SuccessGetDoctors ||
                    current is ErrorGetDoctors,
                builder: (context, state) {
                  return state.maybeWhen(
                    loadingGetDoctors: () {
                      if (_currentPage == 1) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: const DoctorsShimmerLoading(),
                        );
                      }
                      return _buildList();
                    },
                    successGetDoctors: (_) => _buildList(),
                    errorGetDoctors: (error) {
                      if (_doctors.isEmpty) {
                        return SearchErrorState(
                          error: error,
                          onRetry: _loadFirstPage,
                        );
                      }
                      return _buildList();
                    },
                    orElse: () => _buildList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── sub-widgets ───────────────────────────────────────────────────────────

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: Colors.white,
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Iconsax.arrow_left_2,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
            ),
          ),

          // Title
          Expanded(
            child: Center(
              child: Text(
                'Best Doctors',
                style: TextStyles.font18DarkGreenBold,
              ),
            ),
          ),

          // Symmetry placeholder
          SizedBox(width: 40.w),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: GestureDetector(
        onTap: () => context.pushNamed(Routes.searchScreen),
        child: Container(
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Iconsax.search_normal_copy,
                color: Colors.grey.shade500,
                size: 20.sp,
              ),
              horizantialSpacing(12),
              Text(
                'Search doctors by name...',
                style: TextStyles.font14GrayRegular,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_doctors.isEmpty) return const SearchEmptyState();

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: _doctors.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _doctors.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: ColorsManager.primaryColor,
              ),
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: GestureDetector(
            onTap: () => context.pushNamed(
              Routes.detailsScreen,
              extra: _doctors[index].id,
            ),
            child: DoctorCard(doctor: _doctors[index]),
          ),
        );
      },
    );
  }
}
