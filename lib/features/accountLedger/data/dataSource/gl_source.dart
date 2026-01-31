import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../models/gl_model.dart';

abstract class GlSource {
  Future<GlResponseModel> getGl();
}

class GlSourceImpl implements GlSource {
  @override
  Future<GlResponseModel> getGl() async {
    try {
      final Map<String, dynamic> json =
          await PostApiBase.instance.post(url: NetworkConfig.subGlCode);
      return GlResponseModel.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
