import '../models/account_balance_model.dart';

class AccountBalanceService {
  Future<List<AccountBalanceModel>> getBalances({String? type, DateTime? start, DateTime? end}) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      AccountBalanceModel(
        id: '1',
        typeMember: 'Salary',
        date: 'Oct 01, 2023',
        reference: 'SAL-2023-10',
        description: 'Monthly salary for October 2023',
        amount: 3000.00,
        currency: '₹',
        status: LedgerStatus.completed,
      ),
      AccountBalanceModel(
        id: '2',
        typeMember: 'Salary',
        date: 'Nov 01, 2023',
        reference: 'SAL-2023-11',
        description: 'Monthly salary for November 2023',
        amount: 3000.00,
        currency: '₹',
        status: LedgerStatus.upcoming,
      ),
      AccountBalanceModel(
        id: '3',
        typeMember: 'Conveyance',
        date: 'Oct 25, 2023',
        reference: 'CONV-2023-10-05',
        description: 'Travel Reimbursement - Pending Approval',
        amount: 250.00,
        currency: '₹',
        status: LedgerStatus.pending,
      ),
      AccountBalanceModel(
        id: '4',
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

  Future<AccountDetailModel> getAccountDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (id == '1' || id == '2') {
      return AccountDetailModel(
        id: id,
        type: 'Salary',
        date: id == '1' ? 'Oct 01, 2023' : 'Nov 01, 2023',
        reference: id == '1' ? 'SAL-2023-10' : 'SAL-2023-11',
        description: 'Monthly salary for ${id == '1' ? 'October' : 'November'} 2023',
        totalAmount: 3000.00,
        currency: '₹',
        earnings: [
          DetailItem(label: 'Basic Pay', value: 2000.00),
          DetailItem(label: 'HRA', value: 500.00),
          DetailItem(label: 'Conveyance Allowance', value: 200.00),
          DetailItem(label: 'Special Allowance', value: 400.00),
        ],
        deductions: [
          DetailItem(label: 'Provident Fund', value: 100.00),
        ],
      );
    } else if (id == '3') {
      return AccountDetailModel(
        id: id,
        type: 'Conveyance',
        date: 'Oct 25, 2023',
        reference: 'CONV-2023-10-05',
        description: 'Travel Reimbursement - Pending Approval',
        totalAmount: 250.00,
        currency: '₹',
        others: [
          DetailItem(label: 'Fuel Expenses', value: 150.00),
          DetailItem(label: 'Parking Charges', value: 50.00),
          DetailItem(label: 'Toll Fees', value: 50.00),
        ],
      );
    } else {
      return AccountDetailModel(
        id: id,
        type: 'Bonus',
        date: 'Dec 15, 2023',
        reference: 'BON-2023-YE',
        description: 'Year-end Performance Bonus',
        totalAmount: 1500.00,
        currency: '₹',
        earnings: [
          DetailItem(label: 'Performance Bonus', value: 1500.00),
        ],
      );
    }
  }
}
