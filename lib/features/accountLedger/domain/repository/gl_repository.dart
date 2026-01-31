import '../entity/gl_entity.dart';

abstract class GlRepository {
  Future<List<GlEntity>> getGl();
}
