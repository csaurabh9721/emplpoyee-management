import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/features/landing/domain/useCases/get_profile_usecase.dart';
import '../../../../core/exceptions/api_exceptions.dart';
import '../../domain/entity/dashboard_response_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/useCases/dashboard_usecase.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc(this._getDashboardDataUseCase, this._getProfileUseCase)
      : super(const LandingInitial()) {
    on<LoadAllDataEvent>(_onLoadAllData);
    on<RefreshDashboard>(_refresh);
  }
  final DashboardUseCase _getDashboardDataUseCase;
  final GetProfileUseCase _getProfileUseCase;



  Future<void> _onLoadAllData(
      LoadAllDataEvent event, Emitter<LandingState> emit) async {
    emit(const LandingLoading());
    try {
      final DashboardResponseEntity dashboardData = await _callDashboardApi();
      //final ProfileResponseEntity profileData = await _callProfileApi();
      //AppConstant.dateOfJoining = profileData.personalDetails.doj;
     //AppConstant.employeeName = profileData.personalDetails.name;
      emit(LandingSuccess( dashboardData));
      //emit(LandingSuccess(state.currentIndex, dashboardData, profileData));
    } catch (e) {
      emit(LandingError(e.toString()));
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
    final  DashboardResponseEntity dashboardData = await _getDashboardDataUseCase.call();
    print(dashboardData);
      return dashboardData;
    } catch (e) {
      debugPrint(e.toString());
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
