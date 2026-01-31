import '../domain/account_balance_entity.dart';

class AccountBalanceModel {

  AccountBalanceModel({required this.statusCode, required this.message, required this.data});

  factory AccountBalanceModel.fromJson(Map<String, dynamic> json) {
    return AccountBalanceModel(
      statusCode: json['statuscode'] ?? 400,
      message: json['message'] ?? "Something went wrong",
      data: json['entity'] == null ? null : Entity.fromJson(json['entity']),
    );
  }
  final int statusCode;
  final String message;
  final Entity? data;

  List<AccountBalanceEntity> toEntity() {
    return data!.accountBalanceList.map((e) => e.toEntity()).toList();
  }
}

class Entity {

  Entity({
    required this.accountBalanceList,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        accountBalanceList: json["accountbalanceList"] == null
            ? []
            : List<AccountBalanceListModel>.from(json["accountbalanceList"].map((x) => AccountBalanceListModel.fromJson(x))),
      );
  final List<AccountBalanceListModel> accountBalanceList;
}

class AccountBalanceListModel {

  AccountBalanceListModel({
    required this.glCode,
    required this.slid,
    required this.balance,
    required this.glDescription,
    required this.creditAmount,
    required this.debitAmount,
  });

  factory AccountBalanceListModel.fromJson(Map<String, dynamic> json) => AccountBalanceListModel(
        glCode: json["glcode"] ?? "",
        slid: json["slid"] ?? "",
        balance: json["balance"] ?? "0.00",
        glDescription: json["gldescription"] ?? "",
        creditAmount: json["creditamount"] ?? "0.00",
        debitAmount: json["debitamount"] ?? "0.00",
      );
  final String glCode;
  final String slid;
  final String balance;
  final String glDescription;
  final String creditAmount;
  final String debitAmount;

  AccountBalanceEntity toEntity() {
    return AccountBalanceEntity(gl: glDescription, glCode: glCode, credit: creditAmount, debit: debitAmount);
  }
}
