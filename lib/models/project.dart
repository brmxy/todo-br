import 'package:todo/models/task.dart';

class Project {
  Project({
    required this.title,
    this.description = '',
    this.isMarked = false,
    this.tasks = const <Task>[],
  });

  String title;
  String description;
  bool isMarked;
  List<Task> tasks;
}
