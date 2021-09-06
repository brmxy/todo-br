import 'package:todo/models/models.dart';

class Task {
  Task({
    required this.id,
    required this.projectId,
    required this.task,
    this.isDone = false,
  });

  final String id;
  final int projectId;
  final String task;
  final bool isDone;

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        projectId: json["projectId"],
        task: json["task"],
        isDone: json["isDone"] == 1 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "projectId": projectId,
        "task": task,
        "isDone": isDone ? 1 : 0,
      };
}
