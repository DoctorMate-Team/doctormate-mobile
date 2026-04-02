import 'package:doctor_mate/features/profile/data/models/payment_history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/profile_repos.dart';
import 'payment_history_state.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  final ProfileRepos _profileRepos;

  PaymentHistoryCubit(this._profileRepos)
    : super(const PaymentHistoryState.initial());

  int _currentPage = 1;
  static const int _limit = 10;
  bool _hasMore = true;
  List<PaymentHistoryModel> _payments = [];
  bool _isLoading = false;

  Future<void> getMyPayments({bool isLoadMore = false}) async {
    if (_isLoading) return;

    if (!isLoadMore) {
      _currentPage = 1;
      _hasMore = true;
      _payments = [];
      emit(const PaymentHistoryState.loading());
    } else {
      if (!_hasMore) return;
      emit(PaymentHistoryState.loadingMore(payments: _payments));
    }

    _isLoading = true;

    final response = await _profileRepos.getMyPayments(
      page: _currentPage,
      limit: _limit,
    );

    if (isClosed) return;

    response.when(
      success: (data) {
        final newPayments = data.data.payments;
        final totalResults = data.data.pagination.totalItems;

        _payments.addAll(newPayments);

        _hasMore = _payments.length < totalResults;

        if (_hasMore) {
          _currentPage++;
        }

        emit(
          PaymentHistoryState.success(payments: _payments, hasMore: _hasMore),
        );
      },
      failure: (error) {
        if (!isLoadMore) {
          emit(PaymentHistoryState.failure(error.apiErrorModel.message ?? ''));
        } else {
          emit(
            PaymentHistoryState.loadingMoreFailure(
              payments: _payments,
              error: error.apiErrorModel.message ?? '',
            ),
          );
        }
      },
    );

    _isLoading = false;
  }
}
