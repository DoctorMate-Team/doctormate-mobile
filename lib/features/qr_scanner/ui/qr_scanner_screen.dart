import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:doctor_mate/core/routing/routes.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture capture) {
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? code = barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;

    setState(() => _isProcessing = true);

    // Assuming the QR code contains the doctor ID
    // You can adjust this logic based on your QR code format
    _navigateToDoctorDetails(code);
  }

  void _navigateToDoctorDetails(String doctorId) {
    // Validate if it's a valid doctor ID format (adjust as needed)
    if (doctorId.isEmpty) {
      _showErrorSnackBar('Invalid QR code');
      setState(() => _isProcessing = false);
      return;
    }

    // Navigate to doctor details screen with the scanned doctor ID
    context.pop(); // Close scanner
    context.pushNamed(Routes.detailsScreen, extra: doctorId);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: Center(
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
              ),
            ),
          ),
        ),
        title: Text(
          'Scan QR Code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w, top: 8.h, bottom: 8.h),
            child: Center(
              child: GestureDetector(
                onTap: () => _controller.toggleTorch(),
                child: Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.flashlight_on,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Scanner
          MobileScanner(controller: _controller, onDetect: _handleBarcode),

          // Overlay with scanning frame
          CustomPaint(painter: ScannerOverlayPainter(), child: Container()),

          // Instructions
          Positioned(
            bottom: 100.h,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    color: ColorsManager.primaryColor,
                    size: 32.sp,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Position the QR code within the frame',
                    style: TextStyles.font14DarkGreenMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Doctor information will load automatically',
                    style: TextStyles.font12GrayRegular,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the scanning overlay
class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double scanAreaSize = size.width * 0.7;
    final double left = (size.width - scanAreaSize) / 2;
    final double top = (size.height - scanAreaSize) / 2;

    // Draw semi-transparent overlay
    final backgroundPaint =
        Paint()
          ..color = Colors.black.withOpacity(0.5)
          ..style = PaintingStyle.fill;

    final scanAreaRect = Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize);

    // Draw the overlay with a hole for the scan area
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addRRect(
          RRect.fromRectAndRadius(scanAreaRect, const Radius.circular(20)),
        ),
      ),
      backgroundPaint,
    );

    // Draw corner brackets
    final bracketPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;

    final cornerLength = 40.0;
    final corners = [
      // Top-left
      [
        Offset(left, top + cornerLength),
        Offset(left, top),
        Offset(left + cornerLength, top),
      ],
      // Top-right
      [
        Offset(left + scanAreaSize - cornerLength, top),
        Offset(left + scanAreaSize, top),
        Offset(left + scanAreaSize, top + cornerLength),
      ],
      // Bottom-left
      [
        Offset(left, top + scanAreaSize - cornerLength),
        Offset(left, top + scanAreaSize),
        Offset(left + cornerLength, top + scanAreaSize),
      ],
      // Bottom-right
      [
        Offset(left + scanAreaSize - cornerLength, top + scanAreaSize),
        Offset(left + scanAreaSize, top + scanAreaSize),
        Offset(left + scanAreaSize, top + scanAreaSize - cornerLength),
      ],
    ];

    for (var corner in corners) {
      final path =
          Path()
            ..moveTo(corner[0].dx, corner[0].dy)
            ..lineTo(corner[1].dx, corner[1].dy)
            ..lineTo(corner[2].dx, corner[2].dy);
      canvas.drawPath(path, bracketPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
