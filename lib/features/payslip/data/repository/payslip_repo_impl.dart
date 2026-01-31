import 'dart:typed_data';

import 'package:clientone_ess/features/payslip/data/dataSource/payslip_source.dart';
import 'package:clientone_ess/features/payslip/data/model/payslip_model.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../domain/entity/payslip_entity.dart';
import '../../domain/repository/payslip_repository.dart';

class PayslipRepositoryImpl implements PayslipRepository {
  PayslipRepositoryImpl(this._remotePayslipSource);
  final PayslipSource _remotePayslipSource;

  @override
  Future<PayslipEntity> fetchPayslip(String date) async {
    final PayslipResponseMode response =
        await _remotePayslipSource.getPayslip(date);
    if (response.status != 200) {
      throw AppException(response.message);
    }
    if (response.entity == null) {
      throw AppException("Failed to fetch payslip");
    }
    return response.dtoToEntity();
  }

  @override
  Future<Uint8List> exportPaySlip(String date) {
    return _remotePayslipSource.export(date);
  }
}
