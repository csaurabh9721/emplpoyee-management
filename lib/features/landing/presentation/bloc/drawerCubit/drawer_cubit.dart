import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(const DrawerState(isEmpSelfExpanded: true, isGeneralExpanded: true));

  void onExpandedEmpSelf() {
    emit(state.copyWith(isEmpSelfExpanded: !state.isEmpSelfExpanded));
  }

  void onExpandedGeneral() {
    emit(state.copyWith(isGeneralExpanded: !state.isGeneralExpanded));
  }

  @override
  Future<void> close() {
    debugPrint('Drawer Bloc closed');
    return super.close();
  }
}
