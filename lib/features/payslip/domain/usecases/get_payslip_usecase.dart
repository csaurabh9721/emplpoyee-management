import 'dart:typed_data';

import '../entity/payslip_entity.dart';
import '../repository/payslip_repository.dart';

abstract class GetPayslipUseCase {
  Future<PayslipEntity> callGetPayslip(String date);

  Future<Uint8List> callExportPaySlip(String date);
}

class GetPayslipUseCaseImpl implements GetPayslipUseCase {

  GetPayslipUseCaseImpl(this._repository);
  final PayslipRepository _repository;

  @override
  Future<PayslipEntity> callGetPayslip(String date) async {
    return await _repository.fetchPayslip(date);
  }

  @override
  Future<Uint8List> callExportPaySlip(String date) {
    return _repository.exportPaySlip(date);
  }
}
