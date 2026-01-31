import 'package:get_it/get_it.dart';
import 'package:clientone_ess/features/accountLedger/data/dataSource/gl_source.dart';
import 'package:clientone_ess/features/accountLedger/data/impl/gl_repository_impl.dart';
import 'package:clientone_ess/features/landing/data/dataSource/dashboard_source.dart';
import 'package:clientone_ess/features/landing/data/dataSource/profile_source.dart';
import 'package:clientone_ess/features/landing/data/repository/dashboard_repository_impl.dart';
import 'package:clientone_ess/features/landing/data/repository/profile_repository_impl.dart';
import 'package:clientone_ess/features/landing/domain/useCases/dashboard_usecase.dart';
import 'package:clientone_ess/features/landing/domain/useCases/get_profile_usecase.dart';
import 'package:clientone_ess/features/leaveApproval/domain/useCase/get_emp_leave_usecase.dart';
import 'package:clientone_ess/features/login/data/dataSource/login_data_source_impl.dart';
import 'package:clientone_ess/features/login/data/repository/login_repository_impl.dart';
import 'package:clientone_ess/features/login/domain/usecase/user_login_use_case_impl.dart';
import 'package:clientone_ess/features/payslip/data/dataSource/payslip_source.dart';
import 'package:clientone_ess/features/payslip/data/repository/payslip_repo_impl.dart';
import 'package:clientone_ess/features/payslip/domain/usecases/get_payslip_usecase.dart';
import 'package:clientone_ess/features/splash/data/splash_repository_impl.dart';
import 'package:clientone_ess/features/splash/domain/usecases/get_version_impl.dart';

import '../../features/accountBalance/data/account_balance_source.dart';
import '../../features/accountBalance/data/repository.dart';
import '../../features/accountBalance/domain/get_account_balance_usecase.dart';
import '../../features/accountLedger/data/dataSource/account_ledger_source.dart';
import '../../features/accountLedger/data/impl/account_ledger_repository_impl.dart';
import '../../features/accountLedger/domain/useCases/get_account_ledger_usecase.dart';
import '../../features/accountLedger/domain/useCases/get_gl_usecase.dart';
import '../../features/attendance/data/attendance_source.dart';
import '../../features/attendance/data/repository.dart';
import '../../features/attendance/domain/get_attendance_usecase.dart';
import '../../features/changePassword/data/change_password_repo_impl.dart';
import '../../features/changePassword/data/change_password_source.dart';
import '../../features/changePassword/domain/change_password_use_case.dart';
import '../../features/forgetPassword/data/forget_password_repo_impl.dart';
import '../../features/forgetPassword/data/forget_password_source.dart';
import '../../features/forgetPassword/domain/forget_password_use_case.dart';
import '../../features/leaveApply/data/dataSources/apply_leave_source.dart';
import '../../features/leaveApply/data/dataSources/continuous_paid_leave_source.dart';
import '../../features/leaveApply/data/dataSources/get_leave_balance_data_source.dart';
import '../../features/leaveApply/data/repoImpl/apply_leave_repo_impl.dart';
import '../../features/leaveApply/data/repoImpl/continuous_paid_leave_repo_impl.dart';
import '../../features/leaveApply/data/repoImpl/get_leave_balance_repo_impl.dart';
import '../../features/leaveApply/domain/usecases/continuous_paid_leave_usecase.dart';
import '../../features/leaveApply/domain/usecases/get_leave_balance_usecase.dart';
import '../../features/leaveApply/domain/usecases/save_leave_usecase.dart';
import '../../features/leaveApproval/data/dataSource/employee_approval_list_source.dart';
import '../../features/leaveApproval/data/dataSource/employee_list_source.dart';
import '../../features/leaveApproval/data/dataSource/leave_approval_source.dart';
import '../../features/leaveApproval/data/repoImpl/get_emp_leaves_repo_imple.dart';
import '../../features/leaveApproval/data/repoImpl/get_emp_list_repo_impl.dart';
import '../../features/leaveApproval/data/repoImpl/leave_approval_repo_impl.dart';
import '../../features/leaveApproval/domain/useCase/get_emp_use_case.dart';
import '../../features/leaveApproval/domain/useCase/leave_approval_usecase.dart';
import '../../features/leaveBalance/data/leave_balance_source.dart';
import '../../features/leaveBalance/data/repository_impl.dart';
import '../../features/leaveBalance/domain/usecase.dart';
import '../../features/leaveHistory/data/leave_history_source.dart';
import '../../features/leaveHistory/data/repository.dart';
import '../../features/leaveHistory/domain/use_case.dart';
import '../../features/leaveLedger/data/data_source.dart';
import '../../features/leaveLedger/data/repository_impl.dart';
import '../../features/leaveLedger/domain/usecase.dart';
import '../../features/leaveStatus/data/dataSource/leave_code_source.dart';
import '../../features/leaveStatus/data/dataSource/leave_status_source.dart';
import '../../features/leaveStatus/data/repoImpl/get_leave_code_repo_impl.dart';
import '../../features/leaveStatus/data/repoImpl/leave_status_repo_impl.dart';
import '../../features/leaveStatus/domain/usecases/get_leave_code_usecase.dart';
import '../../features/leaveStatus/domain/usecases/get_leave_status_usecase.dart';
import '../../features/splash/domain/repository/splash_repo.dart';
import '../../features/teamAttendance/data/data_source.dart';
import '../../features/teamAttendance/data/repo_impl.dart';
import '../../features/teamAttendance/domain/usecase.dart';

