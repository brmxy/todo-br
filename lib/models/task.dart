import 'package:todo/models/models.dart';

class Task {
  Task({
    required this.id,
    required this.task,
    this.isSuccess = false,
  });

  final int id;
  final String task;
  final bool isSuccess;

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        task: json["task"],
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
        "isSuccess": isSuccess,
      };
}
