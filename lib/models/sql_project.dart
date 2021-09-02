import 'package:todo/models/models.dart';

class SQLProject {
  SQLProject({
    this.id,
    required this.title,
    this.description = '',
    this.isMarked = false,
    this.tasks = const <SQLTask>[],
  });

  final int? id;
  final String title;
  final String description;
  final bool isMarked;
  List<SQLTask> tasks;

  factory SQLProject.fromRawJson(String str) =>
      SQLProject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SQLProject.fromJson(Map<String, dynamic> json) => SQLProject(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      isMarked: json["isMarked"] == 1 ? true : false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isMarked": isMarked ? 1 : 0
      };
}
