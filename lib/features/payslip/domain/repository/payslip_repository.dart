import 'dart:typed_data';

import '../entity/payslip_entity.dart';

abstract class PayslipRepository {
  Future<PayslipEntity> fetchPayslip(String date);
  Future<Uint8List> exportPaySlip(String date);
}
