import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:clientone_ess/features/accountLedger/domain/entity/gl_entity.dart';
import 'package:clientone_ess/features/accountLedger/presetation/blocs/gl_bloc.dart';
import 'package:clientone_ess/shared/components/appbar.dart';
import 'package:clientone_ess/shared/components/date_field.dart';
import 'package:clientone_ess/shared/components/primary_button.dart';
import 'package:clientone_ess/shared/components/section_header.dart';
import 'package:clientone_ess/shared/components/snackbar.dart';
import 'package:clientone_ess/shared/constants/app_constant.dart';

import '../../../core/utils/validations.dart';
import '../../../shared/app_color.dart';
import '../../../shared/components/common_bottombar.dart';
import '../../../shared/components/header.dart';
import '../domain/entity/account_ledger_entity.dart';
import 'blocs/account_ledger_cubit.dart';
import 'blocs/account_ledger_state.dart';
import 'blocs/export_ledger_cubit.dart';
import 'blocs/gl_event.dart';

class AccountLedgerScreen extends StatefulWidget {
  const AccountLedgerScreen({super.key});

  @override
  State<AccountLedgerScreen> createState() => _AccountLedgerScreenState();
}

class _AccountLedgerScreenState extends State<AccountLedgerScreen> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _glController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  GlEntity? _selectedGl;

  @override
  void initState() {
    context.read<GlBloc>().add(GlLoadEvent());
    super.initState();
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2022),
      lastDate: now,
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
      appBar: const AppBarWidget(title: "Account Ledger"),
      body: ListView(
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
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            "GL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16),
                          )),
                      BlocBuilder<GlBloc, AccountLedgerState>(
                          builder: (context, state) {
                        if (state is AccountLedgerLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is AccountLedgerGLLoaded) {
                          return Expanded(
                            flex: 2,
                            child: TextFormField(
                              readOnly: true,
                              onTap: () async {
                                _selectedGl =
                                    await _showDialog(context, state.glEntity);
                                if (_selectedGl != null) {
                                  _glController.text =
                                      "${_selectedGl!.glCode}, ${_selectedGl!.gl}";
                                } else {
                                  _glController.clear();
                                }
                              },
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              validator: Validators.selectGlCode,
                              controller: _glController,
                            ),
                          );
                        } else if (state is AccountLedgerError) {
                          return Text(state.message);
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 20,
                      children: [
                        PrimaryIconButton(
                          onTap: _viewReport,
                          icon: Icons.search,
                          label: "View Report",
                        ),
                        BlocConsumer<ExportLedgerCubit, AccountLedgerState>(
                          listener: (BuildContext context, state) {
                            if (state is AccountLedgerError) {
                              AppSnackBar.errorSnackBar(message: state.message);
                            }
                            if (state is AccountLedgerExport) {
                              AppSnackBar.successSnackBar(
                                  message: state.message);
                            }
                          },
                          builder: (BuildContext context, state) {
                            if (state is AccountLedgerLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return SecondaryIconButton(
                                onTap: _exportReport,
                                icon: Icons.file_download_outlined,
                                label: "Export",
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader(
              label: "Account Ledger Detail", icon: Icons.list_alt_rounded),
          BlocBuilder<AccountLedgerCubit, AccountLedgerState>(
              builder: (context, state) {
            if (state is AccountLedgerLoading) {
              return const SizedBox(
                  child: Center(
                      child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: CircularProgressIndicator(),
              )));
            } else if (state is AccountLedgerLoaded) {
              final AccountLedgerEntity entity = state.accountLedgerEntity;
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue.withValues(alpha: 0.5),
                      border: Border(
                        bottom:
                            BorderSide(width: 1.0, color: AppColors.grey400),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        spacing: 6,
                        children: [
                          _buildRow("Ledger Name",
                              "${_selectedGl!.glCode}, ${_selectedGl!.gl}"),
                          _buildRow("Sub Ledger",
                              "${Sessions.getEmployeeCode()}, ${AppConstant.employeeName.toUpperCase()}"),
                          _buildRow("Run Date", DateTime.now().ddMonthYYYY()),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContainer("Opening Balance", entity.openingBalance),
                  const SizedBox(height: 16),
                  ...List.generate(
                    entity.voucherDetail.length,
                    (index) {
                      final VoucherDetailEntity voucherEntity =
                          entity.voucherDetail[index];
                      return Card(
                        margin: const EdgeInsets.only(
                            left: 6, right: 6, bottom: 12),
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Voucher Detail',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: AppColors.primary)),
                                      Text(
                                        voucherEntity.amount,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary),
                                      ),
                                    ],
                                  )),
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(2),
                                },
                                border: TableBorder.all(
                                    color: Colors.grey.shade300, width: 1),
                                children: [
                                  TableRow(
                                    children: [
                                      _buildHead("Type"),
                                      _buildHead("Number"),
                                      _buildHead("Date"),
                                      _buildHead("Reference"),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      _buildCell(voucherEntity.type),
                                      _buildCell(voucherEntity.number),
                                      _buildCell(voucherEntity.date),
                                      _buildCell(voucherEntity.reference),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    voucherEntity.description,
                                    maxLines: 10,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  _buildContainer("Closing Balance", entity.closingBalance),
                  const SizedBox(height: 16),
                ],
              );
            } else if (state is AccountLedgerError) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(state.message),
              ));
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
      bottomNavigationBar: const CommonBottomBar(),
    );
  }

  void _viewReport() {
    if (_formKey.currentState!.validate()) {
      context.read<AccountLedgerCubit>().getAccountLedger(_fromDate.ddMmYyyy(),
          _toDate.ddMmYyyy(), _selectedGl!.glId, _selectedGl!.glCode);
    }
  }

  void _exportReport() {
    if (_formKey.currentState!.validate()) {
      context.read<ExportLedgerCubit>().ledgerExport(
          _fromDate.ddMmYyyy(), _toDate.ddMmYyyy(), _selectedGl!.glCode);
    }
  }

  Padding _buildCell(String v) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          v,
          style: Theme.of(context).textTheme.titleSmall,
        ));
  }

  Padding _buildHead(String v) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          v,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
        ));
  }

  Container _buildContainer(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withValues(alpha: 0.5),
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColors.grey400),
          top: BorderSide(width: 1.0, color: AppColors.grey400),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Row _buildRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColors.grey800, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  Future<GlEntity?> _showDialog(
      BuildContext context, List<GlEntity> glEntity) async {
    return await showDialog(
        context: context,
        builder: (BuildContext c) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 600, minHeight: 300),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      decoration: const BoxDecoration(
                          color: Color(0x80A7B1E9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          )),
                      child: Text(
                        "Select GL",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(1),
                        },
                        border: TableBorder.all(
                          color: AppColors.grey300,
                          width: 1,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                            ),
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "GL",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "GL Code",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ...List.generate(glEntity.length, (index) {
                            final GlEntity entity = glEntity[index];
                            return TableRow(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context, entity);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(entity.gl,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(entity.glCode,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
