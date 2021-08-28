import 'package:flutter/material.dart';
import 'package:todo/models/project.dart';
import 'package:todo/widgets/app_bar.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({Key? key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    // double mediaWidth = MediaQuery.of(context).size.width;
    // double mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Text(project.title),
          Text(project.description),
        ],
      ),
    );
  }
}
