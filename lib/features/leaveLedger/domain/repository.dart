import 'dart:typed_data';

import 'entity.dart';

abstract class LeaveLedgerRepository {
  Future<List<LeaveLedgerEntity>> getLeaveLedger(String startDate, String endDate);

  Future<Uint8List> exportLeaveLedger(String startDate, String endDate);
}
