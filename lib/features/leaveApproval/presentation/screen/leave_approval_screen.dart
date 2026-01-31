import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/Enums/enums.dart';
import 'package:clientone_ess/shared/app_color.dart';
import 'package:clientone_ess/shared/components/appbar.dart';
import 'package:clientone_ess/shared/components/primary_button.dart';
import 'package:clientone_ess/shared/components/snackbar.dart';

import '../../../../shared/components/common_bottombar.dart';
import '../../../../shared/components/header.dart';
import '../../domain/entity/employee_leave_list.dart';
import '../../domain/entity/employee_list_entity.dart';
import '../blocs/getEmpLeaveCubit/get_emp_leave_cubit.dart';
import '../blocs/getEmpListCubit/get_emp_list_cubit.dart';
import '../blocs/leaveApprovalBloc/leave_approval_bloc.dart';

class LeaveApprovalScreen extends StatefulWidget {
  const LeaveApprovalScreen({super.key});

  @override
  State<LeaveApprovalScreen> createState() => _LeaveApprovalScreenState();
}

class _LeaveApprovalScreenState extends State<LeaveApprovalScreen> {
  @override
  void initState() {
    context.read<GetEmpListCubit>().getEmpList();
    super.initState();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Leave Approval"),
      body: Column(children: [
        Header(
          child: Row(
            children: [
              const Expanded(
                  flex: 1,
                  child: Text(
                    'Employee',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  )),
              const SizedBox(width: 16),
              BlocBuilder<GetEmpListCubit, GetEmpListState>(
                builder: (context, state) {
                  if (state is GetEmpListLoadingState) {
                    return const CircularProgressIndicator();
                  } else if (state is GetEmpListSuccessState) {
                    return Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<EmployeeListEntity>(
                        decoration:
                            const InputDecoration(hintText: "Select Employee"),
                        items: state.employees.map((employee) {
                          return DropdownMenuItem<EmployeeListEntity>(
                            value: employee,
                            child: Text(employee.employeeName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          context
                              .read<GetEmpLeaveCubit>()
                              .getLeaves(value!.employeeId);
                        },
                      ),
                    );
                  } else if (state is GetEmpListErrorState) {
                    return Text(state.error);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<GetEmpLeaveCubit, GetEmpLeaveState>(
            builder: (context, state) {
              if (state is GetEmpLeaveLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetEmpLeaveSuccessState) {
                return ListView(
                  children: List.generate(
                    state.leaves.length,
                    (index) {
                      final EmployeeLeaveList leave = state.leaves[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Document # ${leave.leaveApplicationNo}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //const SizedBox(width: 12),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFB4C9FF),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            leave.leaveType,
                                            style: const TextStyle(
                                              color: Color(0xFF00325A),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //  const Icon(Icons.file_open)
                                ],
                              ),
                              const SizedBox(height: 12),
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(2),
                                },
                                border: TableBorder.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                                children: [
                                  TableRow(
                                    children: [
                                      _buildTableTitle("Name"),
                                      _buildTableValue(leave.employeeName),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      _buildTableTitle("Code"),
                                      _buildTableValue(leave.employeeCode),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(1),
                                  2: FlexColumnWidth(1),
                                },
                                border: TableBorder.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8)),
                                ),
                                children: [
                                  TableRow(
                                    children: [
                                      _buildTableTitle("From Date"),
                                      _buildTableTitle("To Date"),
                                      _buildTableTitle("Duration"),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      _buildTableValue(leave.startDate),
                                      _buildTableValue(leave.endDate),
                                      _buildTableValue(
                                          "${leave.noOfDays} Days"),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Remark',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 6),
                              TextField(
                                controller: leave.remarkController,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocConsumer<LeaveApprovalBloc,
                                      LeaveApprovalState>(
                                    buildWhen: (previous, current) =>
                                        previous.approved != current.approved,
                                    listenWhen: (previous, current) =>
                                        previous.approved != current.approved,
                                    listener: (context, st) {
                                      if (st.approved.status ==
                                          ApiStatus.completed) {
                                        AppSnackBar.successSnackBar(
                                            message: st.approved.message);
                                        context
                                            .read<GetEmpListCubit>()
                                            .getEmpList();
                                        context
                                            .read<GetEmpLeaveCubit>()
                                            .reset();
                                      }
                                      if (st.approved.status ==
                                          ApiStatus.error) {
                                        AppSnackBar.errorSnackBar(
                                            message: st.approved.message);
                                      }
                                    },
                                    builder: (context, st) {
                                      return st.approved.status ==
                                                  ApiStatus.loading &&
                                              selectedIndex == index
                                          ? const CircularProgressIndicator()
                                          : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green),
                                              onPressed: () =>
                                                  _showConfirmationDialog(
                                                      context: context,
                                                      action: 'Approve',
                                                      onTapYes: () {
                                                        selectedIndex = index;
                                                        Navigator.pop(context);
                                                        context
                                                            .read<
                                                                LeaveApprovalBloc>()
                                                            .add(LeaveApprovalApproveEvent(
                                                                empId: leave
                                                                    .employeeId,
                                                                leaveId: leave
                                                                    .leaveApplicationNo,
                                                                remark: leave
                                                                    .remarkController
                                                                    .text));
                                                      }),
                                              child: const Text('Approve'),
                                            );
                                    },
                                  ),
                                  const SizedBox(width: 12),
                                  BlocConsumer<LeaveApprovalBloc,
                                      LeaveApprovalState>(
                                    buildWhen: (previous, current) =>
                                        previous.reject != current.reject,
                                    listenWhen: (previous, current) =>
                                        previous.reject != current.reject,
                                    listener: (context, st) {
                                      if (st.reject.status ==
                                          ApiStatus.completed) {
                                        AppSnackBar.successSnackBar(
                                            message: st.reject.message);
                                        context
                                            .read<GetEmpListCubit>()
                                            .getEmpList();
                                        context
                                            .read<GetEmpLeaveCubit>()
                                            .reset();
                                      }
                                      if (st.reject.status == ApiStatus.error) {
                                        AppSnackBar.errorSnackBar(
                                            message: st.reject.message);
                                      }
                                    },
                                    builder: (context, st) {
                                      return st.reject.status ==
                                                  ApiStatus.loading &&
                                              selectedIndex == index
                                          ? const CircularProgressIndicator()
                                          : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              onPressed: () =>
                                                  _showConfirmationDialog(
                                                      context: context,
                                                      action: 'Reject',
                                                      onTapYes: () {
                                                        selectedIndex = index;
                                                        Navigator.pop(context);
                                                        context
                                                            .read<
                                                                LeaveApprovalBloc>()
                                                            .add(LeaveApprovalRejectEvent(
                                                                empId: leave
                                                                    .employeeId,
                                                                leaveId: leave
                                                                    .leaveApplicationNo,
                                                                remark: leave
                                                                    .remarkController
                                                                    .text));
                                                      }),
                                              child: const Text('Reject'),
                                            );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is GetEmpLeaveErrorState) {
                return Center(child: Text(state.error));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ]),
      bottomNavigationBar: const CommonBottomBar(),
    );
  }

  Padding _buildTableValue(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Center(
        child: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Padding _buildTableTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }

  void _showConfirmationDialog(
      {required BuildContext context,
      required String action,
      required VoidCallback onTapYes}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x80E9EFFF),
                      Color(0x80A7B1E9),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: const Text('Confirmation',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Do you want to $action the leave?'),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SecondaryButton(
                    width: 80,
                    height: 36,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    label: "No",
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  PrimaryButton(
                    width: 80,
                    height: 36,
                    color: AppColors.darkBlue,
                    onTap: onTapYes,
                    label: "Yes",
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        );
      },
    );
  }
}
