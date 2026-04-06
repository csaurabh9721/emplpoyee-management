enum LedgerStatus { completed, pending, upcoming }

class AccountBalanceModel {
  final String id;
  final String typeMember;
  final String date;
  final String reference;
  final String description;
  final double amount;
  final String currency;
  final LedgerStatus status;

  AccountBalanceModel({
    required this.id,
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
      id: json['id'] ?? '',
      typeMember: json['type_member'] ?? '',
      date: json['date'] ?? '',
      reference: json['reference'] ?? '',
      description: json['description'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      currency: json['currency'] ?? '₹',
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

class AccountDetailModel {
  final String id;
  final String type;
  final String date;
  final String reference;
  final String description;
  final double totalAmount;
  final String currency;
  final List<DetailItem> earnings;
  final List<DetailItem> deductions;
  final List<DetailItem> others;

  AccountDetailModel({
    required this.id,
    required this.type,
    required this.date,
    required this.reference,
    required this.description,
    required this.totalAmount,
    required this.currency,
    this.earnings = const [],
    this.deductions = const [],
    this.others = const [],
  });
}

class DetailItem {
  final String label;
  final double value;

  DetailItem({required this.label, required this.value});
}
