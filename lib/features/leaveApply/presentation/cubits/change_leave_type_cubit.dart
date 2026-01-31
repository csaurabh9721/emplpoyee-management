import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/leave_balance_entity.dart';

@immutable
class ChangeLeaveTypeState {

  const ChangeLeaveTypeState({this.leaveBalance});
  final LeaveListEntity? leaveBalance;
}

class ChangeLeaveTypeCubit extends Cubit<ChangeLeaveTypeState> {
  ChangeLeaveTypeCubit() : super(const ChangeLeaveTypeState());

  void changeLeveType(LeaveListEntity? entity) {
    emit(ChangeLeaveTypeState(leaveBalance: entity));
  }
}
