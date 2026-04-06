enum LedgerStatus { completed, pending, upcoming }

class AccountBalanceModel {
  final String typeMember;
  final String date;
  final String reference;
  final String description;
  final double amount;
  final String currency;
  final LedgerStatus status;

  AccountBalanceModel({
    required this.typeMember,
    required this.date,
    required this.reference,
    required this.description,
    required this.amount,
    required this.currency,
    this.status = LedgerStatus.completed,
  });

  factory AccountBalanceModel.fromJson(Map<String, dynamic> json) {
    return AccountBalanceModel(
      typeMember: json['type_member'] ?? '',
      date: json['date'] ?? '',
      reference: json['reference'] ?? '',
      description: json['description'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'USD',
      status: _parseStatus(json['status']),
    );
  }

  static LedgerStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return LedgerStatus.pending;
      case 'upcoming':
        return LedgerStatus.upcoming;
      default:
        return LedgerStatus.completed;
    }
  }
}
