import '../models/payslip_models.dart';

class PayslipService {
  Future<PayslipHistoryResponse> getPayslipHistory() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy data
    final List<PayslipModel> dummyPayslips = [
      PayslipModel(
        id: '1',
        month: 'October',
        year: '2023',
        payDate: 'Oct 31, 2023',
        status: 'PAID',
        grossPay: 5200.00,
        deductions: 1100.00,
        netPay: 4100.00,
      ),
      PayslipModel(
        id: '2',
        month: 'September',
        year: '2023',
        payDate: 'Sept 28, 2023',
        status: 'PAID',
        grossPay: 5100.00,
        deductions: 1150.00,
        netPay: 3950.00,
      ),
      PayslipModel(
        id: '3',
        month: 'August',
        year: '2023',
        payDate: 'Aug 30, 2023',
        status: 'PAID',
        grossPay: 5100.00,
        deductions: 1150.00,
        netPay: 3950.00,
      ),
      PayslipModel(
        id: '4',
        month: 'July',
        year: '2023',
        payDate: 'July 28, 2023',
        status: 'PAID',
        grossPay: 5000.00,
        deductions: 1050.00,
        netPay: 3950.00,
      ),
      PayslipModel(
        id: '5',
        month: 'June',
        year: '2023',
        payDate: 'June 29, 2023',
        status: 'PAID',
        grossPay: 5000.00,
        deductions: 1050.00,
        netPay: 3950.00,
      ),
      PayslipModel(
        id: '6',
        month: 'May',
        year: '2023',
        payDate: 'May 30, 2023',
        status: 'PAID',
        grossPay: 4900.00,
        deductions: 1000.00,
        netPay: 3900.00,
      ),
    ];

    return PayslipHistoryResponse(
      payslips: dummyPayslips,
      message: 'Payslip history retrieved successfully',
      success: true,
    );
  }

  Future<PayslipModel?> getPayslipById(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    final response = await getPayslipHistory();
    
    try {
      return response.payslips.firstWhere((payslip) => payslip.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<PayslipHistoryResponse> getArchivedPayslips() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy archived data
    final List<PayslipModel> archivedPayslips = [
      PayslipModel(
        id: '7',
        month: 'April',
        year: '2023',
        payDate: 'Apr 28, 2023',
        status: 'PAID',
        grossPay: 4800.00,
        deductions: 950.00,
        netPay: 3850.00,
      ),
      PayslipModel(
        id: '8',
        month: 'March',
        year: '2023',
        payDate: 'Mar 30, 2023',
        status: 'PAID',
        grossPay: 4800.00,
        deductions: 950.00,
        netPay: 3850.00,
      ),
      PayslipModel(
        id: '9',
        month: 'February',
        year: '2023',
        payDate: 'Feb 27, 2023',
        status: 'PAID',
        grossPay: 4700.00,
        deductions: 900.00,
        netPay: 3800.00,
      ),
      PayslipModel(
        id: '10',
        month: 'January',
        year: '2023',
        payDate: 'Jan 31, 2023',
        status: 'PAID',
        grossPay: 4700.00,
        deductions: 900.00,
        netPay: 3800.00,
      ),
    ];

    return PayslipHistoryResponse(
      payslips: archivedPayslips,
      message: 'Archived payslips retrieved successfully',
      success: true,
    );
  }
}
