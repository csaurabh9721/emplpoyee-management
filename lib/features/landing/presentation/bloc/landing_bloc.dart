import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/features/landing/domain/useCases/get_profile_usecase.dart';
import 'package:clientone_ess/shared/constants/app_constant.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../domain/entity/dashboard_response_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/useCases/dashboard_usecase.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc(this._getDashboardDataUseCase, this._getProfileUseCase)
      : super(const LandingInitial(0)) {
    on<LandingPageChangeEvent>(_onPageChanged);
    on<LoadAllDataEvent>(_onLoadAllData);
    on<RefreshDashboard>(_refresh);
  }
  final DashboardUseCase _getDashboardDataUseCase;
  final GetProfileUseCase _getProfileUseCase;

  void _onPageChanged(
      LandingPageChangeEvent event, Emitter<LandingState> emit) {
    final current = state;
    if (current is LandingSuccess) {
      emit(current.copyWith(currentIndex: event.index));
    } else {
      emit(LandingError(event.index, 'Something went wrong'));
    }
  }

  Future<void> _onLoadAllData(
      LoadAllDataEvent event, Emitter<LandingState> emit) async {
    emit(LandingLoading(state.currentIndex));
    try {
      final DashboardResponseEntity dashboardData = await _callDashboardApi();
      final ProfileResponseEntity profileData = await _callProfileApi();
      AppConstant.dateOfJoining = profileData.personalDetails.doj;
      AppConstant.employeeName = profileData.personalDetails.name;
      emit(LandingSuccess(state.currentIndex, dashboardData, profileData));
    } catch (e) {
      emit(LandingError(state.currentIndex, e.toString()));
    }
  }

  Future<void> _refresh(
      RefreshDashboard event, Emitter<LandingState> emit) async {
    final current = state;
    if (current is LandingSuccess) {
      final DashboardResponseEntity dashboardData = await _callDashboardApi();
      emit(current.copyWith(dahBoardData: dashboardData));
    }
  }

  Future<DashboardResponseEntity> _callDashboardApi() async {
    try {
      return await _getDashboardDataUseCase.call();
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<ProfileResponseEntity> _callProfileApi() async {
    try {
      return await _getProfileUseCase.call();
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<void> close() {
    debugPrint('LandingBloc closed');
    return super.close();
  }
}
