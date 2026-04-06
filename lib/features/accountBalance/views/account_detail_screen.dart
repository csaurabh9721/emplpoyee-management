import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../controllers/account_detail_controller.dart';
import '../models/account_balance_model.dart';

class AccountDetailScreen extends GetView<AccountDetailController> {
  const AccountDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text('Account Detail', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: GetBuilder<AccountDetailController>(
        init: AccountDetailController(),
        builder: (controller) {
          if (controller.status.value == ApiStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.status.value == ApiStatus.error || controller.accountDetail.value == null) {
            return const Center(child: Text('Error loading details'));
          }

          final detail = controller.accountDetail.value!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeaderCard(detail: detail),
                const SizedBox(height: 24),
                if (detail.earnings.isNotEmpty) ...[
                  _SectionTitle(title: 'Earnings'),
                  _DetailList(items: detail.earnings, color: Colors.green),
                  const SizedBox(height: 20),
                ],
                if (detail.deductions.isNotEmpty) ...[
                  _SectionTitle(title: 'Deductions'),
                  _DetailList(items: detail.deductions, color: Colors.red),
                  const SizedBox(height: 20),
                ],
                if (detail.others.isNotEmpty) ...[
                  _SectionTitle(title: 'Details'),
                  _DetailList(items: detail.others, color: Colors.indigo),
                  const SizedBox(height: 20),
                ],
                _TotalFooter(detail: detail),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final AccountDetailModel detail;
  const _HeaderCard({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(detail.type, style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
              Text(detail.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(detail.description, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Reference: ${detail.reference}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
    );
  }
}

class _DetailList extends StatelessWidget {
  final List<DetailItem> items;
  final Color color;
  const _DetailList({required this.items, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.label, style: const TextStyle(color: Colors.black54)),
                Text(
                  '${item.value >= 0 ? '' : '-'} ${item.value.abs().toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TotalFooter extends StatelessWidget {
  final AccountDetailModel detail;
  const _TotalFooter({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Net Amount', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          Text(
            '${detail.currency} ${detail.totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
