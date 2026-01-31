import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/features/accountLedger/domain/entity/gl_entity.dart';
import 'package:clientone_ess/features/accountLedger/domain/repository/gl_repository.dart';

import '../dataSource/gl_source.dart';
import '../models/gl_model.dart';

class GlRepositoryImpl implements GlRepository {
  GlRepositoryImpl(this._remoteGlSource);
  final GlSource _remoteGlSource;

  @override
  Future<List<GlEntity>> getGl() async {
    final GlResponseModel response = await _remoteGlSource.getGl();
    if (response.statusCode != 200) {
      throw Exception(response.message);
    }
    if (response.entity == null) {
      throw AppException(response.message);
    }
    return response.toEntity();
  }
}
