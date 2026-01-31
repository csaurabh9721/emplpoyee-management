import 'dart:io';
import '../../../../core/exceptions/api_exceptions.dart';
import '../../domain/entities/apply_leave_response_entity.dart';
import '../../domain/entities/save_leave_apply_entity.dart';
import '../../domain/repo/apply_leave_repo.dart';
import '../dataSources/apply_leave_source.dart';
import '../models/apply_leave_response_model.dart';
import '../models/save_leave_apply_model.dart';



class ApplyLeaveRepoImpl implements ApplyLeaveRepo {

  ApplyLeaveRepoImpl(this._source);
  final ApplyLeaveSource _source;



  @override
  Future<ApplyLeaveResponseEntity> applyLeave(SaveLeaveApplyEntity requestEntity,File? file) async {
    final ApplyLeaveResponseModel response =
    await _source.apply(SaveLeaveApplyModel.copyWith(requestEntity),file);
    if (response.statusCode != 200) {
      throw AppException(response.message);
    }
    return response.dtoToEntity();
  }
}
