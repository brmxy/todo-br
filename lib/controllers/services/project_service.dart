import 'package:todo/controllers/services/index.dart';
import 'package:todo/models/models.dart';

class ProjectService {
  DatabaseService get instance => DatabaseService.instance;

  Future<bool> createProject(Project project) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .insert(
          'tb_project',
          project.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<List<Project>> readAllProjects() async {
    final db = await instance.db;
    final res = await db.query('tb_project', orderBy: 'createdAt DESC');

    if (res.isNotEmpty) {
      final List<Project> projects = res.map<Project>((project) {
        return Project.fromJson(project);
      }).toList();

      return projects;
    } else {
      return [];
    }
  }

  Future<Project?> readOneProject(String projectId) async {
    final db = await instance.db;
    final res =
        await db.query('tb_project', where: 'id = ?', whereArgs: [projectId]);

    if (res.isNotEmpty) {
      final Project project = Project.fromJson(res.first);

      return project;
    } else {
      throw Exception('Cannot find project with the given id $projectId.');
    }
  }

  Future<List<Project>> readMarkedProject() async {
    final db = await instance.db;
    final res = await db.query(
      'tb_project',
      where: 'isMarked = ?',
      whereArgs: [1],
      orderBy: 'createdAt DESC',
    );

    if (res.isNotEmpty) {
      final List<Project> projects = res.map<Project>((project) {
        return Project.fromJson(project);
      }).toList();

      return projects;
    } else {
      return [];
    }
  }

  Future<bool> updateProject(Project project) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .update(
          'tb_project',
          project.toJson(),
          where: 'id = ?',
          whereArgs: [project.id],
        )
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<bool> markProject(String projectId) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .update(
          'tb_project',
          {'isMarked': 1},
          where: 'id = ?',
          whereArgs: [projectId],
        )
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<bool> unmarkProject(String projectId) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .update(
          'tb_project',
          {'isMarked': 0},
          where: 'id = ?',
          whereArgs: [projectId],
        )
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<bool> deleteAllProjects() async {
    var isSuccess;

    final db = await instance.db;
    await db
        .delete('tb_project')
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<bool> deleteOneProject(String projectId) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .delete('tb_project', where: 'id = ?', whereArgs: [projectId])
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }
}
