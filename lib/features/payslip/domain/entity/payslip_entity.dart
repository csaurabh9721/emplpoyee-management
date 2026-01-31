class PayslipEntity {

  PayslipEntity({
    required this.workingDays,
    required this.present,
    required this.paidLeave,
    required this.halfPaid,
    required this.unpaid,
    required this.payable,
    required this.earnings,
    required this.deductions,
    required this.netPayable,
    required this.netPayableInWords,
  });
  final double workingDays;
  final double present;
  final double paidLeave;
  final double halfPaid;
  final double unpaid;
  final double payable;
  final List<PayItemEntity> earnings;
  final List<PayItemEntity> deductions;
  final String netPayable;
  final String netPayableInWords;

  List<EarningsEntity> get earningsList {
    final List<EarningsEntity> list = [];
    list.add(EarningsEntity(
        type: "Type", regular: "Regular", arrear: "Arrear", total: "Total", isBold: true));
    double totalRegular = 0.0;
    double totalArrear = 0.0;
    double totalTotal = 0.0;
    for (PayItemEntity item in earnings) {
      totalRegular += item.regular;
      totalArrear += item.arrear;
      totalTotal += item.total;
      list.add(EarningsEntity(
          type: item.type,
          regular: item.regular.toString(),
          arrear: item.arrear.toString(),
          total: item.total.toString(),
          isBold: false));
    }
    list.add(EarningsEntity(
        type: "Total",
        regular: totalRegular.toString(),
        arrear: totalArrear.toString(),
        total: totalTotal.toString(),
        isBold: true));

    return list;
  }

  List<EarningsEntity> get deductionsList {
    final List<EarningsEntity> list = [];
    list.add(EarningsEntity(
        type: "Type", regular: "Regular", arrear: "Arrear", total: "Total", isBold: true));
    double totalRegular = 0.0;
    double totalArrear = 0.0;
    double totalTotal = 0.0;

    for (PayItemEntity item in deductions) {
      totalRegular += item.regular;
      totalArrear += item.arrear;
      totalTotal += item.total;
      list.add(EarningsEntity(
          type: item.type,
          regular: item.regular.toString(),
          arrear: item.arrear.toString(),
          total: item.total.toString(),
          isBold: false));
    }
    list.add(EarningsEntity(
        type: "Total",
        regular: totalRegular.toString(),
        arrear: totalArrear.toString(),
        total: totalTotal.toString(),
        isBold: true));
    return list;
  }
}

class EarningsEntity {

  EarningsEntity({
    required this.type,
    required this.regular,
    required this.arrear,
    required this.total,
    required this.isBold,
  });
  final String type;
  final String regular;
  final String arrear;
  final String total;
  final bool isBold;
}

class PayItemEntity {

  PayItemEntity({
    required this.type,
    required this.regular,
    required this.arrear,
    required this.total,
  });
  final String type;
  final double regular;
  final double arrear;
  final double total;
}
