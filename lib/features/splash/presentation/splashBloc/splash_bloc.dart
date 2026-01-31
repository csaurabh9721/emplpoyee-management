import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/features/splash/presentation/splashBloc/splash_events.dart';

import '../../domain/usecases/get_version.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvents, SplashState> {
  SplashBloc(this._useCase) : super(const SplashInitial()) {
    on<SplashVersionEvent>(_getAppVersion);
    on<SplashNavigate>(_onNavigate);
  }
  final GetVersion _useCase;

  Future<void> _getAppVersion(
      SplashVersionEvent event, Emitter<SplashState> emit) async {
    emit(const SplashLoading());
    try {
      final version = await _useCase.call();
      emit(SplashLoaded(version: version, onNavigate: false));
    } catch (e) {
      emit(const SplashError("Failed to get app version"));
    }
  }

  Future<void> _onNavigate(
      SplashNavigate event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
    final currentState = state;
    if (currentState is SplashLoaded) {
      emit(SplashLoaded(version: currentState.version, onNavigate: true));
    }
  }
}
