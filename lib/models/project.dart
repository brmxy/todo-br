import 'package:todo/models/models.dart';

class Project {
  Project({
    required this.id,
    required this.title,
    this.description = '',
    this.isMarked = false,
    this.tasks = const <Task>[],
  });

  final int id;
  final String title;
  final String description;
  final bool isMarked;
  final List<Task> tasks;

  factory Project.fromRawJson(String str) => Project.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isMarked: json["isMarked"],
        tasks: List<Task>.from(json["tasks"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isMarked": isMarked,
        "tasks": List<Task>.from(tasks.map((x) => x)),
      };
}
