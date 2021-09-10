import 'package:todo/index.dart';

class TaskProvider extends ChangeNotifier {
  TaskService service = new TaskService();

  Future<List<Task>> getTasks(String projectId) async {
    final tasks = await service.readAllTasks(projectId);

    return tasks;
  }

  void addTask(String projectId, Task task) async {
    await service.createTask(
      projectId: projectId,
      task: task,
    );
  }

  void updateTask(String projectId, String taskId, String task) async {
    await service.updateTask(taskId, task);
  }

  void updateTaskStatus(
    TaskStatus status, {
    required bool isAll,
    String? projectId,
    String? taskId,
  }) async {
    await service.updateTaskStatus(
      status,
      isAll: isAll,
      projectId: projectId,
      taskId: taskId,
    );
  }

  void deleteTask(String taskId) async {
    await service.deleteOneTask(taskId);
  }

  void resetTaskByProjectId(String projectId) async {
    await service.deleteTasksByProjectId(projectId);
  }

  void resetTask() async {
    await service.deleteAllTasks();
  }
}
