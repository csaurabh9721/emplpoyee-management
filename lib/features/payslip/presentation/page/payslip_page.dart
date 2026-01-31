import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:clientone_ess/shared/app_color.dart';
import 'package:clientone_ess/shared/components/section_header.dart';
import 'package:clientone_ess/shared/components/snackbar.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../../core/Enums/enums.dart';
import '../../../../shared/components/appbar.dart';
import '../../../../shared/components/common_bottombar.dart';
import '../../../../shared/components/date_field.dart';
import '../../../../shared/components/header.dart';
import '../../../../shared/components/primary_button.dart';
import '../../domain/entity/payslip_entity.dart';
import '../bloc/payslip_bloc.dart';

class PayslipPage extends StatefulWidget {
  const PayslipPage({super.key});

  @override
  State<PayslipPage> createState() => _PayslipPageState();
}

class _PayslipPageState extends State<PayslipPage> {
  final TextEditingController _fromDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _fromDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Payslip"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text("Date",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))),
                      Expanded(
                        flex: 2,
                        child: Form(
                          key: _formKey,
                          child: DateField(
                            controller: _fromDateController,
                            onTap: () => _pickDate(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 20,
                      children: [
                        PrimaryIconButton(
                          onTap: () => _onView(context),
                          icon: Icons.search,
                          label: "View Report",
                        ),
                        BlocConsumer<PayslipBloc, PayslipState>(
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
                              if (state.exportStatus!.status ==
                                  APIStatus.error) {
                                AppSnackBar.errorSnackBar(
                                    message: state.exportStatus!.data!);
                              }
                            }
                          },
                          builder: (context, state) {
                            final PayslipApiStatus export =
                                state.exportStatus ??
                                    const PayslipApiStatus(
                                        status: APIStatus.initial);
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
                                      onTap: () => _onExport(context),
                                      icon: Icons.file_download_outlined,
                                      label: "Export",
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SectionHeader(label: "Payslip Detail", icon: Icons.list_alt),
            BlocBuilder<PayslipBloc, PayslipState>(
                buildWhen: (previous, current) =>
                    current.payslip != previous.payslip,
                builder: (context, state) {
                  if (state.payslip == null) {
                    return const SizedBox();
                  }
                  if (state.payslip!.status == APIStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.payslip!.status == APIStatus.error) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Text("Failed to fetch payslip"),
                    ));
                  }
                  if (state.payslip!.status == APIStatus.success) {
                    final PayslipEntity payslip = state.payslip!.data!;
                    return Column(
                      children: [
                        Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: AppColors.grey)),
                          margin: const EdgeInsets.all(16),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              spacing: 4,
                              children: [
                                Row(
                                  children: [
                                    _summaryTile("Working Days",
                                        payslip.workingDays.toString()),
                                    _summaryTile(
                                        "Present", payslip.present.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _summaryTile("Paid Leave",
                                        payslip.paidLeave.toString()),
                                    _summaryTile("Half Paid",
                                        payslip.halfPaid.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _summaryTile(
                                        "Unpaid", payslip.unpaid.toString()),
                                    _summaryTile(
                                        "Payable", payslip.payable.toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: AppColors.grey)),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Earnings",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black)),
                                  const SizedBox(height: 8),
                                  Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: AppColors.grey300, width: 1),
                                      ),
                                      child: ListView.separated(
                                        itemCount: payslip.earningsList.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final EarningsEntity item =
                                              payslip.earningsList[index];
                                          final TextStyle style = TextStyle(
                                            fontSize: 15,
                                            fontWeight: item.isBold
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: item.isBold
                                                ? Colors.black
                                                : AppColors.grey800,
                                          );
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.type,
                                                    style: style,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.regular,
                                                    style: style,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.arrear,
                                                    style: style,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  item.total,
                                                  style: style,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ]),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                                height: 0,
                                                color: AppColors.grey300),
                                      )),
                                ]),
                          ),
                        ),
                        Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: AppColors.grey)),
                          margin: const EdgeInsets.all(16),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Deductions",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black)),
                                  const SizedBox(height: 8),
                                  Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: AppColors.grey300, width: 1),
                                      ),
                                      child: ListView.separated(
                                        itemCount:
                                            payslip.deductionsList.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final EarningsEntity item =
                                              payslip.deductionsList[index];
                                          final TextStyle style = TextStyle(
                                            fontSize: 15,
                                            fontWeight: item.isBold
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: item.isBold
                                                ? Colors.black
                                                : AppColors.grey800,
                                          );
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.type,
                                                    style: style,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.regular,
                                                    style: style,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.arrear,
                                                    style: style,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  item.total,
                                                  style: style,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ]),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                                height: 0,
                                                color: AppColors.grey300),
                                      )),
                                ]),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue.withValues(alpha: 0.5),
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.0, color: AppColors.grey400),
                              top: BorderSide(
                                  width: 1.0, color: AppColors.grey400),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Net Payable",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    payslip.netPayable.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary),
                                  ),
                                ],
                              ),
                              Text(
                                payslip.netPayableInWords.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                }),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomBar(),
    );
  }

  void _pickDate(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime(2000),
    );
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime(2000),
    //   lastDate: DateTime.now(),
    //   initialEntryMode: DatePickerEntryMode.calendarOnly,
    // );
    if (picked != null) {
      _fromDate = picked;
      _fromDateController.text = _fromDate.monthYYYY();
    }
  }

  Widget _summaryTile(final String title, final String value) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w500))),
          const SizedBox(width: 16),
          Expanded(
              flex: 1,
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
        ],
      ),
    );
  }

  void _onView(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<PayslipBloc>().add(ViewPaySlipEvent(_fromDate.ddMmYyyy()));
    }
  }

  void _onExport(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context
          .read<PayslipBloc>()
          .add(DownLoadPaySlipEvent(_fromDate.ddMmYyyy()));
    }
  }
}
