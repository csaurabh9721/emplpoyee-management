import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/exceptions/api_exceptions.dart';
import '../../../domain/entities/apply_leave_response_entity.dart';
import '../../../domain/entities/save_leave_apply_entity.dart';
import '../../../domain/usecases/save_leave_usecase.dart';

part 'leave_save_state.dart';

class LeaveSaveCubit extends Cubit<LeaveSaveState> {

  LeaveSaveCubit(this._usecase) : super(const InitialLeaveSaveState());
  final SaveLeaveUsecase _usecase;

  void applyLeave(SaveLeaveApplyEntity entity, {File? file}) async {
    emit(const LoadingLeaveSaveState());
    try {
      final ApplyLeaveResponseEntity data = await _usecase.call(entity, file);
      if (data.success) {
        emit(SuccessLeaveSaveState(data.message));
      } else {
        throw AppException(data.message);
      }
    } catch (e) {
      emit(ErrorLeaveSaveState(e.toString()));
    }
  }
}
