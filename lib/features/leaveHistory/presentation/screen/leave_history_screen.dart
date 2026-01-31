import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:clientone_ess/shared/app_color.dart';
import 'package:clientone_ess/shared/components/appbar.dart';
import 'package:clientone_ess/shared/components/date_field.dart';
import 'package:clientone_ess/shared/components/primary_button.dart';
import 'package:clientone_ess/shared/components/section_header.dart';

import '../../../../shared/components/common_bottombar.dart';
import '../../../../shared/components/header.dart';
import '../../domain/entity.dart';
import '../bloc/leave_history_bloc.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  final TextEditingController _fromDateController = TextEditingController();

  final TextEditingController _toDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _fromDate = DateTime.now();

  DateTime _toDate = DateTime.now();

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      _fromDate = picked;
      _fromDateController.text = picked.ddMonthYYYY();
      final DateTime addedDate = _fromDate.add(const Duration(days: 365));
      _toDate = addedDate.isAfter(now) ? now : addedDate;
      _toDateController.text = _toDate.ddMonthYYYY();
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
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
      appBar: const AppBarWidget(title: "Leave History"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  BlocBuilder<LeaveHistoryBloc, LeaveHistoryState>(
                    builder: (BuildContext context, LeaveHistoryState state) {
                      return PrimaryButton(
                        onTap: () {
                          if (state is LeaveHistoryLoading) {
                            return;
                          }
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          context.read<LeaveHistoryBloc>().add(
                              LoadLeaveHistoryEvent(
                                  startDate: _fromDate.ddMmYyyy(),
                                  endDate: _toDate.ddMmYyyy()));
                        },
                        label: "Proceed",
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader(
              label: "Leave History Detail", icon: Icons.list_alt_rounded),
          Expanded(
            child: BlocBuilder<LeaveHistoryBloc, LeaveHistoryState>(
                builder: (BuildContext context, LeaveHistoryState state) {
              if (state is LeaveHistoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LeaveHistoryLoaded) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildHeaderCell(
                            flex: 1,
                            text: "SN",
                          ),
                          _divider(),
                          _buildHeaderCell(
                            flex: 3,
                            text: "Start Date",
                          ),
                          _divider(),
                          _buildHeaderCell(
                            flex: 3,
                            text: "End Date",
                          ),
                          _divider(),
                          _buildHeaderCell(
                            flex: 2,
                            text: "Type",
                          ),
                          _divider(),
                          _buildHeaderCell(
                            flex: 2,
                            text: "Days",
                          ),
                        ],
                      ),
                      const Divider(height: 0, color: AppColors.grey),
                      Expanded(
                        child: ListView(
                          children: List.generate(
                            state.entities.length,
                            (index) {
                              final LeaveHistoryEntity item =
                                  state.entities[index];
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      _buildCell(
                                        flex: 1,
                                        text: "${index + 1}",
                                      ),
                                      _divider(),
                                      _buildCell(
                                        flex: 3,
                                        text: item.startDate,
                                      ),
                                      _divider(),
                                      _buildCell(
                                        flex: 3,
                                        text: item.endDate,
                                      ),
                                      _divider(),
                                      _buildCell(
                                        flex: 2,
                                        text: item.type,
                                      ),
                                      _divider(),
                                      _buildCell(
                                        flex: 2,
                                        text: item.days,
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                      height: 0, color: AppColors.grey),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is LeaveHistoryError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox();
              }
            }),
          )
        ],
      ),
      bottomNavigationBar: const CommonBottomBar(),
    );
  }

  Expanded _buildHeaderCell({required int flex, required String text}) =>
      Expanded(
        flex: flex,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w900, color: AppColors.darkBlue),
          ),
        ),
      );

  Expanded _buildCell({required int flex, required String text}) => Expanded(
        flex: flex,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.normal, color: Colors.black87),
          ),
        ),
      );

  Container _divider() {
    return Container(
      height: 45,
      width: 1,
      color: AppColors.grey,
    );
  }
}
