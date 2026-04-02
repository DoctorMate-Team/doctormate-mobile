import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/payment_history_model.dart';

part 'payment_history_state.freezed.dart';

@freezed
class PaymentHistoryState with _$PaymentHistoryState {
  const factory PaymentHistoryState.initial() = _Initial;
  const factory PaymentHistoryState.loading() = _Loading;
  const factory PaymentHistoryState.success({
    required List<PaymentHistoryModel> payments,
    required bool hasMore,
  }) = _Success;
  const factory PaymentHistoryState.failure(String error) = _Failure;

  const factory PaymentHistoryState.loadingMore({
    required List<PaymentHistoryModel> payments,
  }) = _LoadingMore;
  const factory PaymentHistoryState.loadingMoreFailure({
    required List<PaymentHistoryModel> payments,
    required String error,
  }) = _LoadingMoreFailure;
}
