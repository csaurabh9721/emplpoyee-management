import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/routes/routes_name.dart';
import 'package:clientone_ess/features/accountLedger/domain/useCases/get_gl_usecase.dart';
import 'package:clientone_ess/features/leaveApproval/presentation/screen/leave_approval_screen.dart';
import 'package:clientone_ess/features/leaveHistory/presentation/bloc/leave_history_bloc.dart';
import 'package:clientone_ess/features/leaveLedger/presentation/screen/leave_ledger_screen.dart';
import 'package:clientone_ess/features/payslip/domain/usecases/get_payslip_usecase.dart';
import 'package:clientone_ess/features/payslip/presentation/bloc/payslip_bloc.dart';

import '../../features/accountBalance/domain/get_account_balance_usecase.dart';
import '../../features/accountBalance/presentation/bloc/account_balance_cubit.dart';
import '../../features/accountBalance/presentation/screens/account_balance_screen.dart';
import '../../features/accountLedger/domain/useCases/get_account_ledger_usecase.dart';
import '../../features/accountLedger/presetation/account_ledger_screen.dart';
import '../../features/accountLedger/presetation/blocs/account_ledger_cubit.dart';
import '../../features/accountLedger/presetation/blocs/export_ledger_cubit.dart';
import '../../features/accountLedger/presetation/blocs/gl_bloc.dart';
import '../../features/attendance/domain/get_attendance_usecase.dart';
import '../../features/attendance/presentation/bloc/attendance_bloc.dart';
import '../../features/attendance/presentation/screen/attendance_screen.dart';
import '../../features/changePassword/domain/change_password_use_case.dart';
import '../../features/changePassword/presentation/cubit/change_password_cubit.dart';
import '../../features/changePassword/presentation/screen/change_password_screen.dart';
import '../../features/forgetPassword/domain/forget_password_use_case.dart';
import '../../features/forgetPassword/presentation/cubit/forget_password_cubit.dart';
import '../../features/forgetPassword/presentation/screen/forget_password_screen.dart';
import '../../features/landing/presentation/screens/landing_screen.dart';
import '../../features/leaveApply/domain/usecases/continuous_paid_leave_usecase.dart';
import '../../features/leaveApply/domain/usecases/get_leave_balance_usecase.dart';
import '../../features/leaveApply/domain/usecases/save_leave_usecase.dart';
import '../../features/leaveApply/presentation/cubits/change_leave_type_cubit.dart';
import '../../features/leaveApply/presentation/cubits/continuousPaidLeaveCubit/continuous_paid_leave_cubit.dart';
import '../../features/leaveApply/presentation/cubits/getLeaveBalanceCubit/get_leave_balance_cubit.dart';
import '../../features/leaveApply/presentation/cubits/leaveSaveCubit/leave_save_cubit.dart';
import '../../features/leaveApply/presentation/cubits/start_period_cubit.dart';
import '../../features/leaveApply/presentation/cubits/upload_file_cubit.dart';
import '../../features/leaveApply/presentation/screen/leave_apply_screen.dart';
import '../../features/leaveApproval/domain/useCase/get_emp_leave_usecase.dart';
import '../../features/leaveApproval/domain/useCase/get_emp_use_case.dart';
import '../../features/leaveApproval/domain/useCase/leave_approval_usecase.dart';
import '../../features/leaveApproval/presentation/blocs/getEmpLeaveCubit/get_emp_leave_cubit.dart';
import '../../features/leaveApproval/presentation/blocs/getEmpListCubit/get_emp_list_cubit.dart';
import '../../features/leaveApproval/presentation/blocs/leaveApprovalBloc/leave_approval_bloc.dart';
import '../../features/leaveBalance/domain/usecase.dart';
import '../../features/leaveBalance/presentation/cubit/leave_balance_cubit.dart';
import '../../features/leaveBalance/presentation/screen/leave_balance_screen.dart';
import '../../features/leaveHistory/domain/use_case.dart';
import '../../features/leaveHistory/presentation/screen/leave_history_screen.dart';
import '../../features/leaveLedger/domain/usecase.dart';
import '../../features/leaveLedger/presentation/leaveLedgerBloc/leave_ledger_bloc.dart';
import '../../features/leaveStatus/domain/usecases/get_leave_code_usecase.dart';
import '../../features/leaveStatus/domain/usecases/get_leave_status_usecase.dart';
import '../../features/leaveStatus/presentation/bloc/leave_status_bloc.dart';
import '../../features/leaveStatus/presentation/leaveCodeCubit/leave_code_cubit.dart';
import '../../features/leaveStatus/presentation/screen/leave_status_screen.dart';
import '../../features/login/domain/usecase/user_login_use_case_impl.dart';
import '../../features/login/presentation/loginBloc/login_bloc.dart';
import '../../features/login/presentation/loginBloc/toggle_password_cubit.dart';
import '../../features/login/presentation/loginScreen/login_screen.dart';
import '../../features/payslip/presentation/page/payslip_page.dart';
import '../../features/splash/domain/usecases/get_version_impl.dart';
import '../../features/splash/presentation/screen/splash_screen.dart';
import '../../features/splash/presentation/splashBloc/splash_bloc.dart';
import '../../features/teamAttendance/domain/usecase.dart';
import '../../features/teamAttendance/presentation/bloc/team_attendance_bloc.dart';
import '../../features/teamAttendance/presentation/screen/team_attendance_screen.dart';
import '../dependencyInjection/di.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) => SplashBloc(di<GetVersionImpl>()),
                  child: const SplashScreen(),
                ));

      case RoutesName.login:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<LoginBloc>(
                      create: (context) =>
                          LoginBloc(di<UserLoginUseCaseImpl>()),
                    ),
                    BlocProvider<TogglePasswordCubit>(
                      create: (context) => TogglePasswordCubit(),
                    ),
                  ],
                  child: const LoginScreen(),
                ));
      case RoutesName.forgetPassword:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) =>
                      ForgetPasswordCubit(di<ForgetPasswordUseCaseImpl>()),
                  child: const ForgetPasswordScreen(),
                ));
      case RoutesName.changePassword:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) =>
                      ChangePasswordCubit(di<ChangePasswordUseCaseImpl>()),
                  child: const ChangePasswordScreen(),
                ));
      case RoutesName.landingPage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LandingPage());

      case RoutesName.leaveApply:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ChangeLeaveTypeCubit>(
                  create: (context) => ChangeLeaveTypeCubit()),
              BlocProvider<StartPeriodCubit>(
                  create: (context) => StartPeriodCubit()),
              BlocProvider<UploadFileCubit>(
                  create: (context) => UploadFileCubit()),
              BlocProvider<LeaveSaveCubit>(
                  create: (context) =>
                      LeaveSaveCubit(di<SaveLeaveUsecaseImpl>())),
              BlocProvider<GetLeaveBalanceCubit>(
                  create: (context) =>
                      GetLeaveBalanceCubit(di<GetLeaveBalanceUsecaseImpl>())),
              BlocProvider<ContinuousPaidLeaveCubit>(
                  create: (context) => ContinuousPaidLeaveCubit(
                      di<ContinuousPaidLeaveUsecaseImpl>())),
            ],
            child: const LeaveApplyScreen(),
          ),
        );
      case RoutesName.leaveLedger:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) => LeaveLedgerBloc(
                    di<LeaveLedgerUsecaseImpl>(),
                  ),
                  child: const LeaveLedgerScreen(),
                ));
      case RoutesName.leaveStatus:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<LeaveCodeCubit>(
                  create: (context) =>
                      LeaveCodeCubit(di<GetLeaveCodeUsecaseImpl>())),
              BlocProvider<LeaveStatusBloc>(
                  create: (context) =>
                      LeaveStatusBloc(di<GetLeaveStatusUsecaseImpl>(), false)),
            ],
            child: const LeaveStatusScreen(
              title: "Leave Status",
            ),
          ),
        );
      case RoutesName.leaveWithdrawal:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<LeaveCodeCubit>(
                  create: (context) =>
                      LeaveCodeCubit(di<GetLeaveCodeUsecaseImpl>())),
              BlocProvider<LeaveStatusBloc>(
                  create: (context) =>
                      LeaveStatusBloc(di<GetLeaveStatusUsecaseImpl>(), true)),
            ],
            child: const LeaveStatusScreen(
              title: 'Leave Withdraw',
            ),
          ),
        );
      case RoutesName.leaveApproval:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<GetEmpListCubit>(
                  create: (context) =>
                      GetEmpListCubit(di<GetEmpUseCaseImpl>())),
              BlocProvider<GetEmpLeaveCubit>(
                  create: (context) =>
                      GetEmpLeaveCubit(di<GetEmpLeaveUsecaseImpl>())),
              BlocProvider<LeaveApprovalBloc>(
                  create: (context) =>
                      LeaveApprovalBloc(di<LeaveApprovalUsecaseImpl>())),
            ],
            child: const LeaveApprovalScreen(),
          ),
        );

      case RoutesName.leaveBalance:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) =>
                      LeaveBalanceCubit(di<GetLeaveBalanceLeaveUsecaseImpl>()),
                  child: const LeaveBalanceScreen(),
                ));
      case RoutesName.accountLedger:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AccountLedgerCubit>(
                  create: (context) =>
                      AccountLedgerCubit(di<GetAccountLedgerUsecaseImpl>())),
              BlocProvider<GlBloc>(
                  create: (context) => GlBloc(di<GetGlUsecaseImpl>())),
              BlocProvider<ExportLedgerCubit>(
                  create: (context) => ExportLedgerCubit()),
            ],
            child: const AccountLedgerScreen(),
          ),
        );
      case RoutesName.accountBalance:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) =>
                      AccountBalanceCubit(di<GetAccountBalanceUsecaseImpl>()),
                  child: const AccountBalanceScreen(),
                ));
      case RoutesName.payslip:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) => PayslipBloc(di<GetPayslipUseCaseImpl>()),
                  child: const PayslipPage(),
                ));
      case RoutesName.leaveHistory:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) =>
                      LeaveHistoryBloc(di<GetLeaveHistoryUseCaseImpl>()),
                  child: const LeaveHistoryScreen(),
                ));
      case RoutesName.attendancePunches:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => AttendanceBloc(di<GetAttendanceUsecaseImpl>()),
            child: const AttendanceScreen(),
          ),
        );
      case RoutesName.teamAttendance:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) =>
                TeamAttendanceBloc(di<GetTeamAttendanceUsecaseImpl>()),
            child: const TeamAttendanceScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Sorry!')),
                ));
    }
  }
}
