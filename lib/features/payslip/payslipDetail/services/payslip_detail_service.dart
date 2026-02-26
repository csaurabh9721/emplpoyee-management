import '../models/payslip_detail_models.dart';

class PayslipDetailService {
  Future<PayslipDetailModel> getPayslipDetail(String payslipId) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy data based on payslipId
    if (payslipId == '1') {
      return _getOctober2023Data();
    } else if (payslipId == '2') {
      return _getSeptember2023Data();
    } else {
      return _getDefaultData(payslipId);
    }
  }

  PayslipDetailModel _getOctober2023Data() {
    return PayslipDetailModel(
      id: '1',
      month: 'October',
      year: '2023',
      payDate: 'Oct 31, 2023',
      status: 'PAID',
      employeeId: 'EMP001',
      employeeName: 'Alex Johnson',
      department: 'Engineering',
      designation: 'Senior Software Engineer',
      workDays: '22',
      leaveWithoutPay: '0',
      paidDays: '22',
      basicSalary: 3000.00,
      hra: 1200.00,
      specialAllowance: 800.00,
      conveyanceAllowance: 150.00,
      medicalAllowance: 50.00,
      otherAllowances: 0.00,
      grossEarnings: 5200.00,
      providentFund: 360.00,
      professionalTax: 200.00,
      incomeTax: 440.00,
      otherDeductions: 100.00,
      totalDeductions: 1100.00,
      netSalary: 4100.00,
      currency: '\$',
      earnings: [
        EarningItem(
          name: 'Basic Salary',
          amount: 3000.00,
          description: 'Monthly basic salary component',
        ),
        EarningItem(
          name: 'HRA',
          amount: 1200.00,
          description: 'House Rent Allowance',
        ),
        EarningItem(
          name: 'Special Allowance',
          amount: 800.00,
          description: 'Special performance allowance',
        ),
        EarningItem(
          name: 'Conveyance Allowance',
          amount: 150.00,
          description: 'Travel and conveyance allowance',
        ),
        EarningItem(
          name: 'Medical Allowance',
          amount: 50.00,
          description: 'Medical reimbursement allowance',
        ),
      ],
      deductions: [
        DeductionItem(
          name: 'Provident Fund',
          amount: 360.00,
          description: 'Employee PF contribution (12% of basic)',
        ),
        DeductionItem(
          name: 'Professional Tax',
          amount: 200.00,
          description: 'Monthly professional tax',
        ),
        DeductionItem(
          name: 'Income Tax',
          amount: 440.00,
          description: 'TDS deduction for the month',
        ),
        DeductionItem(
          name: 'Insurance',
          amount: 100.00,
          description: 'Health insurance premium',
        ),
      ],
    );
  }

  PayslipDetailModel _getSeptember2023Data() {
    return PayslipDetailModel(
      id: '2',
      month: 'September',
      year: '2023',
      payDate: 'Sept 28, 2023',
      status: 'PAID',
      employeeId: 'EMP001',
      employeeName: 'Alex Johnson',
      department: 'Engineering',
      designation: 'Senior Software Engineer',
      workDays: '21',
      leaveWithoutPay: '1',
      paidDays: '20',
      basicSalary: 2727.27,
      hra: 1090.91,
      specialAllowance: 727.27,
      conveyanceAllowance: 136.36,
      medicalAllowance: 45.45,
      otherAllowances: 0.00,
      grossEarnings: 4727.27,
      providentFund: 327.27,
      professionalTax: 200.00,
      incomeTax: 400.00,
      otherDeductions: 100.00,
      totalDeductions: 1027.27,
      netSalary: 3700.00,
      currency: '\$',
      earnings: [
        EarningItem(
          name: 'Basic Salary',
          amount: 2727.27,
          description: 'Monthly basic salary (pro-rated for 20 days)',
        ),
        EarningItem(
          name: 'HRA',
          amount: 1090.91,
          description: 'House Rent Allowance (pro-rated)',
        ),
        EarningItem(
          name: 'Special Allowance',
          amount: 727.27,
          description: 'Special performance allowance (pro-rated)',
        ),
        EarningItem(
          name: 'Conveyance Allowance',
          amount: 136.36,
          description: 'Travel and conveyance allowance (pro-rated)',
        ),
        EarningItem(
          name: 'Medical Allowance',
          amount: 45.45,
          description: 'Medical reimbursement allowance (pro-rated)',
        ),
      ],
      deductions: [
        DeductionItem(
          name: 'Provident Fund',
          amount: 327.27,
          description: 'Employee PF contribution (12% of basic)',
        ),
        DeductionItem(
          name: 'Professional Tax',
          amount: 200.00,
          description: 'Monthly professional tax',
        ),
        DeductionItem(
          name: 'Income Tax',
          amount: 400.00,
          description: 'TDS deduction for the month',
        ),
        DeductionItem(
          name: 'Insurance',
          amount: 100.00,
          description: 'Health insurance premium',
        ),
      ],
    );
  }

  PayslipDetailModel _getDefaultData(String payslipId) {
    return PayslipDetailModel(
      id: payslipId,
      month: 'August',
      year: '2023',
      payDate: 'Aug 30, 2023',
      status: 'PAID',
      employeeId: 'EMP001',
      employeeName: 'Alex Johnson',
      department: 'Engineering',
      designation: 'Senior Software Engineer',
      workDays: '23',
      leaveWithoutPay: '0',
      paidDays: '23',
      basicSalary: 3000.00,
      hra: 1200.00,
      specialAllowance: 700.00,
      conveyanceAllowance: 150.00,
      medicalAllowance: 50.00,
      otherAllowances: 0.00,
      grossEarnings: 5100.00,
      providentFund: 360.00,
      professionalTax: 200.00,
      incomeTax: 440.00,
      otherDeductions: 150.00,
      totalDeductions: 1150.00,
      netSalary: 3950.00,
      currency: '\$',
      earnings: [
        EarningItem(
          name: 'Basic Salary',
          amount: 3000.00,
          description: 'Monthly basic salary component',
        ),
        EarningItem(
          name: 'HRA',
          amount: 1200.00,
          description: 'House Rent Allowance',
        ),
        EarningItem(
          name: 'Special Allowance',
          amount: 700.00,
          description: 'Special performance allowance',
        ),
        EarningItem(
          name: 'Conveyance Allowance',
          amount: 150.00,
          description: 'Travel and conveyance allowance',
        ),
        EarningItem(
          name: 'Medical Allowance',
          amount: 50.00,
          description: 'Medical reimbursement allowance',
        ),
      ],
      deductions: [
        DeductionItem(
          name: 'Provident Fund',
          amount: 360.00,
          description: 'Employee PF contribution (12% of basic)',
        ),
        DeductionItem(
          name: 'Professional Tax',
          amount: 200.00,
          description: 'Monthly professional tax',
        ),
        DeductionItem(
          name: 'Income Tax',
          amount: 440.00,
          description: 'TDS deduction for the month',
        ),
        DeductionItem(
          name: 'Insurance',
          amount: 150.00,
          description: 'Health insurance premium',
        ),
      ],
    );
  }
}
