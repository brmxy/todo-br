import 'package:todo/models/models.dart';

class SQLTask {
  SQLTask({
    required this.id,
    required this.projectId,
    required this.name,
    this.isSuccess = false,
  });

  final int id;
  final int projectId;
  final String name;
  final bool isSuccess;

  factory SQLTask.fromRawJson(String str) => SQLTask.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SQLTask.fromJson(Map<String, dynamic> json) => SQLTask(
        id: json["id"],
        projectId: json["projectId"],
        name: json["name"],
        isSuccess: json["isSuccess"] == 1 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "projectId": projectId,
        "name": name,
        "isSuccess": isSuccess ? 1 : 0,
      };
}
