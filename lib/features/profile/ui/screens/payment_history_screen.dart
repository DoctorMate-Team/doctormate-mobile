import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/profile/data/models/payment_history_model.dart';
import 'package:doctor_mate/features/profile/logic/payment_history_cubit/payment_history_cubit.dart';
import 'package:doctor_mate/features/profile/logic/payment_history_cubit/payment_history_state.dart';
import 'package:doctor_mate/features/profile/ui/widgets/payment_history_card.dart';
import 'package:doctor_mate/features/profile/ui/widgets/payment_history_empty_state.dart';
import 'package:doctor_mate/features/profile/ui/widgets/payment_history_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<PaymentHistoryModel> _allPayments = [];
  List<PaymentHistoryModel> _filteredPayments = [];
  bool _isInitLoaded = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PaymentHistoryCubit>().getMyPayments(isLoadMore: true);
    }
  }

  void _filterPayments(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPayments = _allPayments;
      } else {
        _filteredPayments =
            _allPayments
                .where(
                  (payment) =>
                      payment.doctorName.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      payment.appointmentType.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      payment.status.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: ColorsManager.primaryColor,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text('Payment History', style: TextStyles.font18DarkGreenBold),
      ),
      body: SafeArea(
        child: BlocConsumer<PaymentHistoryCubit, PaymentHistoryState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (payments, hasMore) {
                setState(() {
                  _allPayments = payments;
                  _isInitLoaded = true;
                  _filterPayments(_searchController.text);
                });
              },
              loadingMoreFailure: (payments, error) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(error)));
              },
              failure: (error) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(error)));
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            bool isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
            bool isLoadMore = state.maybeWhen(
              loadingMore: (_) => true,
              orElse: () => false,
            );

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                children: [
                  // Content
                  Expanded(
                    child:
                        isLoading && !_isInitLoaded
                            ? const PaymentHistoryShimmerLoading()
                            : RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<PaymentHistoryCubit>()
                                    .getMyPayments();
                              },
                              child:
                                  _filteredPayments.isEmpty
                                      ? ListView(
                                        children: [
                                          verticalSpacing(100),
                                          PaymentHistoryEmptyState(
                                            isSearching:
                                                _searchController
                                                    .text
                                                    .isNotEmpty,
                                          ),
                                        ],
                                      )
                                      : ListView.builder(
                                        controller: _scrollController,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                        ),
                                        itemCount:
                                            _filteredPayments.length +
                                            (isLoadMore ? 1 : 0),
                                        itemBuilder: (context, index) {
                                          if (index ==
                                              _filteredPayments.length) {
                                            return const Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          }

                                          return PaymentHistoryCard(
                                            payment: _filteredPayments[index],
                                          );
                                        },
                                      ),
                            ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
