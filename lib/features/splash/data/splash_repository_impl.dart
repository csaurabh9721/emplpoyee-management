import 'package:package_info_plus/package_info_plus.dart';

import '../domain/repository/splash_repo.dart';

class SplashRepositoryImpl implements SplashRepository {
  @override
  Future<String> getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;
    return '$version ($buildNumber)';
  }
}
