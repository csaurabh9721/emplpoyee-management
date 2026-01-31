import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:clientone_ess/features/leaveBalance/presentation/cubit/leave_balance_cubit.dart';
import 'package:clientone_ess/shared/components/appbar.dart';
import 'package:clientone_ess/shared/components/date_field.dart';
import 'package:clientone_ess/shared/components/section_header.dart';

import '../../../../shared/components/common_bottombar.dart';
import '../../../../shared/components/header.dart';
import '../../domain/entity.dart';
import '../widgets/leave_card_widget.dart';

class LeaveBalanceScreen extends StatefulWidget {
  const LeaveBalanceScreen({super.key});

  @override
  State<LeaveBalanceScreen> createState() => _LeaveBalanceScreenState();
}

class _LeaveBalanceScreenState extends State<LeaveBalanceScreen> {
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );
    if (!mounted) return;
    if (picked != null) {
      _selectedDate = picked;
      _dateController.text = _selectedDate.ddMonthYYYY();
      context
          .read<LeaveBalanceCubit>()
          .getLeaveBalance(_selectedDate.ddMmYyyy());
    }
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = _selectedDate.ddMmYyyy();
    context.read<LeaveBalanceCubit>().getLeaveBalance(_dateController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Leave Balance"),
      body: SafeArea(
        child: Column(
          children: [
            Header(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      "Select Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: DateField(
                        onTap: _pickDate, controller: _dateController),
                  ),
                ],
              ),
            ),
            const SectionHeader(
                label: "Leave Status", icon: Icons.list_alt_rounded),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<LeaveBalanceCubit, LeaveBalanceState>(
                  builder: (context, state) {
                if (state is LeaveBalanceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LeaveBalanceLoaded) {
                  return ListView(
                    children: List.generate(state.entity.length, (index) {
                      final LeaveBalanceEntity entity = state.entity[index];
                      return LeaveCard(
                        code: entity.leaveTypeCode,
                        codeColor: _getColor(entity.leaveTypeCode),
                        codeBgColor: _getColor(entity.leaveTypeCode)
                            .withValues(alpha: 0.4),
                        title: entity.leaveName,
                        openingDate: entity.openingDate,
                        data: {
                          "Opening Balance": entity.openingBalance,
                          "Credited": entity.leaveCredited,
                          "Approval Pending": entity.pendingForApproval,
                          "Current Accumulation": entity.currentAccumulation,
                          "Availed": entity.availed,
                          "Balance": entity.balance
                        },
                      );
                    }),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomBar(),
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
