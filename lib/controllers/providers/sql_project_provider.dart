import 'package:todo/index.dart';

class SQLProjectProvider extends ChangeNotifier {
  List<SQLProject> _projects = [];
  List<SQLProject> get projects => _projects;

  SQLProject? project;

  ProjectService service = new ProjectService();
  TaskService taskService = new TaskService();

  void getProjects() async {
    _projects = await service.readAllProjects();
    _projects.map((project) async {
      project.tasks = await taskService.readAllTasks(project.id!);
    });

    notifyListeners();
  }

  Future<void> findProject(int projectId) async {
    final _project = await service.readOneProject(projectId);

    if (project != null) project = _project;
    notifyListeners();
  }

  void addProject(SQLProject project) async {
    final isSuccess = await service.createProject(project);

    if (isSuccess) {
      getProjects();
    }

    notifyListeners();
  }

  void updateProject(SQLProject project) async {
    final isSuccess = await service.updateProject(project);

    if (isSuccess) {
      await findProject(project.id!);
      getProjects();
    }
  }

  void deleteProject(int projectId) async {
    final isSuccess = await service.deleteProject(projectId);

    if (isSuccess) {
      getProjects();
    }
  }
}
