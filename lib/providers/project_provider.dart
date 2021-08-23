import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/project.dart';

class ProjectProvider extends ChangeNotifier {
  List<Project> _projects = <Project>[];
  List<Project> get projects => _projects;

  void addNewProject(Project project) {
    _projects.insert(0, project);
    notifyListeners();
  }
}
