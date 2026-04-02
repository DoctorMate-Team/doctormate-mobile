import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/appointment_response_body.dart';
import 'package:doctor_mate/features/booking_appointment/logic/cubit/appointment_cubit.dart';
import 'package:doctor_mate/features/booking_appointment/logic/cubit/appointment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;
  final AppointmentModel appointment;
  final String paymentId;

  const PaymentWebViewScreen({
    super.key,
    required this.paymentUrl,
    required this.appointment,
    required this.paymentId,
  });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  double _loadingProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                if (mounted) {
                  setState(() {
                    _loadingProgress = progress / 100.0;
                  });
                }
              },
              onPageStarted: (String url) {
                setState(() {
                  _isLoading = true;
                });
                _checkCallbackUrl(url);
              },
              onPageFinished: (String url) {
                setState(() {
                  _isLoading = false;
                });
                _checkCallbackUrl(url);
              },
              onNavigationRequest: (NavigationRequest request) {
                if (_checkCallbackUrl(request.url)) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  bool _checkCallbackUrl(String url) {
    final uri = Uri.parse(url);

    // Paymob callback usually contains 'success=true' or 'success=false'
    // in the query parameters after a transaction.
    if (uri.queryParameters.containsKey('success')) {
      final success = uri.queryParameters['success'] == 'true';
      final providerRef =
          uri.queryParameters['id'] ?? uri.queryParameters['order'];

      if (success) {
        // Send success to backend
        context.read<AppointmentCubit>().updatePaymentStatus(
          paymentId: widget.paymentId,
          status: 'success',
          providerRef: providerRef,
        );
      } else {
        // Payment failed or cancelled
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Payment failed or was cancelled',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red.shade400,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              margin: EdgeInsets.all(16.w),
            ),
          );
          context.pop();
        }
      }
      return true;
    }

    // Alternatively check for typical local redirect indicators
    if (url.contains('payment-callback') || url.contains('txn_response_code')) {
      context.read<AppointmentCubit>().updatePaymentStatus(
        paymentId: widget.paymentId,
        status: 'success',
      );
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        state.whenOrNull(
          updatePaymentStatusLoading: () {
            // Optional: Show loading dialog while updating status
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (context) => Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 32.h,
                        horizontal: 24.w,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(
                            color: ColorsManager.primaryColor,
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            'Verifying payment...',
                            style: TextStyles.font16DarkGreenBold,
                          ),
                        ],
                      ),
                    ),
                  ),
            );
          },
          updatePaymentStatusSuccess: () {
            Navigator.pop(context); // Close loading dialog
            if (mounted) {
              context.pushReplacementNamed(
                Routes.bookingConfirmation,
                extra: widget.appointment,
              );
            }
          },
          updatePaymentStatusError: (message) {
            Navigator.pop(context); // Close loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: ColorsManager.warningRed,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                margin: EdgeInsets.all(16.w),
              ),
            );
            if (mounted) {
              context.pop();
            }
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Complete Payment',
            style: TextStyles.font18DarkGreenBold,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorsManager.primaryColor,
            ),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: ColorsManager.primaryColor,
              ),
              onPressed: () {
                _controller.reload();
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_loadingProgress < 1.0)
              Align(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(
                  value: _loadingProgress,
                  backgroundColor: ColorsManager.lighterMainBlue,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    ColorsManager.primaryColor,
                  ),
                  minHeight: 3.h,
                ),
              ),
            if (_isLoading && _loadingProgress == 0)
              Container(
                color: Colors.white.withOpacity(0.8),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