final GetIt di = GetIt.instance;

void setupDependencyInjection() {
  /// Splash
  di.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl());
  di.registerLazySingleton<GetVersionImpl>(() => GetVersionImpl(di()));

  /// Login
  di.registerLazySingleton<LoginDataSourceImpl>(() => LoginDataSourceImpl());
  di.registerLazySingleton<LoginRepositoryImpl>(
      () => LoginRepositoryImpl(di<LoginDataSourceImpl>()));
  di.registerLazySingleton<UserLoginUseCaseImpl>(
      () => UserLoginUseCaseImpl(di<LoginRepositoryImpl>()));

  /// Login
  di.registerLazySingleton<ChangePasswordSourceImpl>(
      () => ChangePasswordSourceImpl());
  di.registerLazySingleton<ChangePasswordRepoImpl>(
      () => ChangePasswordRepoImpl(di<ChangePasswordSourceImpl>()));
  di.registerLazySingleton<ChangePasswordUseCaseImpl>(
      () => ChangePasswordUseCaseImpl(di<ChangePasswordRepoImpl>()));

  /// Forget Password
  di.registerLazySingleton<ForgetPasswordSourceImpl>(
      () => ForgetPasswordSourceImpl());
  di.registerLazySingleton<ForgetPasswordRepoImpl>(
      () => ForgetPasswordRepoImpl(di<ForgetPasswordSourceImpl>()));
  di.registerLazySingleton<ForgetPasswordUseCaseImpl>(
      () => ForgetPasswordUseCaseImpl(di<ForgetPasswordRepoImpl>()));

  /// Landing
  di.registerLazySingleton<DashboardSourceImpl>(() => DashboardSourceImpl());
  di.registerLazySingleton<ProfileSourceImpl>(() => ProfileSourceImpl());

  di.registerLazySingleton<DashboardRepositoryImpl>(
      () => DashboardRepositoryImpl(di<DashboardSourceImpl>()));
  di.registerLazySingleton<ProfileRepositoryImpl>(
      () => ProfileRepositoryImpl(di<ProfileSourceImpl>()));

  di.registerLazySingleton<DashboardUseCaseImpl>(
      () => DashboardUseCaseImpl(di<DashboardRepositoryImpl>()));
  di.registerLazySingleton<GetProfileUseCaseImpl>(
      () => GetProfileUseCaseImpl(di<ProfileRepositoryImpl>()));

  /// Payslip
  di.registerLazySingleton<PayslipSourceImpl>(() => PayslipSourceImpl());
  di.registerLazySingleton<PayslipRepositoryImpl>(
      () => PayslipRepositoryImpl(di<PayslipSourceImpl>()));
  di.registerLazySingleton<GetPayslipUseCaseImpl>(
      () => GetPayslipUseCaseImpl(di<PayslipRepositoryImpl>()));

  ///Leave Apply
  di.registerLazySingleton<ApplyLeaveSourceImpl>(() => ApplyLeaveSourceImpl());
  di.registerLazySingleton<ApplyLeaveRepoImpl>(
      () => ApplyLeaveRepoImpl(di<ApplyLeaveSourceImpl>()));
  di.registerLazySingleton<SaveLeaveUsecaseImpl>(
      () => SaveLeaveUsecaseImpl(di<ApplyLeaveRepoImpl>()));

  di.registerLazySingleton<GetLeaveBalanceDataSourceImpl>(
      () => GetLeaveBalanceDataSourceImpl());
  di.registerLazySingleton<GetLeaveBalanceRepoImpl>(
      () => GetLeaveBalanceRepoImpl(di<GetLeaveBalanceDataSourceImpl>()));
  di.registerLazySingleton<GetLeaveBalanceUsecaseImpl>(
      () => GetLeaveBalanceUsecaseImpl(di<GetLeaveBalanceRepoImpl>()));

  di.registerLazySingleton<ContinuousPaidLeaveSourceImpl>(
      () => ContinuousPaidLeaveSourceImpl());
  di.registerLazySingleton<ContinuousPaidLeaveRepoImpl>(
      () => ContinuousPaidLeaveRepoImpl(di<ContinuousPaidLeaveSourceImpl>()));
  di.registerLazySingleton<ContinuousPaidLeaveUsecaseImpl>(
      () => ContinuousPaidLeaveUsecaseImpl(di<ContinuousPaidLeaveRepoImpl>()));

  ///leave history
  di.registerLazySingleton<LeaveHistorySourceImpl>(
      () => LeaveHistorySourceImpl());
  di.registerLazySingleton<LeaveHistoryRepositoryImpl>(
      () => LeaveHistoryRepositoryImpl(di<LeaveHistorySourceImpl>()));
  di.registerLazySingleton<GetLeaveHistoryUseCaseImpl>(
      () => GetLeaveHistoryUseCaseImpl(di<LeaveHistoryRepositoryImpl>()));

  ///Account Balance
  di.registerLazySingleton<AccountBalanceSourceImpl>(
      () => AccountBalanceSourceImpl());
  di.registerLazySingleton<AccountBalanceRepositoryImpl>(
      () => AccountBalanceRepositoryImpl(di<AccountBalanceSourceImpl>()));
  di.registerLazySingleton<GetAccountBalanceUsecaseImpl>(
      () => GetAccountBalanceUsecaseImpl(di<AccountBalanceRepositoryImpl>()));

  ///Account Ledger
  di.registerLazySingleton<AccountLedgerSourceImpl>(
      () => AccountLedgerSourceImpl());
  di.registerLazySingleton<AccountLedgerRepositoryImpl>(
      () => AccountLedgerRepositoryImpl(di<AccountLedgerSourceImpl>()));
  di.registerLazySingleton<GetAccountLedgerUsecaseImpl>(
      () => GetAccountLedgerUsecaseImpl(di<AccountLedgerRepositoryImpl>()));

  di.registerLazySingleton<GlSourceImpl>(() => GlSourceImpl());
  di.registerLazySingleton<GlRepositoryImpl>(
      () => GlRepositoryImpl(di<GlSourceImpl>()));
  di.registerLazySingleton<GetGlUsecaseImpl>(
      () => GetGlUsecaseImpl(di<GlRepositoryImpl>()));

  ///Leave Balance
  di.registerLazySingleton<LeaveBalanceSourceImpl>(
      () => LeaveBalanceSourceImpl());
  di.registerLazySingleton<LeaveBalanceRepositoryImpl>(
      () => LeaveBalanceRepositoryImpl(di<LeaveBalanceSourceImpl>()));
  di.registerLazySingleton<GetLeaveBalanceLeaveUsecaseImpl>(
      () => GetLeaveBalanceLeaveUsecaseImpl(di<LeaveBalanceRepositoryImpl>()));

  ///Leave Balance
  di.registerLazySingleton<LeaveLedgerSourceImpl>(
      () => LeaveLedgerSourceImpl());
  di.registerLazySingleton<LeaveLedgerRepositoryImpl>(
      () => LeaveLedgerRepositoryImpl(di<LeaveLedgerSourceImpl>()));
  di.registerLazySingleton<LeaveLedgerUsecaseImpl>(
      () => LeaveLedgerUsecaseImpl(di<LeaveLedgerRepositoryImpl>()));

  ///Leave Status
  di.registerLazySingleton<LeaveCodeSourceImpl>(() => LeaveCodeSourceImpl());
  di.registerLazySingleton<GetLeaveCodeRepositoryImpl>(
      () => GetLeaveCodeRepositoryImpl(di<LeaveCodeSourceImpl>()));
  di.registerLazySingleton<GetLeaveCodeUsecaseImpl>(
      () => GetLeaveCodeUsecaseImpl(di<GetLeaveCodeRepositoryImpl>()));

  di.registerLazySingleton<LeaveStatusSourceImpl>(
      () => LeaveStatusSourceImpl());
  di.registerLazySingleton<GetLeaveStatusRepositoryImpl>(
      () => GetLeaveStatusRepositoryImpl(di<LeaveStatusSourceImpl>()));
  di.registerLazySingleton<GetLeaveStatusUsecaseImpl>(
      () => GetLeaveStatusUsecaseImpl(di<GetLeaveStatusRepositoryImpl>()));

  ///Leave Approval
  di.registerLazySingleton<EmployeeListSourceImpl>(
      () => EmployeeListSourceImpl());
  di.registerLazySingleton<GetEmpListRepoImpl>(
      () => GetEmpListRepoImpl(di<EmployeeListSourceImpl>()));
  di.registerLazySingleton<GetEmpUseCaseImpl>(
      () => GetEmpUseCaseImpl(di<GetEmpListRepoImpl>()));

  di.registerLazySingleton<EmployeeApprovalListSourceImpl>(
      () => EmployeeApprovalListSourceImpl());
  di.registerLazySingleton<GetEmpLeavesRepoImpl>(
      () => GetEmpLeavesRepoImpl(di<EmployeeApprovalListSourceImpl>()));
  di.registerLazySingleton<GetEmpLeaveUsecaseImpl>(
      () => GetEmpLeaveUsecaseImpl(di<GetEmpLeavesRepoImpl>()));

  di.registerLazySingleton<LeaveApprovalSourceImpl>(
      () => LeaveApprovalSourceImpl());
  di.registerLazySingleton<LeaveApprovalRepoImpl>(
      () => LeaveApprovalRepoImpl(di<LeaveApprovalSourceImpl>()));
  di.registerLazySingleton<LeaveApprovalUsecaseImpl>(
      () => LeaveApprovalUsecaseImpl(di<LeaveApprovalRepoImpl>()));

  ///Attendance
  di.registerLazySingleton<AttendanceSourceImpl>(() => AttendanceSourceImpl());
  di.registerLazySingleton<GetAttendanceRepoImpl>(
      () => GetAttendanceRepoImpl(di<AttendanceSourceImpl>()));
  di.registerLazySingleton<GetAttendanceUsecaseImpl>(
      () => GetAttendanceUsecaseImpl(di<GetAttendanceRepoImpl>()));

  ///Team Attendance
  di.registerLazySingleton<TeamAttendanceImpl>(() => TeamAttendanceImpl());
  di.registerLazySingleton<TeamAttendanceRepoImpl>(
      () => TeamAttendanceRepoImpl(di<TeamAttendanceImpl>()));
  di.registerLazySingleton<GetTeamAttendanceUsecaseImpl>(
      () => GetTeamAttendanceUsecaseImpl(di<TeamAttendanceRepoImpl>()));
}
