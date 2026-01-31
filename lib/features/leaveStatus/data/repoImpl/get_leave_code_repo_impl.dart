import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/features/leaveStatus/domain/entity/leave_code_entity.dart';

import '../../domain/repository/get_leave_code_repository.dart';
import '../dataSource/leave_code_source.dart';
import '../models/leave_code_model.dart';

class GetLeaveCodeRepositoryImpl implements GetLeaveCodeRepository {
  GetLeaveCodeRepositoryImpl(this._leaveCodeSource);
  final LeaveCodeSource _leaveCodeSource;

  @override
  Future<List<LeaveCode>> getLeaveCodes() async {
    final LeaveCodeResponseModel response =
        await _leaveCodeSource.getLeaveCode();

    if (response.statusCode != 200) {
      throw AppException(response.message);
    }
    if (response.entity == null) {
      throw AppException(response.message);
    }

    return response.toEntity();
  }
}
