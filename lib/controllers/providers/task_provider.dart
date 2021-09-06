import 'package:todo/index.dart';

class TaskProvider extends ChangeNotifier {
  TaskService service = new TaskService();

  void resetTask() async {
    final bool isSuccess = await service.deleteAllTasks();

    if (isSuccess) notifyListeners();
  }
}
