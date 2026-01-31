import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:clientone_ess/shared/components/appbar.dart';
import 'package:clientone_ess/shared/components/label.dart';
import 'package:clientone_ess/shared/components/primary_button.dart';
import 'package:clientone_ess/shared/components/section_header.dart';
import 'package:clientone_ess/shared/components/snackbar.dart';

import '../../../../shared/app_color.dart';
import '../../../../shared/components/common_bottombar.dart';
import '../../../../shared/components/date_field.dart';
import '../../../../shared/components/header.dart';
import '../../domain/attendance_entity.dart';
import '../bloc/attendance_bloc.dart';

/// A screen that displays attendance information.
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  DateTime _fromDate = DateTime.now();

  // ignore: unused_field
  DateTime _toDate = DateTime.now();

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
      final DateTime addedDate = _fromDate.add(const Duration(days: 365));
      _toDate = addedDate.isAfter(now) ? now : addedDate;
      _toDateController.text = _toDate.ddMonthYYYY();
      _fromDateController.text = picked.ddMonthYYYY();
    }
  }

  /// Opens a date picker to select the "to" date.
  Future<void> _selectToDate(BuildContext context) async {
    if (_fromDateController.text.isEmpty) {
      AppSnackBar.infoSnackBar(message: "Please Select From Date");
      return;
    }
    final DateTime now = DateTime.now();
    final DateTime addedDate = _fromDate.add(const Duration(days: 365));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Attendance"),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Header(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20,
                    children: [
                      SecondaryIconButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AttendanceBloc>().add(
                                  AttendanceViewDetailEvent(
                                    _fromDate.ddMmYyyy(),
                                    _toDate.ddMmYyyy(),
                                  ),
                                );
                          }
                        },
                        icon: Icons.file_download_outlined,
                        label: "View Detail",
                      ),
                      PrimaryIconButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AttendanceBloc>().add(
                                  AttendanceViewSummaryEvent(
                                    _fromDate.ddMmYyyy(),
                                    _toDate.ddMmYyyy(),
                                  ),
                                );
                          }
                        },
                        icon: Icons.search,
                        label: "View Summary",
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          const SectionHeader(
              label: "Punch Detail", icon: Icons.list_alt_rounded),
          const SizedBox(height: 10),
          BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, state) {
              if (state is AttendanceLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AttendanceLoaded) {
                return state.isSummary
                    ? _summary(state.entity)
                    : _viewDetail(state.entity);
              } else if (state is AttendanceError) {
                return Center(child: Text(state.error));
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

  Widget _viewDetail(
    AttendanceEntity entity,
  ) {
    return Column(
      spacing: 20,
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1.5),
                    4: FlexColumnWidth(2),
                  },
                  border: TableBorder.all(color: Colors.grey.shade300),
                  children: [
                    TableRow(
                      children: [
                        _buildHeaderCell("Date"),
                        _buildHeaderCell("In"),
                        _buildHeaderCell("Out"),
                        _buildHeaderCell("Short Hour"),
                        _buildHeaderCell("Status"),
                      ],
                    ),
                  ],
                ),
                ...List.generate(entity.biometricDetails.length, (index) {
                  final BiometricDetailsEntity item =
                      entity.biometricDetails[index];
                  return Column(
                    children: [
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1.5),
                          4: FlexColumnWidth(2),
                        },
                        border: TableBorder.all(color: Colors.grey.shade300),
                        children: [
                          TableRow(
                            children: [
                              _buildHeaderCell(item.date),
                              _buildCell(item.inTime),
                              _buildCell(item.outTime),
                              _buildCell(item.shortHour,
                                  color: item.shortHourColor),
                              _buildCellContainer(
                                  item.status, item.statusColor),
                            ],
                          )
                        ],
                      ),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1.46),
                          1: FlexColumnWidth(4),
                        },
                        border: TableBorder.all(color: Colors.grey.shade300),
                        children: [
                          TableRow(
                            children: [
                              _buildCell(item.weekDay),
                              _buildCell(item.description),
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 50),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Label(str: "Time Statistics"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCell("Total Working Hours", size: 26),
                    _buildHeaderCell(entity.totalWorkingHour, size: 0),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCell("Total Short Hours", size: 26),
                    _buildHeaderCell(entity.totalShortHour,
                        color: entity.totalShortHourColor, size: 0),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCell("Total Penalties", size: 26),
                    _buildHeaderCell(entity.totalPenalties, size: 0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Center _buildHeaderCell(String text,
          {Color color = AppColors.darkBlue, double size = 8}) =>
      Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w900, color: color),
          ),
        ),
      );

  SizedBox _buildCell(String text,
          {Color color = AppColors.snackbarBackground, double size = 40}) =>
      SizedBox(
        height: size,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.normal, color: color),
          ),
        ),
      );

  SizedBox _buildCellContainer(String text, Color color) {
    return SizedBox(
      height: 40,
      child: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: color, fontSize: 13),
          ),
        ),
      ),
    );
  }

  Padding _summary(
    AttendanceEntity attendanceEntity,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children:
            List.generate(attendanceEntity.attendanceSummary.length, (index) {
          final AttendanceSummary item =
              attendanceEntity.attendanceSummary[index];
          return SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 17,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        backgroundColor: item.cardColor.withValues(alpha: 0.2),
                        radius: 26,
                        child:
                            Icon(item.icon, color: item.cardColor, size: 30)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title,
                              maxLines: 3,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 4),
                          Text(item.value,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
