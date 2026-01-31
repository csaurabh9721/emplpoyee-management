import 'dart:typed_data';

import 'package:clientone_ess/features/leaveLedger/domain/repository.dart';

import 'entity.dart';

abstract class LeaveLedgerUsecase {
  Future<List<LeaveLedgerEntity>> getLeaveLedger(
      String startDate, String endDate);

  Future<Uint8List> exportLeaveLedger(String startDate, String endDate);
}

class LeaveLedgerUsecaseImpl implements LeaveLedgerUsecase {
  LeaveLedgerUsecaseImpl(this._repository);
  final LeaveLedgerRepository _repository;

  @override
  Future<Uint8List> exportLeaveLedger(String startDate, String endDate) {
    return _repository.exportLeaveLedger(startDate, endDate);
  }

  @override
  Future<List<LeaveLedgerEntity>> getLeaveLedger(
      String startDate, String endDate) {
    return _repository.getLeaveLedger(startDate, endDate);
  }
}
