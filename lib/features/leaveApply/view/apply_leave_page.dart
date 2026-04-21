import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/leave_apply_controller.dart';

class ApplyLeavePage extends StatefulWidget {
  const ApplyLeavePage({super.key});

  @override
  State<ApplyLeavePage> createState() => _ApplyLeavePageState();
}

class _ApplyLeavePageState extends State<ApplyLeavePage> {
  final LeaveApplyController _controller = Get.put(LeaveApplyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Apply for Leave",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2A7C),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available ${_controller.selectedLeaveBalance.value.leaveTypeFullName} Balance",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${_controller.selectedLeaveBalance.value.availableDays} ${_controller.selectedLeaveBalance.value.type}",
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                "Remaining",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                          const Icon(Icons.calendar_month, color: Colors.white70, size: 50)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Leave Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text("Leave Type"),
              const SizedBox(height: 8),
              Obx(
                () => DropdownButtonFormField<String>(
                  isDense: true,
                  initialValue: _controller.selectedLeaveType.value,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Select type",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: _controller.leaveTypes
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return "Please select leave type";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _controller.selectedLeaveType.value = value!;
                    _controller.selectedLeaveBalance.value =
                        _controller.leaveBalances.firstWhere((e) => e.type == value);
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Date Range Picker
              const Text("Date Range"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _controller.dateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Select date range",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please select date range";
                  }
                  return null;
                },
                onTap: _pickDateRange,
              ),
              const SizedBox(height: 20),
              const Text("Reason for Leave"),
              const SizedBox(height: 8),
              TextFormField(
                  controller: _controller.reasonController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Briefly explain the reason for your request...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter reason";
                    }
                    return null;
                  }),

              const SizedBox(height: 40),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _controller.applyLeave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F2A7C),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Submit Leave Request",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _controller.selectedDateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1F2A7C),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _controller.selectedDateRange = picked;
      _controller.dateController.text =
          "${_controller.selectedDateRange?.start.ddMonthYYYY() ?? ""} - ${_controller.selectedDateRange?.end.ddMonthYYYY() ?? ""}";
    }
  }
}
