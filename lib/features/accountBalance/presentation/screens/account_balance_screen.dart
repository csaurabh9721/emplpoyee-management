import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/features/accountBalance/presentation/bloc/account_balance_cubit.dart';
import 'package:clientone_ess/shared/app_color.dart';

import '../../../../shared/components/appbar.dart';
import '../../../../shared/components/common_bottombar.dart';
import '../../../../shared/components/section_header.dart';

class AccountBalanceScreen extends StatelessWidget {
  const AccountBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountBalanceCubit>().getAccountBalance();
    return Scaffold(
      appBar: const AppBarWidget(title: "Account Balance"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
              label: "Account Balance Status", icon: Icons.list_alt_rounded),
          const SizedBox(height: 20),
          BlocBuilder<AccountBalanceCubit, AccountBalanceState>(
            builder: (BuildContext context, state) {
              if (state is AccountBalanceLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AccountBalanceLoaded) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(5),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
                      },
                      border: TableBorder.all(
                          color: Colors.grey.shade300, width: 1),
                      children: [
                        const TableRow(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('GL',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.darkBlue))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('GL Code',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.darkBlue))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Amount',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.darkBlue))),
                          ],
                        ),
                        ...List.generate(
                          state.entity.length,
                          (index) {
                            return TableRow(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(state.entity[index].gl)),
                                Center(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child:
                                            Text(state.entity[index].glCode))),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(state.entity[index].balance),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
      bottomNavigationBar: const CommonBottomBar(),
    );
  }
}
