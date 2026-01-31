import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:clientone_ess/shared/components/primary_button.dart';
import 'package:clientone_ess/shared/components/snackbar.dart';

import '../../../../core/Enums/enums.dart';
import '../../../../shared/app_color.dart';
import '../../../../shared/components/appbar.dart';
import '../../../../shared/components/common_bottombar.dart';
import '../../../../shared/components/date_field.dart';
import '../../../../shared/components/header.dart';
import '../../../../shared/components/section_header.dart';
import '../../domain/entity/leave_code_entity.dart';
import '../../domain/entity/leave_status_entity.dart';
import '../bloc/leave_status_bloc.dart';
import '../leaveCodeCubit/leave_code_cubit.dart';

class LeaveStatusScreen extends StatefulWidget {
  const LeaveStatusScreen({super.key, required this.title});
  final String title;

  @override
  State<LeaveStatusScreen> createState() => _LeaveStatusScreenState();
}

class _LeaveStatusScreenState extends State<LeaveStatusScreen> {
  late DateTime _fromDate;
  late DateTime _toDate;
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _withdrawReason = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LeaveCode _selectedLeaveCode =
      LeaveCode(leaveTypeId: 'All', leaveCode: 'All');
  late String _selectedStatus;

  List<String> statusList = [
    "Pending",
    "Approved",
    "Rejected",
    "Withdraw",
    "All"
  ];
  bool viewOnlyPending = false;

  @override
  void initState() {
    super.initState();
    context.read<LeaveCodeCubit>().getLeaveCodes();
    viewOnlyPending = context.read<LeaveStatusBloc>().viewOnlyPending;
    _setInitialDate();
    _selectedStatus = viewOnlyPending ? "Pending" : "All";
  }

