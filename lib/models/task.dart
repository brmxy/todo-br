import 'dart:convert';

class Task {
  Task({
    required this.name,
    this.isSuccess = false,
  });

  final String name;
  final bool isSuccess;

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json["name"],
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "isSuccess": isSuccess,
      };
}
