import 'package:todo/controllers/services/index.dart';
import 'package:todo/models/models.dart';

class ProjectService {
  DatabaseService get instance => DatabaseService.instance;

  Future<bool> createProject(SQLProject project) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .insert('tb_project', project.toJson())
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<List<SQLProject>> readAllProjects() async {
    final db = await instance.db;
    final res = await db.query('tb_project');

    if (res.isNotEmpty) {
      final List<SQLProject> projects = res.map<SQLProject>((project) {
        return SQLProject.fromJson(project);
      }).toList();

      return projects;
    } else {
      return [];
    }
  }

  Future<SQLProject?> readOneProject(int projectId) async {
    final db = await instance.db;
    final res = await db
        .query('tb_project', where: 'projectId = ?', whereArgs: [projectId]);

    if (res.isNotEmpty) {
      final SQLProject project = SQLProject.fromJson(res.first);

      return project;
    } else {
      throw Exception('Cannot find project with the given id $projectId.');
    }
  }

  Future<bool> updateProject(SQLProject project) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .update('tb_project', project.toJson(),
            where: 'projectId = ?', whereArgs: [project.id])
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<bool> deleteProject(int projectId) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .delete('tb_project', where: 'projectId = ?', whereArgs: [projectId])
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }
}
