import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/smart-checkup/logic/cubit/smart_checkup_cubit.dart';
import 'package:doctor_mate/features/smart-checkup/logic/cubit/smart_checkup_state.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/checkup_app_bar.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/checkup_disclaimer_card.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/checkup_header_card.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/checkup_type_selector.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/image_upload_card.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/symptom_input_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SmartCheckupScreen extends StatefulWidget {
  const SmartCheckupScreen({super.key});

  @override
  State<SmartCheckupScreen> createState() => _SmartCheckupScreenState();
}

class _SmartCheckupScreenState extends State<SmartCheckupScreen> {
  String _selectedCheckType = 'symptom'; // 'symptom' or 'skin'
  final TextEditingController _symptomController = TextEditingController();
  String? _uploadedImagePath;

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

    if (_selectedCheckType == 'skin') {
      context.read<SmartCheckupCubit>().performSkinCheckup(_uploadedImagePath!);
    } else {
      context.read<SmartCheckupCubit>().performSymptomCheckup(
        _symptomController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SmartCheckupCubit, SmartCheckupState>(
      listenWhen:
          (previous, current) =>
              current is SkinCheckupSuccess ||
              current is SymptomCheckupSuccess ||
              current is SkinCheckupFailure ||
              current is SymptomCheckupFailure,
      listener: (context, state) {
        state.whenOrNull(
          skinCheckupSuccess: (response) {
            context.push(
              '${Routes.smartCheckupResultScreen}?checkType=skin',
              extra: response,
            );
          },
          symptomCheckupSuccess: (response) {
            context.push(
              '${Routes.smartCheckupResultScreen}?checkType=symptom',
              extra: response,
            );
          },
          skinCheckupFailure: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error), backgroundColor: Colors.red),
            );
          },
          symptomCheckupFailure: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error), backgroundColor: Colors.red),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const CheckupAppBar(title: 'Smart Checkup'),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CheckupHeaderCard(),
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
                      BlocBuilder<SmartCheckupCubit, SmartCheckupState>(
                        buildWhen: (previous, current) => current is SkinCheckupLoading ||
                            current is SymptomCheckupLoading,
                        builder: (context, state) {
                          final isLoading = state.maybeWhen(
                            skinCheckupLoading: () => true,
                            symptomCheckupLoading: () => true,
                            orElse: () => false,
                          );
                          return CustomMaterialButton(
                            textButton:
                                isLoading ? 'Analyzing...' : 'Check with AI',
                            onPressed: isLoading ? () {} : _handleCheckup,
                            backgroundColor:
                                isLoading
                                    ? ColorsManager.primaryColor.withOpacity(
                                      0.7,
                                    )
                                    : ColorsManager.primaryColor,
                            height: 50.h,
                            raduisBorder: 12,
                          );
                        },
                      ),
                      verticalSpacing(16),
                      const CheckupDisclaimerCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
