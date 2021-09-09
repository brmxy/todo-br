import 'package:todo/controllers/services/index.dart';
import 'package:todo/models/models.dart';

enum TaskStatus {
  DONE,
  UNDONE,
}

class TaskService {
  DatabaseService get instance => DatabaseService.instance;

  Future<bool> createTask({
    required String projectId,
    required Task task,
  }) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .insert(
          'tb_task',
          task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<List<Task>> readAllTasks(String projectId) async {
    final db = await instance.db;
    final res = await db.query(
      'tb_task',
      where: 'projectId = ?',
      whereArgs: [projectId],
    );

    if (res.isNotEmpty) {
      final List<Task> tasks = res.map<Task>((task) {
        return Task.fromJson(task);
      }).toList();

      return tasks;
    } else {
      return [];
    }
  }

  Future<bool> updateTask(String taskId, String task) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .update(
          'tb_task',
          {'task': task},
          where: 'id = ?',
          whereArgs: [taskId],
        )
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<bool> updateTaskStatus(
    TaskStatus status, {
    required bool isAll,
    String? taskId,
    String? projectId,
  }) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .update(
          'tb_task',
          {'isDone': status == TaskStatus.DONE ? 1 : 0},
          where: isAll ? 'projectId = ?' : 'id = ?',
          whereArgs: [isAll ? projectId : taskId],
        )
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<bool> deleteOneTask(String taskId) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .delete(
          'tb_task',
          where: "id = ?",
          whereArgs: [taskId],
        )
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<bool> deleteTasksByProjectId(String projectId) async {
    var isSuccess;

    final db = await instance.db;
    await db
        .delete(
          'tb_task',
          where: 'projectId = ?',
          whereArgs: [projectId],
        )
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }

  Future<bool> deleteAllTasks() async {
    var isSuccess;

    final db = await instance.db;
    await db
        .delete('tb_task')
        .then((value) => isSuccess = true)
        .catchError((err) => isSuccess = false);

    return isSuccess;
  }
}
