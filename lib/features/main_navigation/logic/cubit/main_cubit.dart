import 'package:doctor_mate/features/main_navigation/logic/cubit/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void changeTab(int index) {
    if (state.currentIndex != index) {
      emit(state.copyWith(currentIndex: index));
    }
  }
}
