class AccountBalanceEntity {

  AccountBalanceEntity({required this.gl, required this.glCode, required this.credit, required this.debit});
  final String gl;
  final String glCode;
  final String credit;
  final String debit;

  String get balance {
    try {
      final double credit = double.parse(this.credit);
      final double debit = double.parse(this.debit);
      if (credit == 0.00 && debit == 0.00) {
        return "-";
      } else if (credit == 0.00) {
        return this.debit;
      } else {
        return this.credit;
      }
    } catch (e) {
      return "-";
    }
  }
}
