import 'package:todo/controllers/services/index.dart';
import 'package:todo/models/models.dart';

class TaskService {
  DatabaseService get instance => DatabaseService.instance;

  Future<List<SQLTask>> readAllTasks(int projectId) async {
    final db = await instance.db;
    final res = await db.query('tb_task', where: 'projectId = $projectId');

    if (res.isNotEmpty) {
      final List<SQLTask> tasks = res.map<SQLTask>((task) {
        return SQLTask.fromJson(task);
      }).toList();

      return tasks;
    } else {
      return [];
    }
  }
}
