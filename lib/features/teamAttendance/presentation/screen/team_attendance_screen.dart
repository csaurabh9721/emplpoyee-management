import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:clientone_ess/shared/components/appbar.dart';
import 'package:clientone_ess/shared/components/primary_button.dart';
import 'package:clientone_ess/shared/constants/app_constant.dart';

import '../../../../shared/app_color.dart';
import '../../../../shared/components/common_bottombar.dart';
import '../../../../shared/components/date_field.dart';
import '../../../../shared/components/header.dart';
import '../../domain/entity/entity.dart';
import '../../domain/entity/send_entity.dart';
import '../bloc/team_attendance_bloc.dart';

class TeamAttendanceScreen extends StatefulWidget {
  const TeamAttendanceScreen({super.key});

  @override
  State<TeamAttendanceScreen> createState() => _TeamAttendanceScreenState();
}

class _TeamAttendanceScreenState extends State<TeamAttendanceScreen> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();

  @override
  void initState() {
    _defaultData();
    super.initState();
  }

  void _defaultData() {
    final DateTime now = DateTime.now();
    _fromDate = DateTime(now.year, now.month, 1);
    _toDate = now;
    _fromDateController.text = _fromDate.ddMonthYYYY();
    _toDateController.text = _toDate.ddMonthYYYY();
    _onTapViewReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Team Attendance"),
      body: ListView(
        children: [
          Header(
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
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                PrimaryIconButton(
                  onTap: () => _onTapViewReport(),
                  icon: Icons.search,
                  label: "View Report",
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Container(
            color: AppColors.lightBlue,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<TeamAttendanceBloc, TeamAttendanceState>(
                  builder: (context, state) {
                    if (state is TeamAttendanceLoaded && state.stage > 1) {
                      return InkWell(
                          onTap: () {
                            context
                                .read<TeamAttendanceBloc>()
                                .add(TeamAttendanceBackEvent());
                          },
                          child: Container(
                            height: 36,
                            width: 36,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: AppColors.snackbarBackground,
                              size: 20,
                            ),
                          ));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(
                  width: 8,
                  height: 36,
                ),
                const Icon(Icons.list_alt_rounded),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Punch Detail",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          BlocConsumer<TeamAttendanceBloc, TeamAttendanceState>(
            listener: (context, state) {
              if (state is TeamAttendanceLoaded) {
                _fromDate = state.startDate;
                _toDate = state.endDate;
                _fromDateController.text = _fromDate.ddMonthYYYY();
                _toDateController.text = _toDate.ddMonthYYYY();
              }
            },
            builder: (context, state) {
              if (state is TeamAttendanceLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TeamAttendanceLoaded) {
                return Column(
                  children: [
                    Container(
                      color: AppColors.lightBlue.withValues(alpha: 0.5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 6,
                        children: [
                          Text(
                            "Reporting to",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                state.reportingTo,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: AppColors.grey800),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: AppColors.primary,
                              ),
                              Text(
                                " ${_fromDate.ddMm()} - ${_toDate.ddMm()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: AppColors.primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 12, bottom: 20),
                      child: Row(
                        children: List.generate(
                          state.attendance.length,
                          (index) => GestureDetector(
                            onTap: () {
                              context.read<TeamAttendanceBloc>().add(
                                    TeamAttendanceChangeEvent(
                                      state.attendance[index].date,
                                    ),
                                  );
                            },
                            child: Card(
                              color: state.attendance[index]
                                  .getCardColor(state.selectedDate),
                              margin: const EdgeInsets.only(right: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(state.attendance[index].getDay,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: state.attendance[index]
                                                    .getTextColor(
                                                        state.selectedDate))),
                                    const SizedBox(height: 2),
                                    Text(state.attendance[index].getWeekDay,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: state.attendance[index]
                                                    .getTextColor(
                                                        state.selectedDate))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(0.8),
                            2: FlexColumnWidth(0.55),
                            3: FlexColumnWidth(0.55),
                          },
                          border: TableBorder.all(color: Colors.grey.shade300),
                          children: [
                            TableRow(
                              children: [
                                _buildHeaderCell("Name"),
                                _buildHeaderCell("E Code"),
                                _buildHeaderCell("In"),
                                _buildHeaderCell("Out"),
                              ],
                            ),
                            ...List.generate(state.getAttendanceForDate.length,
                                (index) {
                              return TableRow(
                                children: [
                                  InkWell(
                                    onTap: () => _onTapTeamLead(
                                        state.getAttendanceForDate[index]),
                                    child: SizedBox(
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              " ${state.getAttendanceForDate[index].name}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: AppColors
                                                      .snackbarBackground),
                                            ),
                                          ),
                                          if (state.getAttendanceForDate[index]
                                                  .role ==
                                              "TL")
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                  _buildCell(
                                      state.getAttendanceForDate[index].eCode),
                                  _buildCell(
                                      state.getAttendanceForDate[index].inTime,
                                      color: state.getAttendanceForDate[index]
                                          .getInTimeColor),
                                  _buildCell(
                                      state.getAttendanceForDate[index].outTime,
                                      color: state.getAttendanceForDate[index]
                                          .getOutTimeColor),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(3),
                            1: FlexColumnWidth(1),
                          },
                          border: TableBorder.all(color: Colors.grey.shade300),
                          children: [
                            TableRow(
                              children: [
                                _buildHeaderCell("Status"),
                                _buildHeaderCell("Color"),
                              ],
                            ),
                            ...List.generate(AppConstant.statusList.length,
                                (index) {
                              return TableRow(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "   ${AppConstant.statusList[index]}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                AppColors.snackbarBackground),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Icon(
                                        Icons.circle,
                                        color: AppConstant.statusColors[index],
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is TeamAttendanceError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: const CommonBottomBar(),
    );
  }

  Center _buildHeaderCell(
    String text,
  ) =>
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w900, color: AppColors.primary),
          ),
        ),
      );

  SizedBox _buildCell(
    String text, {
    Color color = AppColors.snackbarBackground,
  }) =>
      SizedBox(
        height: 40,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.normal, color: color),
          ),
        ),
      );

  /// Opens a date picker to select the "from" date.
  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: now,
    );
    if (picked != null) {
      _fromDate = picked;
      final DateTime addedDate = _fromDate.add(const Duration(days: 30));
      _toDate = addedDate.isAfter(now) ? now : addedDate;
      _toDateController.text = _toDate.ddMonthYYYY();
      _fromDateController.text = picked.ddMonthYYYY();
    }
  }

  /// Opens a date picker to select the "to" date.
  Future<void> _selectToDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime addedDate = _fromDate.add(const Duration(days: 30));
    final DateTime lastDate = addedDate.isAfter(now) ? now : addedDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _toDate,
      firstDate: _fromDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      _toDate = picked;
      _toDateController.text = picked.ddMonthYYYY();
    }
  }

  void _onTapViewReport([String? empId, String? reportingTo]) {
    final TeamAttendanceState state = context.read<TeamAttendanceBloc>().state;
    final TeamAttendanceRequest payload;
    if (state is TeamAttendanceLoaded) {
      payload = TeamAttendanceRequest(
        empId: empId ?? state.empId,
        startDate: _fromDate.ddMmYyyy(),
        endDate: _toDate.ddMmYyyy(),
        reportingTo: reportingTo,
      );
    } else {
      payload = TeamAttendanceRequest(
        empId: empId,
        startDate: _fromDate.ddMmYyyy(),
        endDate: _toDate.ddMmYyyy(),
        reportingTo: reportingTo,
      );
    }
    context.read<TeamAttendanceBloc>().add(TeamAttendanceLoadEvent(payload));
  }

  void _onTapTeamLead(DateWiseBiometric teamMember) {
    if (teamMember.role == "TL") {
      _onTapViewReport(teamMember.empId, teamMember.name);
    }
  }
}
