import '../models/account_balance_model.dart';

class AccountBalanceService {
  Future<List<AccountBalanceModel>> getBalances({String? type, DateTime? start, DateTime? end}) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      AccountBalanceModel(
        typeMember: 'Salary',
        date: 'Oct 01, 2023',
        reference: 'SAL-2023-10',
        description: 'Monthly salary for November 2023',
        amount: 3000.00,
        currency: '₹',
        status: LedgerStatus.completed,
      ),
      AccountBalanceModel(
        typeMember: 'Salary',
        date: 'Oct 01, 2023',
        reference: 'SAL-2023-10',
        description: 'Monthly salary for October 2023',
        amount: 3000.00,
        currency: '₹',
        status: LedgerStatus.completed,
      ),
      AccountBalanceModel(
        typeMember: 'Salary',
        date: 'Nov 01, 2023',
        reference: 'SAL-2023-11',
        description: 'Monthly salary for November 2023',
        amount: 3000.00,
        currency: '₹',
        status: LedgerStatus.upcoming,
      ),
      AccountBalanceModel(
        typeMember: 'Conveyance',
        date: 'Oct 25, 2023',
        reference: 'CONV-2023-10-05',
        description: 'Travel Reimbursement - Pending Approval',
        amount: 250.00,
        currency: '₹',
        status: LedgerStatus.pending,
      ),
      AccountBalanceModel(
        typeMember: 'Bonus',
        date: 'Dec 15, 2023',
        reference: 'BON-2023-YE',
        description: 'Year-end Performance Bonus',
        amount: 1500.00,
        currency: '₹',
        status: LedgerStatus.upcoming,
      ),
    ];
  }
}
