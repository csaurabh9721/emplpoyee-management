import 'dart:typed_data';

import 'package:clientone_ess/features/leaveLedger/domain/entity.dart';

import '../../../core/exceptions/api_exceptions.dart';
import '../domain/repository.dart';
import 'data_source.dart';
import 'model.dart';

class LeaveLedgerRepositoryImpl extends LeaveLedgerRepository {
  LeaveLedgerRepositoryImpl(this._source);
  final LeaveLedgerSource _source;

  @override
  Future<Uint8List> exportLeaveLedger(String startDate, String endDate) async {
    return await _source.exportLeaveLedger(startDate, endDate);
  }

  @override
  Future<List<LeaveLedgerEntity>> getLeaveLedger(
      String startDate, String endDate) async {
    final ViewLeaveLedgerModel response =
        await _source.fetchLeaveLedger(startDate, endDate);
    if (response.statusCode != "200") {
      throw AppException("${response.statusCode}: ${response.message}");
    }
    if (response.entity == null) {
      throw AppException("${response.statusCode}: ${response.message}");
    }
    return response.entity!.toEntity();
  }
}
