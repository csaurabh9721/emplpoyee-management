import '../domain/entity.dart';

class LeaveHistoryModel {

  LeaveHistoryModel({required this.statusCode, required this.message, required this.data});

  factory LeaveHistoryModel.fromJson(Map<String, dynamic> json) {
    return LeaveHistoryModel(
      statusCode: json['statuscode']?.toString() ?? "400",
      message: json['message'] ?? "Something went wrong.",
      data: json['entity'] != null
          ? LeaveHistoryResponseEntity.fromJson(json['entity'])
          : null,
    );
  }
  final String statusCode;
  final String message;
  final LeaveHistoryResponseEntity? data;

  List<LeaveHistoryEntity> dtoToList() {
    final List<LeaveHistoryEntity> list = [];
    for (LeaveHistoryListModel e in data!.leaveHistoryList) {
      list.add(LeaveHistoryEntity(
        startDate: e.startDate,
        endDate: e.endDate,
        type: e.type,
        days: e.days,
      ));
    }
    return list;
  }
}
class LeaveHistoryResponseEntity {

  LeaveHistoryResponseEntity({
    required this.leaveHistoryList,
  });

  factory LeaveHistoryResponseEntity.fromJson(Map<String, dynamic> json) => LeaveHistoryResponseEntity(
    leaveHistoryList: List<LeaveHistoryListModel>.from(json["leaveHistoryList"].map((x) => LeaveHistoryListModel.fromJson(x))),
  );
  final List<LeaveHistoryListModel> leaveHistoryList;
}

class LeaveHistoryListModel {

  LeaveHistoryListModel(
      {required this.startDate, required this.endDate, required this.type, required this.days});

  factory LeaveHistoryListModel.fromJson(Map<String, dynamic> json) {
    return LeaveHistoryListModel(
      startDate: json['startdate']?.toString() ?? "",
      endDate: json['enddate']?.toString() ?? "",
      type: json['leavetype']?.toString() ?? "",
      days: json['noofdays']?.toString() ?? "",
    );
  }
  final String startDate;
  final String endDate;
  final String type;
  final String days;
}
