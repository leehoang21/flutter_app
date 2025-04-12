import 'dart:convert';

class TransactionModel {
  final String stkGui;
  final String stkNhan;
  final num amount;
  final String pincode;
  // ignore: non_constant_identifier_names
  final String thoiGianGiaoDich;

  factory TransactionModel.fromRawJson(String str) =>
      TransactionModel.fromJson(json.decode(str));

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        stkGui: json["stk_gui"] ?? '',
        stkNhan: json["stk_nhan"] ?? '',
        amount: json["amount"] ?? 0,
        pincode: '',
        thoiGianGiaoDich: json["thoi_gian_giao_dich"] ?? '',
      );

  TransactionModel(
      {required this.stkGui,
      required this.stkNhan,
      required this.amount,
      required this.pincode,
      required this.thoiGianGiaoDich});

  Map<String, dynamic> toJson() => {
        "receiverAccount": stkNhan,
        "amount": amount.toString(),
        "pincode": pincode,
      };

  String toJsonSave() => json.encode({
        "stk_gui": stkGui,
        "stk_nhan": stkNhan,
        "amount": amount,
        "thoi_gian_giao_dich": thoiGianGiaoDich,
      });

  @override
  String toString() {
    return 'TransactionModel{stkGui: $stkGui, stkNhan: $stkNhan, amount: $amount, pincode: $pincode, thoiGianGiaoDich: $thoiGianGiaoDich}';
  }
}
