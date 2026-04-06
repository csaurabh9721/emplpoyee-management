import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/Enums/enums.dart';
import '../../../core/routes/routes_name.dart';
import '../controllers/account_balance_controller.dart';
import '../models/account_balance_model.dart';

class AccountBalanceScreen extends GetView<AccountBalanceController> {
  const AccountBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FD),
        appBar: AppBar(
          title: const Text('Employee Account', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => _showFilterBottomSheet(context),
              icon: const Icon(Icons.tune),
            )
          ],
          bottom: const TabBar(
            labelColor: Colors.indigo,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.indigo,
            indicatorWeight: 3,
            tabs: [
              Tab(text: 'Completed'),
              Tab(text: 'Upcoming'),
            ],
          ),
        ),
        body: GetBuilder<AccountBalanceController>(
          init: AccountBalanceController(),
          builder: (controller) {
            return TabBarView(
              children: [
                _TabContent(
                  balances: controller.completedBalances,
                  totalAmount: controller.totalCompletedAmount,
                  status: controller.status.value,
                  controller: controller,
                ),
                _TabContent(
                  balances: controller.pendingBalances,
                  totalAmount: controller.totalPendingAmount,
                  status: controller.status.value,
                  controller: controller,
                  isUpcoming: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _FilterBottomSheet(controller: controller),
    );
  }
}

class _TabContent extends StatelessWidget {
  final List<AccountBalanceModel> balances;
  final double totalAmount;
  final ApiStatus status;
  final AccountBalanceController controller;
  final bool isUpcoming;

  const _TabContent({
    required this.balances,
    required this.totalAmount,
    required this.status,
    required this.controller,
    this.isUpcoming = false,
  });

  @override
  Widget build(BuildContext context) {
    if (status == ApiStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (status == ApiStatus.error) {
      return const Center(child: Text('Error loading account data'));
    }

    return Column(
      children: [
        _SummarySection(
          totalAmount: totalAmount,
          startDate: controller.startDate.value,
          endDate: controller.endDate.value,
          selectedType: controller.selectedType.value,
          isUpcoming: isUpcoming,
        ),
        Expanded(
          child: balances.isEmpty
              ? _EmptyState()
              : RefreshIndicator(
                  onRefresh: controller.fetchBalances,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: balances.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _AccountDetailCard(balance: balances[index]);
                    },
                  ),
                ),
        ),
      ],
    );
  }
}

class _SummarySection extends StatelessWidget {
  final double totalAmount;
  final DateTime startDate;
  final DateTime endDate;
  final String selectedType;
  final bool isUpcoming;

  const _SummarySection({
    required this.totalAmount,
    required this.startDate,
    required this.endDate,
    required this.selectedType,
    required this.isUpcoming,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = isUpcoming ? Colors.orange.shade800 : Colors.indigo;
    final Color secondaryColor = isUpcoming ? Colors.orange.shade600 : Colors.indigo.shade800;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isUpcoming ? 'Estimated Total' : 'Total Balance',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  selectedType,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '₹ ${totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.date_range, color: Colors.white70, size: 16),
              const SizedBox(width: 8),
              Text(
                '${DateFormat('MMM yyyy').format(startDate)} - ${DateFormat('MMM yyyy').format(endDate)}',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterBottomSheet extends StatelessWidget {
  final AccountBalanceController controller;
  const _FilterBottomSheet({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filters',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Text('Transaction Type', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Obx(() => Wrap(
            spacing: 10,
            children: controller.types.map((type) {
              final isSelected = controller.selectedType.value == type;
              return ChoiceChip(
                label: Text(type),
                selected: isSelected,
                selectedColor: Colors.indigo.shade100,
                onSelected: (val) {
                  if (val) controller.setType(type);
                },
              );
            }).toList(),
          )),
          const SizedBox(height: 24),
          const Text('Select Period', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MonthButton(
                  label: 'Start',
                  date: controller.startDate.value,
                  onTap: () => _selectMonth(context, controller.startDate.value, controller.setStartDate),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _MonthButton(
                  label: 'End',
                  date: controller.endDate.value,
                  onTap: () => _selectMonth(context, controller.endDate.value, controller.setEndDate),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Apply Filters', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _selectMonth(BuildContext context, DateTime initial, Function(DateTime) onSelect) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)), // Allow future for upcoming
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      onSelect(DateTime(picked.year, picked.month, 1));
    }
  }
}

class _MonthButton extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;

  const _MonthButton({required this.label, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('MMM yyyy').format(date), style: const TextStyle(fontWeight: FontWeight.bold)),
                const Icon(Icons.calendar_month, size: 18, color: Colors.indigo),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountDetailCard extends StatelessWidget {
  final AccountBalanceModel balance;
  const _AccountDetailCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    final bool isNotCompleted = balance.status != LedgerStatus.completed;

    return InkWell(
      onTap: () => Get.toNamed('${RoutesName.accountDetail}/${balance.id}'),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _getTypeColor(balance.typeMember).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        balance.typeMember,
                        style: TextStyle(
                          color: _getTypeColor(balance.typeMember),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    if (isNotCompleted) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: _getStatusColor(balance.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          balance.status.name.toUpperCase(),
                          style: TextStyle(
                            color: _getStatusColor(balance.status),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  balance.date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              balance.description,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.tag, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  balance.reference,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isNotCompleted ? 'Estimated Amount' : 'Amount Received',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Text(
                  '${balance.currency} ${balance.amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1B1D28)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'salary': return Colors.green;
      case 'conveyance': return Colors.orange;
      case 'bonus': return Colors.purple;
      default: return Colors.indigo;
    }
  }

  Color _getStatusColor(LedgerStatus status) {
    switch (status) {
      case LedgerStatus.pending: return Colors.amber.shade900;
      case LedgerStatus.upcoming: return Colors.blue.shade700;
      default: return Colors.green;
    }
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No transactions found',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Try adjusting your filters', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
