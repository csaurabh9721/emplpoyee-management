import 'dart:io';

import '../entities/apply_leave_response_entity.dart';
import '../entities/save_leave_apply_entity.dart';
import '../repo/apply_leave_repo.dart';

abstract class SaveLeaveUsecase {
  Future<ApplyLeaveResponseEntity> call(SaveLeaveApplyEntity requestEntity, File? file);
}

class SaveLeaveUsecaseImpl implements SaveLeaveUsecase {

  SaveLeaveUsecaseImpl(this._repo);
  final ApplyLeaveRepo _repo;

  @override
  Future<ApplyLeaveResponseEntity> call(SaveLeaveApplyEntity requestEntity, File? file) {
    return _repo.applyLeave(requestEntity, file);
  }
}
