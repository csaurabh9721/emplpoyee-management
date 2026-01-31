class LoginResponseEntity {

  const LoginResponseEntity({
    required this.payrollAreaCode,
    required this.payrollAreaId,
    required this.companyId,
    required this.payrollUniqueId,
    required this.userId,
    required this.employeeId,
    required this.placeOfPostingId,
    required this.employeeTypeId,
    required this.profitCentreId,
    required this.profitCentreCode,
    required this.token,
  });
  final String payrollAreaCode;
  final String payrollAreaId;
  final String companyId;
  final String payrollUniqueId;
  final String userId;
  final String employeeId;
  final String placeOfPostingId;
  final String employeeTypeId;
  final String profitCentreId;
  final String profitCentreCode;
  final String token;
}
