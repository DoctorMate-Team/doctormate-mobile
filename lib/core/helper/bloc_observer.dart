import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

const bool _logBlocChanges = bool.fromEnvironment(
  'LOG_BLOC_CHANGES',
  defaultValue: false,
);

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode && _logBlocChanges) {
      debugPrint('onChange -- ${bloc.runtimeType}, $change');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode && _logBlocChanges) {
      debugPrint('onClose -- ${bloc.runtimeType}');
    }
  }
}
