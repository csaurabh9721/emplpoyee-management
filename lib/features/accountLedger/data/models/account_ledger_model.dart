import '../../domain/entity/account_ledger_entity.dart';

class AccountLedgerResponseModel {

  AccountLedgerResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AccountLedgerResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountLedgerResponseModel(
      statusCode: json['statuscode'] ?? 400,
      message: json['message'] ?? "",
      data: json['entity'] == null ? null : AccountLedgerModel.fromJson(json['entity']),
    );
  }
  final int statusCode;
  final String message;
  final AccountLedgerModel? data;

  AccountLedgerEntity toEntity() {
    return AccountLedgerEntity(
      openingBalance: data!.openingBalance,
      closingBalance: data!.closingBalance,
      voucherDetail: data!.voucherDetail.map((e) => e.toEntity()).toList(),
    );
  }
}

class AccountLedgerModel {

  AccountLedgerModel({
    required this.openingBalance,
    required this.closingBalance,
    required this.voucherDetail,
  });

  factory AccountLedgerModel.fromJson(Map<String, dynamic> json) {
    return AccountLedgerModel(
      openingBalance: json['openingBalance'] ?? "",
      closingBalance: json['closingBalance'] ?? "",
      voucherDetail: List<VoucherDetailModel>.from(
        json['voucherList']?.map((x) => VoucherDetailModel.fromJson(x)) ?? [],
      ),
    );
  }
  final String openingBalance;
  final String closingBalance;
  final List<VoucherDetailModel> voucherDetail;
}

class VoucherDetailModel {

  VoucherDetailModel({
    required this.voucherNo,
    required this.voucherType,
    required this.referenceNo,
    required this.balance,
    required this.narration,
    required this.voucherDate,
    required this.creditAmount,
    required this.debitAmount,
  });

  factory VoucherDetailModel.fromJson(Map<String, dynamic> json) {
    return VoucherDetailModel(
      voucherNo: json["voucherno"] ?? "",
      voucherType: json["vouchertype"] ?? "",
      referenceNo: json["referenceno"] ?? "",
      balance: json["balance"] ?? "0",
      narration: json["narration"] ?? "",
      voucherDate: json["voucherdate"] ?? "0.0",
      creditAmount: json["creditamount"] ?? "0.0",
      debitAmount: json["debitamount"] ?? "0.0",
    );
  }
  final String voucherNo;
  final String voucherType;
  final String referenceNo;
  final String balance;
  final String narration;
  final String voucherDate;
  final String creditAmount;
  final String debitAmount;

  VoucherDetailEntity toEntity() {
    return VoucherDetailEntity(
      type: voucherType,
      number: voucherNo,
      date: voucherDate,
      reference: referenceNo,
      description: narration,
      credit: creditAmount,
      debit: debitAmount,
    );
  }
}
