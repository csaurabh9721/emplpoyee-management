import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/Enums/enums.dart';

@immutable
class StartPeriodState {
  const StartPeriodState(this.leaveStartPeriod);
  final LeaveStartPeriod leaveStartPeriod;
}

class StartPeriodCubit extends Cubit<StartPeriodState> {
  StartPeriodCubit() : super(const StartPeriodState(LeaveStartPeriod.firstHalf));

  LeaveStartPeriod _selectedPeriod = LeaveStartPeriod.firstHalf;
  void toggleLeaveStartPeriod(LeaveStartPeriod period) {
    _selectedPeriod = period;
    emit(StartPeriodState(period));
  }
  LeaveStartPeriod get selectedPeriod => _selectedPeriod;
}
