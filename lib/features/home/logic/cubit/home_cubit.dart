import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/data/repos/home_repos.dart';
import 'package:doctor_mate/features/home/logic/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepos) : super(HomeState.initial());
  final HomeRepos _homeRepos;

  // Cache for doctors by specialty
  final Map<String, List<DoctorModel>> _doctorsCache = {};

  Future<void> getHomeData() async {
    await Future.wait([getSpecialties()]);
  }

  Future<void> getSpecialties() async {
    emit(HomeState.getSpecialtiesLoading());
    final result = await _homeRepos.getSpecialties();
    result.when(
      success: (response) {
        emit(HomeState.getSpecialtiesSuccess(specialties: response.data));
        // Automatically select first specialty and fetch its doctors
        if (response.data.isNotEmpty) {
          getDoctorsBySpecialty(specialtyId: response.data.first.id);
        }
      },
      failure: (error) {
        emit(
          HomeState.getSpecialtiesError(message: error.apiErrorModel.message!),
        );
      },
    );
  }

  void getDoctorsBySpecialty({
    required String specialtyId,
    int page = 1,
    int limit = 10,
  }) async {
    // Check if doctors for this specialty are already cached
    if (_doctorsCache.containsKey(specialtyId)) {
      emit(
        HomeState.getDoctorsBySpecialtySuccess(
          doctors: _doctorsCache[specialtyId]!,
        ),
      );
      return;
    }

    emit(HomeState.getDoctorsBySpecialtyLoading());
    final result = await _homeRepos.getDoctorsBySpecialty(
      specialtyId: specialtyId,
      page: page,
      limit: limit,
    );
    result.when(
      success: (response) {
        // Cache the doctors for this specialty
        _doctorsCache[specialtyId] = response.data.doctors;
        emit(
          HomeState.getDoctorsBySpecialtySuccess(
            doctors: response.data.doctors,
          ),
        );
      },
      failure: (error) {
        emit(
          HomeState.getDoctorsBySpecialtyError(
            message: error.apiErrorModel.message!,
          ),
        );
      },
    );
  }

  // Method to clear cache if needed (e.g., on refresh)
  void clearDoctorsCache() {
    _doctorsCache.clear();
  }
}
