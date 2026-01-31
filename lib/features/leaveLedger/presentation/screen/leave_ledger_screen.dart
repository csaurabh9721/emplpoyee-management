import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:clientone_ess/features/leaveLedger/presentation/leaveLedgerBloc/leave_ledger_bloc.dart';
import 'package:clientone_ess/shared/app_color.dart';
import 'package:clientone_ess/shared/components/appbar.dart';
import 'package:clientone_ess/shared/components/date_field.dart';
import 'package:clientone_ess/shared/components/primary_button.dart';
import 'package:clientone_ess/shared/components/section_header.dart';

import '../../../../core/Enums/enums.dart';
import '../../../../shared/components/common_bottombar.dart';
import '../../../../shared/components/header.dart';
import '../../../../shared/components/snackbar.dart';
import '../../domain/entity.dart';

class LeaveLedgerScreen extends StatefulWidget {
  const LeaveLedgerScreen({super.key});

  @override
  State<LeaveLedgerScreen> createState() => _LeaveLedgerScreenState();
}

class _LeaveLedgerScreenState extends State<LeaveLedgerScreen> {
  final TextEditingController _fromDateController = TextEditingController();

  final TextEditingController _toDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _fromDate = DateTime.now();
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
      appBar: const AppBarWidget(title: "Leave Ledger"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Header(
              child: Column(
                children: [
                  _buildDateFilter(context),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20,
                    children: [
                      PrimaryIconButton(
                        onTap: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          context.read<LeaveLedgerBloc>().add(
                              LeaveLedgerFetchEvent(
                                  _fromDate.ddMmYyyy(), _toDate.ddMmYyyy()));
                        },
                        icon: Icons.search,
                        label: "View Report",
                      ),
                      BlocConsumer<LeaveLedgerBloc, LeaveLedgerState>(
                        buildWhen: (previous, current) =>
                            current.exportStatus != previous.exportStatus,
                        listenWhen: (previous, current) =>
                            current.exportStatus != previous.exportStatus,
                        listener: (context, state) {
                          if (state.exportStatus != null) {
                            if (state.exportStatus!.status ==
                                APIStatus.success) {
                              AppSnackBar.successSnackBar(
                                  message: state.exportStatus!.data!);
                            }
                            if (state.exportStatus!.status == APIStatus.error) {
                              AppSnackBar.errorSnackBar(
                                  message: state.exportStatus!.data!);
                            }
                          }
                        },
                        builder: (context, state) {
                          final PayslipApiStatus export = state.exportStatus ??
                              const PayslipApiStatus(status: APIStatus.initial);
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  scale: animation, child: child);
                            },
                            child: export.status == APIStatus.loading
                                ? const CircularProgressIndicator()
                                : SecondaryIconButton(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<LeaveLedgerBloc>().add(
                                            LeaveLedgerExportEvent(
                                                _fromDate.ddMmYyyy(),
                                                _toDate.ddMmYyyy()));
                                      }
                                    },
                                    icon: Icons.file_download_outlined,
                                    label: "Export",
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          const SectionHeader(
              label: "Leave Status", icon: Icons.list_alt_rounded),
          const SizedBox(height: 14),
          Expanded(
            child: BlocBuilder<LeaveLedgerBloc, LeaveLedgerState>(
              buildWhen: (previous, current) =>
                  current.leaveLedger != previous.leaveLedger,
              builder: (context, state) {
                if (state.leaveLedger == null) {
                  return const SizedBox();
                }
                if (state.leaveLedger!.status == APIStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.leaveLedger!.status == APIStatus.error) {
                  return const Center(
                      child: Text("Failed to fetch Leave Ledger"));
                }
                if (state.leaveLedger!.status == APIStatus.success) {
                  final List<LeaveLedgerEntity> list = state.leaveLedger!.data!;
                  return ListView(
                    children: List.generate(list.length, (index) {
                      final LeaveLedgerEntity entity = list[index];
                      return _buildLeaveCard(
                        tag: entity.leaveShortName,
                        title: entity.leaveDescription,
                        fromDate: entity.leaveStartDate,
                        toDate: entity.leaveEndDate,
                        days: entity.total.toString(),
                      );
                    }),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CommonBottomBar(),
    );
  }

  Widget _buildDateFilter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
      ],
    );
  }

  Widget _buildLeaveCard({
    required String tag,
    required String title,
    required String fromDate,
    required String toDate,
    required String days,
  }) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getColor(tag).withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: _getColor(tag),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Text("$days Days",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black))
            ],
          ),
          const SizedBox(height: 6),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16)),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_month,
                  size: 25, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                "$fromDate  -  $toDate",
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }

  Color _getColor(String code) {
    switch (code) {
      case "EL":
        return const Color(0xFF007BCE);
      case "RH":
        return const Color(0xFF207C49);
      case "CL":
        return const Color(0xFF9644C3);
      case "LWP":
        return const Color(0xFFF9A825);
      case "ABS":
        return const Color(0xFFC62828);
      case "ML":
        return const Color(0xFF00838F);
      default:
        return Colors.black;
    }
  }
}
