import 'package:todo/models/models.dart';

class Project {
  Project({
    required this.id,
    required this.title,
    this.description = '',
    this.isMarked = false,
    this.tasks = const <Task>[],
    required this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final bool isMarked;
  List<Task> tasks;
  final DateTime createdAt;

  factory Project.fromRawJson(String str) => Project.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isMarked: json["isMarked"] == 1 ? true : false,
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isMarked": isMarked ? 1 : 0,
        "createdAt": createdAt.toIso8601String(),
      };
}
