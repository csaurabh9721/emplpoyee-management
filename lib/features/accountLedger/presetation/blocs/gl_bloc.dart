import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/gl_entity.dart';
import '../../domain/useCases/get_gl_usecase.dart';
import 'account_ledger_state.dart';
import 'gl_event.dart';

class GlBloc extends Bloc<GlEvent, AccountLedgerState> {

  GlBloc(this._usecase) : super(const AccountLedgerInitial()) {
    on<GlLoadEvent>(_getGl);
  }
  final GetGlUsecase _usecase;

  void _getGl(GlLoadEvent event, Emitter<AccountLedgerState> emit) async {
    emit(const AccountLedgerLoading());
    try {
      final List<GlEntity> result = await _usecase.call();
      emit(AccountLedgerGLLoaded(glEntity: result));
    } catch (e) {
      emit(AccountLedgerError(e.toString()));
    }
  }

}
