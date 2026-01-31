import '../domain/entity.dart';

class ViewLeaveLedgerModel {

  ViewLeaveLedgerModel({
    required this.statusCode,
    required this.message,
    required this.entity,
  });

  factory ViewLeaveLedgerModel.fromJson(Map<String, dynamic> json) => ViewLeaveLedgerModel(
        statusCode: json["statuscode"]?.toString() ?? "400",
        message: json["message"] ?? "Something went wrong",
        entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
      );
  final String statusCode;
  final String message;
  final Entity? entity;
}

class Entity {

  Entity({
    required this.leaveLedgerData,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        leaveLedgerData: json["leaveLedgerData"] == null
            ? []
            : List<LeaveLedgerDatum>.from(
                json["leaveLedgerData"].map((x) => LeaveLedgerDatum.fromJson(x))),
      );
  final List<LeaveLedgerDatum> leaveLedgerData;

  List<LeaveLedgerEntity> toEntity() {
    return leaveLedgerData.map((e) => e.toEntity()).toList();
  }
}

class LeaveLedgerDatum {

  LeaveLedgerDatum({
    required this.leaveShortName,
    required this.leaveDescription,
    required this.total,
    required this.leaveEndDate,
    required this.leaveStartDate,
  });

  factory LeaveLedgerDatum.fromJson(Map<String, dynamic> json) => LeaveLedgerDatum(
        leaveShortName: json["leaveshortname"] ?? "",
        leaveDescription: json["leavedescription"] ?? "",
        total: json["total"]?.toDouble() ?? 0.0,
        leaveEndDate: json["leavenddate"] ?? "",
        leaveStartDate: json["leavestartdate"] ?? "",
      );
  final String leaveShortName;
  final String leaveDescription;
  final double total;
  final String leaveEndDate;
  final String leaveStartDate;

  LeaveLedgerEntity toEntity() {
    return LeaveLedgerEntity(
      leaveShortName: leaveShortName,
      leaveDescription: leaveDescription,
      total: total,
      leaveEndDate: leaveEndDate,
      leaveStartDate: leaveStartDate,
    );
  }
}
