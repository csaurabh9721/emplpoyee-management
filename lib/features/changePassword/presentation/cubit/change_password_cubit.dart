import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/change_password_use_case.dart';

part 'Change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {

  ChangePasswordCubit(this._useCase) : super(InitialState());
  final ChangePasswordUseCase _useCase;

  Future<void> callChangePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    emit(LoadingState());
    try {
      final String response = await _useCase.call(oldPassword, newPassword, confirmPassword);
      emit(SuccessState(successMessage: response));
    } catch (e) {

      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
