import 'package:todo/controllers/services/index.dart';
import 'package:todo/models/models.dart';

class TaskService {
  DatabaseService get instance => DatabaseService.instance;

  Future<List<Task>> readAllTasks(String projectId) async {
    final db = await instance.db;
    final res = await db.query('tb_task',
        where: 'projectId = $projectId', orderBy: 'createdAt ASC');

    if (res.isNotEmpty) {
      final List<Task> tasks = res.map<Task>((task) {
        return Task.fromJson(task);
      }).toList();

      return tasks;
    } else {
      return [];
    }
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
