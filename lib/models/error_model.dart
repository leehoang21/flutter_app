import 'dart:convert';

class ErrorModel {
  final String message;

  ErrorModel({
    required this.message,
  });

  factory ErrorModel.fromRawJson(String str) =>
      ErrorModel.fromJson(json.decode(str));

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json["message"],
      );

  @override
  String toString() {
    return message;
  }
}
