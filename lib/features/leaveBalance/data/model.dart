import '../domain/entity.dart';

class LeaveBalanceModel {

  LeaveBalanceModel({
    required this.statusCode,
    required this.message,
    required this.leaveBalanceDataModel,
  });

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) => LeaveBalanceModel(
        statusCode: json["statuscode"] ?? 400,
        message: json["message"] ?? "Something went wrong",
        leaveBalanceDataModel:
            json["entity"] == null ? null : LeaveBalanceDataModel.fromJson(json["entity"]),
      );
  final int statusCode;
  final String message;
  final LeaveBalanceDataModel? leaveBalanceDataModel;

  List<LeaveBalanceEntity> toEntity() {
    return leaveBalanceDataModel!.leaveBalanceData
        .where((e) => e.paidType.toUpperCase() == "P")
        .toList()
        .map((e) => e.toEntity())
        .toList();
  }
}

class LeaveBalanceDataModel {

  LeaveBalanceDataModel({
    required this.leaveBalanceData,
  });

  factory LeaveBalanceDataModel.fromJson(Map<String, dynamic> json) => LeaveBalanceDataModel(
        leaveBalanceData: json["leaveBalanceData"] == null
            ? []
            : List<LeaveBalanceDatum>.from(
                json["leaveBalanceData"].map((x) => LeaveBalanceDatum.fromJson(x))),
      );
  final List<LeaveBalanceDatum> leaveBalanceData;
}

class LeaveBalanceDatum {

  LeaveBalanceDatum({
    required this.leaveName,
    required this.availed,
    required this.openingBalance,
    required this.balance,
    required this.leaveCredited,
    required this.leaveTypeCode,
    required this.currentAccumulation,
    required this.pendingForApproval,
    required this.openingDate,
    required this.paidType,
  });

  factory LeaveBalanceDatum.fromJson(Map<String, dynamic> json) => LeaveBalanceDatum(
        leaveName: json["leaveName"]?.toString() ?? "Unknown",
        availed: json["aviled"]?.toString() ?? "0.0",
        openingBalance: json["openingbalance"]?.toString() ?? "0.0",
        balance: json["balance"]?.toString() ?? "0.0",
        leaveCredited: json["leavecreditted"]?.toString() ?? "0.0",
        leaveTypeCode: json["leavetypecode"]?.toString() ?? "--",
        currentAccumulation: json["currentaccumlation"]?.toString() ?? "0.0",
        pendingForApproval: json["pendingforapproval"]?.toString() ?? "0.0",
        openingDate: json["openingdate"]?.toString() ?? "0.0",
        paidType: json["paidtype"]?.toString() ?? "0.0",
      );
  final String leaveName;
  final String availed;
  final String openingBalance;
  final String balance;
  final String leaveCredited;
  final String leaveTypeCode;
  final String currentAccumulation;
  final String pendingForApproval;
  final String openingDate;
  final String paidType;

  LeaveBalanceEntity toEntity() {
    return LeaveBalanceEntity(
      openingDate: openingDate,
      leaveTypeCode: leaveTypeCode,
      leaveName: leaveName,
      openingBalance: openingBalance,
      currentAccumulation: currentAccumulation,
      leaveCredited: leaveCredited,
      availed: availed,
      pendingForApproval: pendingForApproval,
      balance: balance,
    );
  }
}
