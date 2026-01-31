import 'dart:io';

import '../entities/apply_leave_response_entity.dart';
import '../entities/save_leave_apply_entity.dart';


abstract class ApplyLeaveRepo {
  Future<ApplyLeaveResponseEntity> applyLeave(SaveLeaveApplyEntity requestEntity,File? file);
}
