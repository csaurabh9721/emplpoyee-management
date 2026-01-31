import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/forget_password_use_case.dart';
part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {

  ForgetPasswordCubit(this._useCase) : super(InitialState());
  final ForgetPasswordUseCase _useCase;

  Future<void> callForgetPassword(String empCode, String dob) async {
    emit(LoadingState());
    try {
      final String response =
          await _useCase.call(empCode, dob);
      emit(SuccessState(successMessage: response));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
