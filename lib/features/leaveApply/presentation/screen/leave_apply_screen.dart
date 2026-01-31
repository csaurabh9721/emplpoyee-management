import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:clientone_ess/core/utils/string_extensions.dart';
import 'package:clientone_ess/core/utils/validations.dart';
import 'package:clientone_ess/features/leaveApply/presentation/validations/apply_leave_validations.dart';
import 'package:clientone_ess/shared/app_color.dart';
import 'package:clientone_ess/shared/components/appbar.dart';
import 'package:clientone_ess/shared/components/label.dart';
import 'package:clientone_ess/shared/components/primary_button.dart';
import 'package:clientone_ess/shared/components/snackbar.dart';

import '../../../../core/Enums/enums.dart';
import '../../../../shared/components/common_bottombar.dart';
import '../../../../shared/components/date_field.dart';
import '../../../../shared/constants/png_images.dart';
import '../../domain/entities/leave_balance_entity.dart';
import '../cubits/change_leave_type_cubit.dart';
import '../cubits/continuousPaidLeaveCubit/continuous_paid_leave_cubit.dart';
import '../cubits/getLeaveBalanceCubit/get_leave_balance_cubit.dart';
import '../cubits/leaveSaveCubit/leave_save_cubit.dart';
import '../cubits/start_period_cubit.dart';
import '../cubits/upload_file_cubit.dart';
import '../validations/select_leave_type_validation.dart';

class LeaveApplyScreen extends StatefulWidget {
  const LeaveApplyScreen({super.key});

  @override
  State<LeaveApplyScreen> createState() => _LeaveApplyScreenState();
}