  void _setInitialDate() {
    final DateTime now = DateTime.now();
    _fromDate = DateTime(now.year, now.month, 1);
    _toDate = DateTime(now.year, now.month + 1, 0);
    _fromDateController.text = _fromDate.ddMonthYYYY();
    _toDateController.text = _toDate.ddMonthYYYY();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.title),
      body: ListView(
        children: [
          Header(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            "From Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16),
                          )),
                      Expanded(
                          flex: 2,
                          child: DateField(
                              onTap: () => _selectFromDate(context),
                              controller: _fromDateController)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            "To Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16),
                          )),
                      Expanded(
                          flex: 2,
                          child: DateField(
                              onTap: () => _selectToDate(context),
                              controller: _toDateController)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            "Leave Type",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16),
                          )),
                      Expanded(
                          flex: 2,
                          child: BlocBuilder<LeaveCodeCubit, LeaveCodeState>(
                            builder: (context, state) {
                              if (state is LeaveCodeLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is LeaveCodeLoaded) {
                                return DropdownButtonFormField<LeaveCode>(
                                  decoration: const InputDecoration(
                                    fillColor: AppColors.white,
                                    filled: true,
                                    border: OutlineInputBorder(),
                                  ),
                                  initialValue: _selectedLeaveCode,
                                  items: <LeaveCode>[
                                    ...state.leaveCodes,
                                    _selectedLeaveCode
                                  ].map((v) {
                                    return DropdownMenuItem(
                                        value: v, child: Text(v.leaveCode));
                                  }).toList(),
                                  validator: (v) {
                                    if (v == null) {
                                      return "Select Leave Type";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    _selectedLeaveCode = value!;
                                  },
                                );
                              } else if (state is LeaveCodeError) {
                                return Text(state.message);
                              } else {
                                return const SizedBox();
                              }
                            },
                          )),
                    ],
                  ),
                  if (!viewOnlyPending) const SizedBox(height: 20),
                  if (!viewOnlyPending)
                    Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Text(
                              "Status",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16),
                            )),
                        Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                fillColor: AppColors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                              initialValue: _selectedStatus,
                              items: statusList.map((type) {
                                return DropdownMenuItem(
                                    value: type, child: Text(type));
                              }).toList(),
                              validator: (v) {
                                if (v == null) {
                                  return "Select Leave Status Type";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _selectedStatus = value!;
                              },
                            )),
                      ],
                    ),
                  const SizedBox(height: 20),
                  PrimaryIconButton(
                    onTap: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      context.read<LeaveStatusBloc>().add(
                          LeaveStatusLoadedEvent(
                              startDate: _fromDate.ddMmYyyy(),
                              endDate: _toDate.ddMmYyyy(),
                              leaveType: _selectedLeaveCode.leaveTypeId,
                              leaveStatus: _selectedStatus));
                    },
                    icon: Icons.search,
                    label: "Show Status",
                  ),
                ],
              ),
            ),
          ),
          SectionHeader(
              label: viewOnlyPending ? "Leave Withdraw" : "Status Detail",
              icon: Icons.list_alt_rounded),
          BlocConsumer<LeaveStatusBloc, LeaveStatusState>(
            listener: _listener,
            builder: _builder,
          ),
        ],
      ),
      bottomNavigationBar: const CommonBottomBar(),
    );
  }

  ///header for fetching leave status
  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      _fromDate = picked;
      _toDate = _fromDate.isAfter(DateTime.now()) ? _fromDate : DateTime.now();
      _toDateController.text = _toDate.ddMonthYYYY();
      _fromDateController.text = picked.ddMonthYYYY();
      _formKey.currentState!.validate();
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _toDate,
      firstDate: _fromDate,
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      _toDate = picked;
      _toDateController.text = picked.ddMonthYYYY();
      _formKey.currentState!.validate();
    }
  }

  ///body....
  ///listener for leave status
  void _listener(BuildContext ctx, LeaveStatusState state) {
    if (state is LeaveStatusLoaded) {
      if (state.withdrawStatus == APIStatus.success) {
        AppSnackBar.successSnackBar(message: "Leave withdraw Successfully.");
        context
            .read<LeaveStatusBloc>()
            .add(const LeaveStatusViewToggleEvent(chosenLeave: null));
        _withdrawReason.clear();
        context.read<LeaveStatusBloc>().add(LeaveStatusLoadedEvent(
            startDate: _fromDate.ddMmYyyy(),
            endDate: _toDate.ddMmYyyy(),
            leaveType: _selectedLeaveCode.leaveCode,
            leaveStatus: _selectedStatus));
      }
      if (state.withdrawStatus == APIStatus.error) {
        AppSnackBar.errorSnackBar(message: "Failed to withdraw leave.");
      }
    }
  }

  ///builder for leave status
  Widget _builder(BuildContext ctx, LeaveStatusState state) {
    if (state is LeaveStatusLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is LeaveStatusLoaded) {
      return state.selectedLeave == null
          ? _leaveStatus(context, state.leaveStatus)
          : _leaveView(state.selectedLeave!, state.withdrawStatus);
    } else if (state is LeaveStatusError) {
      return Center(child: Text(state.message));
    } else {
      return const SizedBox();
    }
  }

  ///leave status table list
  Widget _leaveStatus(
      BuildContext context, List<LeaveStatusEntity> leaveStatus) {
    if (leaveStatus.isEmpty) {
      return const Center(child: Text("No Data Found"));
    }
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1.6),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
          },
          border: TableBorder.all(color: Colors.grey.shade300),
          children: [
            TableRow(
              children: [
                _buildHeaderCell("Status"),
                _buildHeaderCell("From Date"),
                _buildHeaderCell("ToDate"),
                _buildHeaderCell("Days"),
                _buildHeaderCell("View"),
              ],
            ),
            ...List.generate(leaveStatus.length, (index) {
              final LeaveStatusEntity item = leaveStatus[index];
              return TableRow(
                children: [
                  _buildCellContainer(item.status),
                  _buildCell(item.leaveStartDate),
                  _buildCell(item.leaveEndDate),
                  _buildCell(item.noOfDays),
                  InkWell(
                    onTap: () {
                      context
                          .read<LeaveStatusBloc>()
                          .add(LeaveStatusViewToggleEvent(chosenLeave: item));
                    },
                    child: const SizedBox(
                      height: 40,
                      child: Center(
                          child: Icon(
                        Icons.visibility,
                        color: AppColors.primary,
                      )),
                    ),
                  )
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  Center _buildHeaderCell(String text) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w900, color: AppColors.darkBlue),
          ),
        ),
      );

  SizedBox _buildCell(String text) => SizedBox(
        height: 40,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: AppColors.snackbarBackground),
          ),
        ),
      );

  ///leave View for selected leave
  Column _leaveView(LeaveStatusEntity leaveStatus, APIStatus apiStatus) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<LeaveStatusBloc>().add(
                            const LeaveStatusViewToggleEvent(
                                chosenLeave: null));
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Application # ${leaveStatus.leaveApplicationNo}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color:
                            _color(leaveStatus.status).withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        leaveStatus.status,
                        style: TextStyle(
                          color: _color(leaveStatus.status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  leaveStatus.leaveDescription,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'From Date\n',
                        style: const TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: leaveStatus.leaveStartDate,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'To Date\n',
                        style: const TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: leaveStatus.leaveEndDate,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Days\n',
                        style: const TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: '${leaveStatus.noOfDays} Days',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    text: 'Leave Reason\n',
                    style: const TextStyle(color: Colors.black54),
                    children: [
                      TextSpan(
                        text: leaveStatus.reasonForLeave,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Approval Level\n',
                        style: const TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: leaveStatus.currentApprovalNo,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Approver Name\n',
                        style: const TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: leaveStatus.approverName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                if (leaveStatus.remarks.isNotEmpty) const SizedBox(height: 12),
                if (leaveStatus.remarks.isNotEmpty)
                  Text.rich(
                    TextSpan(
                      text: 'Remark\n',
                      style: const TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: leaveStatus.remarks,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                if (leaveStatus.status == "Pending") const SizedBox(height: 16),
                if (leaveStatus.status == "Pending")
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _withdrawReason,
                          decoration: const InputDecoration(
                            hintText: 'Withdraw Reason',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      apiStatus == APIStatus.loading
                          ? const CircularProgressIndicator()
                          : PrimaryButton(
                              onTap: () {
                                context.read<LeaveStatusBloc>().add(
                                    LeaveStatusWithdrawEvent(
                                        leaveStatus.leaveApplicationNo,
                                        _withdrawReason.text));
                              },
                              label: "Withdraw",
                            ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _buildCellContainer(String text) {
    return SizedBox(
      height: 40,
      child: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _color(text).withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: _color(text), fontSize: 13),
          ),
        ),
      ),
    );
  }

  ///Get Status color
  Color _color(String text) {
    return text == "Pending"
        ? const Color(0xFFFBC02D)
        : text == "Approved"
            ? const Color(0xFF1B5E20)
            : const Color(0xFFB71C1C);
  }
}
