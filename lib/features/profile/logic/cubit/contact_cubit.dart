import 'package:doctor_mate/features/profile/logic/cubit/contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(const ContactState.initial());

  Future<void> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    emit(const ContactState.submitContactLoading());

    try {
      // TODO: Implement actual API call when backend is ready
      // Simulating API call
      await Future.delayed(const Duration(seconds: 2));

      // For now, just return success
      // In production, replace with:
      // final result = await _contactRepos.submitContactForm(
      //   name: name,
      //   email: email,
      //   subject: subject,
      //   message: message,
      // );
      // result.when(
      //   success: (_) => emit(const ContactState.submitContactSuccess()),
      //   failure: (error) => emit(ContactState.submitContactError(
      //     message: error.apiErrorModel.message!,
      //   )),
      // );

      if (!isClosed) {
        emit(const ContactState.submitContactSuccess());
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          ContactState.submitContactError(
            message: 'Failed to submit contact form: ${e.toString()}',
          ),
        );
      }
    }
  }
}
