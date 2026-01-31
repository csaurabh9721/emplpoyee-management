import 'package:clientone_ess/features/accountLedger/domain/entity/gl_entity.dart';

import '../repository/gl_repository.dart';

abstract class GetGlUsecase {
  Future<List<GlEntity>> call();
}

class GetGlUsecaseImpl implements GetGlUsecase {
  GetGlUsecaseImpl(this._repository);
  final GlRepository _repository;

  @override
  Future<List<GlEntity>> call() {
    return _repository.getGl();
  }
}
