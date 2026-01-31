import 'package:clientone_ess/features/splash/domain/usecases/get_version.dart';

import '../repository/splash_repo.dart';

class GetVersionImpl implements GetVersion {
  GetVersionImpl(this.repository);
  final SplashRepository repository;

  @override
  Future<String> call() {
    return repository.getAppVersion();
  }
}
