import 'package:doctor_mate/features/search/data/repos/search_repos.dart';
import 'package:doctor_mate/features/search/logic/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._searchRepos) : super(SearchState.initial());
  final SearchRepos _searchRepos;

  void searchDoctors({
    required String query,
    String? specialtyId,
    String? sort,
    int page = 1,
    int limit = 10,
  }) async {
    emit(SearchState.loadingGetDoctors());
    final result = await _searchRepos.searchDoctors(
      query: query,
      specialtyId: specialtyId,
      sort: sort,
      page: page,
      limit: limit,
    );
    result.when(
      success: (response) {
        emit(
          SearchState.successGetDoctors(doctorSpecialtyResponse: response.data),
        );
      },
      failure: (error) {
        emit(SearchState.errorGetDoctors(error.apiErrorModel.message!));
      },
    );
  }

  void getSpecialties() async {
    emit(SearchState.loadingGetSpecialties());
    final result = await _searchRepos.getSpecialties();
    result.when(
      success: (response) {
        emit(SearchState.successGetSpecialties(specialties: response.data));
      },
      failure: (error) {
        emit(SearchState.errorGetSpecialties(error.apiErrorModel.message!));
      },
    );
  }
}
