import '../../domain/entity/gl_entity.dart';

class GlResponseModel {

  GlResponseModel({
    required this.statusCode,
    required this.message,
    required this.entity,
  });

  factory GlResponseModel.fromJson(Map<String, dynamic> json) {
    return GlResponseModel(
      statusCode: json['statuscode'] ?? 400,
      message: json['messasge'] ?? "Failed to fetch data",
      entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
    );
  }
  final int statusCode;
  final String message;
  final Entity? entity;

  List<GlEntity> toEntity() {
    return entity!.glCodeList.map((e) => e.toEntity()).toList();
  }
}

class Entity {

  Entity({
    required this.glCodeList,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        glCodeList: json["glcodelist"] == null
            ? []
            : List<GlModel>.from(json["glcodelist"].map((x) => GlModel.fromJson(x))),
      );
  final List<GlModel> glCodeList;
}

class GlModel {

  GlModel({
    required this.glId,
    required this.gl,
    required this.glCode,
  });

  factory GlModel.fromJson(Map<String, dynamic> json) => GlModel(
        glId: json["glid"],
        glCode: json["glcode"],
        gl: json["gldescription"],
      );
  final String glId;
  final String gl;
  final String glCode;

  GlEntity toEntity() {
    return GlEntity(
      glId: glId,
      gl: gl,
      glCode: glCode,
    );
  }
}
