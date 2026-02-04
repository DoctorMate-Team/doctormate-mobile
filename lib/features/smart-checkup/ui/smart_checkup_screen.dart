import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/smart-checkup/data/models/symptom_check_response.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/checkup_type_selector.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/image_upload_card.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/symptom_input_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SmartCheckupScreen extends StatefulWidget {
  const SmartCheckupScreen({super.key});

  @override
  State<SmartCheckupScreen> createState() => _SmartCheckupScreenState();
}

class _SmartCheckupScreenState extends State<SmartCheckupScreen> {
  String _selectedCheckType = 'symptom'; // 'symptom' or 'skin'
  final TextEditingController _symptomController = TextEditingController();
  String? _uploadedImagePath;
  bool _isLoading = false;

  @override
  void dispose() {
    _symptomController.dispose();
    super.dispose();
  }

  void _handleCheckup() {
    if (_selectedCheckType == 'symptom' &&
        _symptomController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your symptoms'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedCheckType == 'skin' && _uploadedImagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload an image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate AI processing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Navigate to results with mock data
        final mockResponse = _getMockResponse();
        context.push(
          '${Routes.smartCheckupResultScreen}?checkType=$_selectedCheckType',
          extra: mockResponse,
        );
      }
    });
  }

  SymptomCheckResponse _getMockResponse() {
    if (_selectedCheckType == 'symptom') {
      return SymptomCheckResponse(
        id: 'CHK001',
        patientId: 'P123',
        patientName: 'John Doe',
        checkType: 'symptom',
        symptoms: _symptomController.text,
        createdAt: DateTime.now(),
        diagnosis: DiagnosisResultModel(
          condition: 'Upper Respiratory Tract Infection',
          description:
              'Based on your symptoms, you may have a common cold or upper respiratory infection. This is typically caused by viral infections and usually resolves on its own within 7-10 days.',
          severity: 'mild',
          confidenceScore: 0.85,
          possibleCauses: [
            'Viral infection (most common)',
            'Bacterial infection',
            'Allergic reaction',
            'Environmental irritants',
          ],
          recommendations: [
            'Get plenty of rest',
            'Stay hydrated - drink at least 8 glasses of water daily',
            'Use over-the-counter pain relievers if needed',
            'Gargle with warm salt water for sore throat',
            'Use a humidifier to ease congestion',
            'Avoid smoking and secondhand smoke',
          ],
          warningSymptoms: [
            'Fever above 103°F (39.4°C)',
            'Difficulty breathing or shortness of breath',
            'Chest pain',
            'Symptoms lasting more than 10 days',
            'Severe headache or facial pain',
          ],
          requiresImmediateAttention: false,
        ),
        recommendedDoctors: [
          RecommendedDoctorModel(
            id: 'D001',
            name: 'Dr. Sarah Johnson',
            image:
                'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400',
            specialtyName: 'General Practitioner',
            rating: 4.8,
            reviewCount: 245,
            consultationFee: '\$50',
            experience: '12 years',
            isAvailable: true,
            nextAvailableSlot: 'Today, 2:00 PM',
          ),
          RecommendedDoctorModel(
            id: 'D002',
            name: 'Dr. Michael Chen',
            image:
                'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400',
            specialtyName: 'ENT Specialist',
            rating: 4.9,
            reviewCount: 189,
            consultationFee: '\$75',
            experience: '15 years',
            isAvailable: true,
            nextAvailableSlot: 'Tomorrow, 10:00 AM',
          ),
          RecommendedDoctorModel(
            id: 'D003',
            name: 'Dr. Emily Roberts',
            image:
                'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400',
            specialtyName: 'Internal Medicine',
            rating: 4.7,
            reviewCount: 312,
            consultationFee: '\$60',
            experience: '10 years',
            isAvailable: false,
            nextAvailableSlot: 'Dec 15, 9:00 AM',
          ),
        ],
      );
    } else {
      return SymptomCheckResponse(
        id: 'CHK002',
        patientId: 'P123',
        patientName: 'John Doe',
        checkType: 'skin',
        imageUrl: _uploadedImagePath,
        createdAt: DateTime.now(),
        diagnosis: DiagnosisResultModel(
          condition: 'Contact Dermatitis',
          description:
              'The image analysis suggests contact dermatitis, an inflammatory skin condition caused by contact with an allergen or irritant. The affected area shows typical signs of redness and inflammation.',
          severity: 'moderate',
          confidenceScore: 0.78,
          possibleCauses: [
            'Allergic reaction to cosmetics or skincare products',
            'Contact with irritating chemicals',
            'Jewelry or metal allergies (nickel)',
            'Plants (poison ivy, poison oak)',
            'Latex exposure',
          ],
          recommendations: [
            'Avoid the suspected allergen or irritant',
            'Apply cool, wet compresses to the affected area',
            'Use over-the-counter hydrocortisone cream',
            'Take antihistamines to reduce itching',
            'Keep the area clean and moisturized',
            'Avoid scratching to prevent infection',
          ],
          warningSymptoms: [
            'Spreading rash or severe swelling',
            'Signs of infection (pus, warmth, increased pain)',
            'Difficulty breathing or swallowing',
            'Rash on face, genitals, or large body areas',
            'No improvement after 2-3 weeks',
          ],
          requiresImmediateAttention: false,
        ),
        recommendedDoctors: [
          RecommendedDoctorModel(
            id: 'D004',
            name: 'Dr. Amanda Martinez',
            image:
                'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400',
            specialtyName: 'Dermatologist',
            rating: 4.9,
            reviewCount: 428,
            consultationFee: '\$85',
            experience: '18 years',
            isAvailable: true,
            nextAvailableSlot: 'Today, 3:30 PM',
          ),
          RecommendedDoctorModel(
            id: 'D005',
            name: 'Dr. James Wilson',
            image:
                'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=400',
            specialtyName: 'Dermatologist',
            rating: 4.8,
            reviewCount: 356,
            consultationFee: '\$80',
            experience: '14 years',
            isAvailable: true,
            nextAvailableSlot: 'Tomorrow, 11:00 AM',
          ),
          RecommendedDoctorModel(
            id: 'D006',
            name: 'Dr. Lisa Thompson',
            image:
                'https://images.unsplash.com/photo-1614608682850-e0d6ed316d47?w=400',
            specialtyName: 'Allergist',
            rating: 4.7,
            reviewCount: 267,
            consultationFee: '\$70',
            experience: '11 years',
            isAvailable: false,
            nextAvailableSlot: 'Dec 14, 2:00 PM',
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    verticalSpacing(24),
                    CheckupTypeSelector(
                      selectedType: _selectedCheckType,
                      onTypeChanged: (type) {
                        setState(() {
                          _selectedCheckType = type;
                        });
                      },
                    ),
                    verticalSpacing(24),
                    if (_selectedCheckType == 'symptom')
                      SymptomInputCard(controller: _symptomController)
                    else
                      ImageUploadCard(
                        uploadedImagePath: _uploadedImagePath,
                        onImagePicked: (path) {
                          setState(() {
                            _uploadedImagePath = path;
                          });
                        },
                      ),
                    verticalSpacing(32),
                    CustomMaterialButton(
                      textButton: _isLoading ? 'Analyzing...' : 'Check with AI',
                      onPressed: _isLoading ? () {} : _handleCheckup,
                      backgroundColor:
                          _isLoading
                              ? ColorsManager.primaryColor.withOpacity(0.7)
                              : ColorsManager.primaryColor,
                      height: 50.h,
                      raduisBorder: 12,
                    ),
                    verticalSpacing(16),
                    _buildDisclaimerCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
            ),
          ),
          horizantialSpacing(12),
          Text('Smart Checkup', style: TextStyles.font18DarkGreenBold),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFEA4335), Color(0xFFD32F2F)],
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEA4335).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Iconsax.heart_add, color: Colors.white, size: 28.sp),
        ),
        verticalSpacing(16),
        Text('AI-Powered Health Check', style: TextStyles.font20GreenBold),
        verticalSpacing(8),
        Text(
          'Describe your symptoms or upload a skin image for instant AI analysis and doctor recommendations',
          style: TextStyles.font14DarkGreenMedium.copyWith(
            color: Colors.grey.shade600,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDisclaimerCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.amber.shade200, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Iconsax.danger, color: Colors.amber.shade700, size: 20.sp),
          horizantialSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Important Notice',
                  style: TextStyles.font14GreenSemiBold.copyWith(
                    color: Colors.amber.shade900,
                  ),
                ),
                verticalSpacing(4),
                Text(
                  'This AI analysis is for informational purposes only and does not replace professional medical advice. Please consult a qualified healthcare provider for accurate diagnosis and treatment.',
                  style: TextStyles.font12DarkGreenRegular.copyWith(
                    color: Colors.amber.shade800,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
