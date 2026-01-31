import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/login_response_entity.dart';
import '../../domain/entity/user_login_entity.dart';
import '../../domain/usecase/user_login_use_case_impl.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._userLoginUseCase) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginPressed);
  }

  final UserLoginUseCase _userLoginUseCase;

  Future<void> _onLoginPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final LoginResponseEntity loginResponseEntity =
          await _userLoginUseCase.login(event.userLoginEntity);
      Sessions.setEmployeeCode(event.userLoginEntity.code);
      _saveDataInSharedPreferences(loginResponseEntity);
      emit(LoginSuccess(successMessage: "Login Success"));
    } catch (e) {
      emit(LoginError(errorMessage: e.toString()));
    }
  }

  void _saveDataInSharedPreferences(
      LoginResponseEntity loginResponseEntity) async {
    Sessions.setPayrollAreaCode(loginResponseEntity.payrollAreaCode);
    Sessions.setPayrollAreaId(loginResponseEntity.payrollAreaId);
    Sessions.setCompanyId(loginResponseEntity.companyId);
    Sessions.setPayrollUniqueId(loginResponseEntity.payrollUniqueId);
    Sessions.setUserId(loginResponseEntity.userId);
    Sessions.setEmployeeId(loginResponseEntity.employeeId);
    Sessions.setPlaceOfPostingId(loginResponseEntity.placeOfPostingId);
    Sessions.setEmployeeTypeId(loginResponseEntity.employeeTypeId);
    Sessions.setProfitCentreId(loginResponseEntity.profitCentreId);
    Sessions.setProfitCentreCode(loginResponseEntity.profitCentreCode);
    Sessions.setToken(loginResponseEntity.token);

    ///todo set data from api
    Sessions.setMemberType("E");
  }
}
