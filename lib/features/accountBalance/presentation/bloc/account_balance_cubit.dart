import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/features/accountBalance/domain/account_balance_entity.dart';

import '../../domain/get_account_balance_usecase.dart';

part 'account_balance_state.dart';

class AccountBalanceCubit extends Cubit<AccountBalanceState> {
  AccountBalanceCubit(this._getAccountBalanceUseCase)
      : super(const AccountBalanceInitial());
  final GetAccountBalanceUsecase _getAccountBalanceUseCase;

  Future<void> getAccountBalance() async {
    emit(const AccountBalanceLoading());
    try {
      final List<AccountBalanceEntity> accountBalance =
          await _getAccountBalanceUseCase.call();
      emit(AccountBalanceLoaded(accountBalance));
    } catch (e) {
      emit(AccountBalanceError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    debugPrint('AccountBalanceCubit closed');
    return super.close();
  }
}
