import 'package:clientone_ess/features/payslip/domain/entity/payslip_entity.dart';

class PayslipResponseMode {
  PayslipResponseMode({
    required this.entity,
    required this.status,
    required this.message,
  });

  factory PayslipResponseMode.fromJson(Map<String, dynamic> json) =>
      PayslipResponseMode(
        entity: json["entity"] != null ? Entity.fromJson(json["entity"]) : null,
        status: json["status"] ?? "",
        message: json["message"] ?? "",
      );
  final Entity? entity;
  final int status;
  final String message;

  PayslipEntity dtoToEntity() {
    final List<PayItemEntity> earnings = [];
    final List<PayItemEntity> deduction = [];
    for (Deduction item in entity!.earnings) {
      earnings.add(PayItemEntity(
        type: item.redCode,
        total: item.total,
        arrear: item.arrear,
        regular: item.regular,
      ));
    }
    for (Deduction item in entity!.deduction) {
      deduction.add(PayItemEntity(
        type: item.redCode,
        total: item.total,
        arrear: item.arrear,
        regular: item.regular,
      ));
    }

    return PayslipEntity(
        workingDays: entity!.employeedata.totalworkingdays,
        present: entity!.employeedata.daypersent,
        paidLeave: entity!.employeedata.paidleave,
        halfPaid: entity!.employeedata.halfpaid,
        unpaid: entity!.employeedata.unpaid,
        payable: entity!.employeedata.totaldayspayable,
        earnings: earnings,
        deductions: deduction,
        netPayable: "₹ ${entity!.summary.actualNetSalary}",
        netPayableInWords: entity!.summary.numericToWord);
  }
}

class Entity {
  Entity({
    required this.summary,
    required this.earnings,
    required this.deduction,
    required this.employeedata,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        summary: json["summary"] != null
            ? Summary.fromJson(json["summary"])
            : Summary(actualNetSalary: "", numericToWord: ""),
        earnings: json["earnings"] != null
            ? List<Deduction>.from(
                json["earnings"].map((x) => Deduction.fromJson(x)))
            : [],
        deduction: json["earnings"] != null
            ? List<Deduction>.from(
                json["deduction"].map((x) => Deduction.fromJson(x)))
            : [],
        employeedata: json["employeedata"] != null
            ? Employeedata.fromJson(json["employeedata"])
            : Employeedata(
                daypersent: 0,
                totaldayspayable: 0.0,
                pfnumber: "",
                employeecode: "",
                totalworkingdays: 0.0,
                bankaccountno: "",
                designation: "",
                halfpaid: 0.0,
                unpaid: 0.0,
                department: "",
                paidleave: 0.0,
                employeename: ""),
      );
  final Summary summary;
  final List<Deduction> earnings;
  final List<Deduction> deduction;
  final Employeedata employeedata;
}

class Deduction {
  Deduction({
    required this.redCode,
    required this.total,
    required this.arrear,
    required this.regular,
  });

  factory Deduction.fromJson(Map<String, dynamic> json) => Deduction(
        redCode: json["redcode"] ?? "",
        total: json["total"] ?? 0.0,
        arrear: json["arrear"] != null
            ? json["arrear"].toString().isNotEmpty
                ? double.parse(json["arrear"])
                : 0.0
            : 0.0,
        regular: json["regular"] != null
            ? json["regular"].toString().isNotEmpty
                ? double.parse(json["regular"])
                : 0.0
            : 0.0,
      );
  final String redCode;
  final double total;
  final double arrear;
  final double regular;
}

class Employeedata {
  Employeedata({
    required this.daypersent,
    required this.totaldayspayable,
    required this.pfnumber,
    required this.employeecode,
    required this.totalworkingdays,
    required this.bankaccountno,
    required this.designation,
    required this.halfpaid,
    required this.unpaid,
    required this.department,
    required this.paidleave,
    required this.employeename,
  });

  factory Employeedata.fromJson(Map<String, dynamic> json) => Employeedata(
        daypersent: json["daypersent"]?.toDouble() ?? 0.0,
        totaldayspayable: json["totaldayspayable"]?.toDouble() ?? 0.0,
        pfnumber: json["pfnumber"] ?? "",
        employeecode: json["employeecode"] ?? "",
        totalworkingdays: json["totalworkingdays"]?.toDouble() ?? 0.0,
        bankaccountno: json["bankaccountno"] ?? "",
        designation: json["designation"] ?? "",
        halfpaid: json["halfpaid"]?.toDouble() ?? 0.0,
        unpaid: json["unpaid"]?.toDouble() ?? 0.0,
        department: json["department"] ?? "",
        paidleave: json["paidleave"]?.toDouble() ?? 0.0,
        employeename: json["employeename"] ?? "",
      );
  final double daypersent;
  final double totaldayspayable;
  final String pfnumber;
  final String employeecode;
  final double totalworkingdays;
  final String bankaccountno;
  final String designation;
  final double halfpaid;
  final double unpaid;
  final String department;
  final double paidleave;
  final String employeename;
}

class Summary {
  Summary({
    required this.actualNetSalary,
    required this.numericToWord,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        actualNetSalary: json["actualnetsalary"] ?? "",
        numericToWord: json["numaricToword"] ?? "",
      );
  final String actualNetSalary;
  final String numericToWord;
}
