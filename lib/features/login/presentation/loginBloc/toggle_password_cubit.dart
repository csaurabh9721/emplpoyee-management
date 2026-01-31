import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc.dart';


class TogglePasswordCubit extends Cubit<TogglePasswordState> {
  TogglePasswordCubit() : super(TogglePasswordState(isVisible: false));
  void togglePasswordVisibility() {
    emit(TogglePasswordState(isVisible: !state.isVisible));
  }
}
