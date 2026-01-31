class AccountLedgerEntity {

  AccountLedgerEntity({
    required this.openingBalance,
    required this.closingBalance,
    required this.voucherDetail,
  });
  final String openingBalance;
  final String closingBalance;
  final List<VoucherDetailEntity> voucherDetail;
}

class VoucherDetailEntity {

  VoucherDetailEntity({
    required this.type,
    required this.number,
    required this.date,
    required this.reference,
    required this.description,
    required this.credit,
    required this.debit,
  });
  final String type;
  final String number;
  final String date;
  final String reference;
  final String description;
  final String credit;
  final String debit;

  String get amount {
    try {
      final double credit = double.parse(this.credit);
      if (credit == 0) {
        return "$debit Dr.";
      } else {
        return "${this.credit} Cr.";
      }
    } catch (e) {
      return "-";
    }
  }
}