class _LeaveApplyScreenState extends State<LeaveApplyScreen> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  final TextEditingController _noDayController = TextEditingController();

  final TextEditingController _reasonController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //String _selectedLeaveType = "";
  String _startFromFHSH = LeaveStartPeriod.secondHalf.name.firstLetters;
  late final ApplyLeaveValidations _applyLeaveValidations;
  late final SelectLeaveTypeValidation _leaveTypeValidation;

  @override
  void initState() {
    _applyLeaveValidations = ApplyLeaveValidations(context);
    _leaveTypeValidation = SelectLeaveTypeValidation(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Leave Apply"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<GetLeaveBalanceCubit, GetLeaveBalanceState>(
                listener: (context, state) {
                  if (state is GetLeaveBalanceSuccess &&
                      state.leaveBalanceEntity.holiDayPopup) {
                    _warningDialog(
                        context, "Are you sure want apply leave on holiday?");
                  }
                  if (state is GetLeaveBalanceError) {
                    AppSnackBar.errorSnackBar(message: state.message);
                  }
                },
                child: _buildRow(
                  "From Date",
                  child: DateField(
                    controller: _dateController,
                    onTap: _pickDate,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildRow(
                "Leave Start Period",
                child: BlocBuilder<StartPeriodCubit, StartPeriodState>(
                  builder: (context, state) {
                    final bool isSelected =
                        LeaveStartPeriod.firstHalf == state.leaveStartPeriod;
                    return Row(
                      children: [
                        _buildRadioButton(
                          isSelected: isSelected,
                          str: LeaveStartPeriod.firstHalf.name,
                          onTap: () {
                            _startFromFHSH =
                                LeaveStartPeriod.firstHalf.name.firstLetters;
                            context
                                .read<StartPeriodCubit>()
                                .toggleLeaveStartPeriod(
                                    LeaveStartPeriod.firstHalf);
                          },
                        ),
                        _buildRadioButton(
                          isSelected: !isSelected,
                          str: LeaveStartPeriod.secondHalf.name,
                          onTap: () {
                            _startFromFHSH =
                                LeaveStartPeriod.secondHalf.name.firstLetters;
                            context
                                .read<StartPeriodCubit>()
                                .toggleLeaveStartPeriod(
                                    LeaveStartPeriod.secondHalf);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              _buildRow("No of Days",
                  child: TextFormField(
                    controller: _noDayController,
                    keyboardType: TextInputType.number,
                    validator: Validators.notEmpty,
                  )),
              const SizedBox(height: 16),
              _buildRow(
                "Leave Type",
                child: BlocListener<ContinuousPaidLeaveCubit,
                    ContinuousPaidLeaveState>(
                  listener: (context, state) {
                    if (state is ContinuousPaidLeaveSuccess) {
                      if (state.continuousPaidLeave!.keys.first == 201) {
                        context
                            .read<ChangeLeaveTypeCubit>()
                            .changeLeveType(null);
                        _applyLeaveValidations.leaveTypeValidationDialog(
                            state.continuousPaidLeave![
                                state.continuousPaidLeave!.keys.first]!);
                      }
                    }
                    if (state is ContinuousPaidLeaveError) {
                      AppSnackBar.errorSnackBar(message: state.message);
                    }
                  },
                  child:
                      BlocBuilder<GetLeaveBalanceCubit, GetLeaveBalanceState>(
                    builder: (context, state) {
                      if (state is GetLeaveBalanceLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is GetLeaveBalanceSuccess) {
                        return BlocBuilder<ChangeLeaveTypeCubit,
                            ChangeLeaveTypeState>(
                          builder: (context, st) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: st.leaveBalance == null
                                            ? AppColors.error
                                            : AppColors.grey),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<LeaveListEntity>(
                                      isDense: true,
                                      items: state.leaveBalanceEntity.leaveList
                                          .map((type) {
                                        return DropdownMenuItem(
                                            value: type,
                                            child: Text(type.leaveTypeCode));
                                      }).toList(),
                                      hint: Text(
                                        st.leaveBalance == null
                                            ? "Select Leave Type"
                                            : st.leaveBalance!.leaveTypeCode,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: AppColors.snackbarBackground,
                                        ),
                                      ),
                                      onChanged: (value) async {
                                        final cubit = context
                                            .read<ChangeLeaveTypeCubit>();
                                        final bool isValidation =
                                            await _leaveTypeValidation
                                                .selectLeaveValidation(
                                                    selectedLeave: value!,
                                                    noDays:
                                                        _noDayController.text,
                                                    date: _selectedDate!
                                                        .ddMmYyyy(),
                                                    period: _startFromFHSH);
                                        if (isValidation) {
                                          cubit.changeLeveType(value);
                                          _formKey.currentState!.validate();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                if (st.leaveBalance == null)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 4, left: 16),
                                    child: Text("Please Select Leave Type",
                                        style: TextStyle(
                                          color: AppColors.error,
                                          fontSize: 11,
                                        )),
                                  )
                              ],
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildRow(
                "Leave Balance",
                child: BlocBuilder<ChangeLeaveTypeCubit, ChangeLeaveTypeState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${state.leaveBalance?.leaveBalance ?? 0} Days",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            state.leaveBalance?.leaveTypeCode ?? "--",
                            style: const TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Label(str: "Leave Reason / Remarks"),
              const SizedBox(height: 4),
              TextFormField(
                maxLines: 4,
                controller: _reasonController,
              ),
              const SizedBox(height: 16),
              BlocBuilder<ChangeLeaveTypeCubit, ChangeLeaveTypeState>(
                builder: (context, ltState) {
                  final String reason =
                      ltState.leaveBalance?.documentRequired ?? "N";
                  return reason.isEqual("Y")
                      ? BlocBuilder<UploadFileCubit, UploadFileState>(
                          builder: (context, state) {
                            return GestureDetector(
                              // onTap: () => _showFilePickerBottomSheet(context),
                              onTap: () {
                                // context.read<UploadFileCubit>().uploadFile(FilePickSource.pdf);
                              },
                              child: state.uploadedFile != null
                                  ? state.uploadedFile!.type ==
                                          FilePickSource.pdf
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors.error),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: const Icon(
                                                      Icons.picture_as_pdf,
                                                      color: AppColors.error,
                                                      size: 80)),
                                              const SizedBox(height: 8),
                                              Text(
                                                state.uploadedFile!.path
                                                    .split("/")
                                                    .last,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Image.file(
                                          state.uploadedFile!.name,
                                          fit: BoxFit.cover,
                                          height: 120,
                                        )
                                  : DottedBorder(
                                      options: const RectDottedBorderOptions(
                                        color: Colors.teal,
                                        dashPattern: [6, 3],
                                      ),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 120,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(PngImages.uploadIcon),
                                            const SizedBox(height: 4),
                                            const Text(
                                              "Upload File",
                                              style: TextStyle(
                                                color: Colors.teal,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.teal,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                            );
                          },
                        )
                      : const SizedBox();
                },
              ),
              const SizedBox(height: 16),
              BlocConsumer<LeaveSaveCubit, LeaveSaveState>(
                listener: (context, state) {
                  if (state is SuccessLeaveSaveState) {
                    Navigator.pop(context);
                    AppSnackBar.successSnackBar(message: state.message);
                  }
                  if (state is ErrorLeaveSaveState) {
                    AppSnackBar.errorSnackBar(message: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is LoadingLeaveSaveState) {
                    return const CircularProgressIndicator();
                  }
                  return Center(
                    child: PrimaryIconButton(
                      onTap: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _applyLeaveValidations.applyLeaveValidation(
                            noDays: _noDayController.text,
                            date: _selectedDate!.ddMmYyyy(),
                            period: _startFromFHSH,
                            remark: _reasonController.text);
                      },
                      icon: Icons.save,
                      label: "Save",
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CommonBottomBar(),
    );
  }

  Row _buildRow(String title, {required Widget child}) {
    return Row(
      children: [
        Expanded(flex: 1, child: Label(str: title)),
        Expanded(
          flex: 2,
          child: child,
        ),
      ],
    );
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );
    if (!mounted) return;
    if (picked != null) {
      _dateController.text = picked.ddMonthYYYY();
      _selectedDate = picked;
      _noDayController.clear();
      context
          .read<GetLeaveBalanceCubit>()
          .loadLeaveBalance(_selectedDate!.ddMmYyyy());
      context.read<ChangeLeaveTypeCubit>().changeLeveType(null);
    }
  }

  Expanded _buildRadioButton({
    required bool isSelected,
    required String str,
    required VoidCallback onTap,
  }) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.snackbarBackground,
              ),
            ),
            child: Icon(
              Icons.circle,
              color: isSelected ? AppColors.primary : Colors.transparent,
              size: 16,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            str,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.snackbarBackground,
            ),
          )
        ]),
      ),
    );
  }

  // void _showFilePickerBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
  //     ),
  //     builder: (_) {
  //       return SizedBox(
  //         height: 180,
  //         child: Column(
  //           children: [
  //             const SizedBox(height: 16),
  //             Padding(
  //               padding: const EdgeInsets.only(left: 15.0, right: 15.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text("Add File",
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
  //                   GestureDetector(
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: const Icon(
  //                       Icons.close,
  //                       color: Colors.black,
  //                       size: 25,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const Divider(
  //               color: AppColors.grey,
  //               thickness: 1,
  //               indent: 15,
  //               endIndent: 15,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   _buildFileOption(context, Icons.image, "Gallery", FilePickSource.gallery),
  //                   _buildFileOption(context, Icons.camera_alt, "Camera", FilePickSource.camera),
  //                   _buildFileOption(context, Icons.picture_as_pdf, "PDF", FilePickSource.pdf),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _buildFileOption(
  //     BuildContext context, IconData icon, String label, FilePickSource source) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.pop(context);
  //       context.read<UploadFileCubit>().uploadFile(source);
  //     },
  //     child: Column(
  //       children: [
  //         CircleAvatar(
  //           radius: 35,
  //           backgroundColor: AppColors.primary,
  //           child: Icon(icon, color: Colors.white, size: 28),
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           label,
  //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _warningDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Text(message,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                _selectedDate = null;
                _dateController.clear();
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
