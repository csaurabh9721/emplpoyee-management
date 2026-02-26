import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/routes_name.dart';

class PayslipHistoryPage extends StatelessWidget {
  const PayslipHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF4F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(),
              SizedBox(height: 24),
              _TabSection(),
              SizedBox(height: 24),
              _CurrentSummary(),
              SizedBox(height: 30),
              _PreviousPayslips(),
            ],
          ),
        ),
      ),
    );
  }
}
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.arrow_back, color: Colors.indigo),
        ),
        const Spacer(),
        const Text(
          "Payslip History",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.download, color: Colors.indigo),
        ),
      ],
    );
  }
}
class _TabSection extends StatelessWidget {
  const _TabSection();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent",
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 6),
            SizedBox(
              width: 60,
              child: Divider(
                thickness: 3,
                color: Colors.indigo,
              ),
            )
          ],
        ),
        SizedBox(width: 30),
        Text(
          "Archive",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
class _CurrentSummary extends StatelessWidget {
  const _CurrentSummary();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                "October 2023 Summary",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "PAID",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),

        /// Gross & Deduction
        const Row(
          children: [
            Expanded(
              child: _SmallSummaryCard(
                title: "GROSS PAY",
                amount: "\$5,200.00",
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _SmallSummaryCard(
                title: "DEDUCTIONS",
                amount: "-\$1,100.00",
                isNegative: true,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        /// Net Pay
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF252A8F),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NET PAY",
                      style: TextStyle(
                        color: Colors.white70,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "\$4,100.00",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Icon(Icons.account_balance_wallet,
                  color: Colors.white70)
            ],
          ),
        )
      ],
    );
  }
}
class _SmallSummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final bool isNegative;

  const _SmallSummaryCard({
    required this.title,
    required this.amount,
    this.isNegative = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.grey,
                  letterSpacing: 1)),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isNegative
                  ? Colors.red
                  : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
class _PreviousPayslips extends StatelessWidget {
  const _PreviousPayslips();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Previous Payslips",
          style:
          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        _PayslipTile(
          month: "September 2023",
          date: "Paid on Sept 28, 2023",
          amount: "\$4,100.00",
        ),
        SizedBox(height: 16),
        _PayslipTile(
          month: "August 2023",
          date: "Paid on Aug 30, 2023",
          amount: "\$3,950.00",
        ),
        SizedBox(height: 16),
        _PayslipTile(
          month: "July 2023",
          date: "Paid on July 28, 2023",
          amount: "\$3,950.00",
        ),
        SizedBox(height: 30),
        _LoadMoreButton(),
      ],
    );
  }
}
class _PayslipTile extends StatelessWidget {
  final String month;
  final String date;
  final String amount;

  const _PayslipTile({
    required this.month,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(RoutesName.payslipDetail,arguments: "1");
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.calendar_today,
                  color: Colors.indigo),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(month,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(date,
                      style: const TextStyle(
                          color: Colors.grey)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [
                Text(amount,
                    style: const TextStyle(
                        fontWeight:
                        FontWeight.bold)),
                const SizedBox(height: 6),
                const Text(
                  "View  >",
                  style: TextStyle(
                      color: Colors.indigo),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
class _LoadMoreButton extends StatelessWidget {
  const _LoadMoreButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.indigo.shade200,
          width: 2,
        ),
      ),
      child: const Center(
        child: Text(
          "Load More History",
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}