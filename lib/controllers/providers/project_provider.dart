import 'package:todo/index.dart';

class ProjectProvider extends ChangeNotifier {
  List<Project> _projects = [];
  List<Project> get projects => _projects;

  List<Project> _markedProjects = [];
  List<Project> get markedProjects => _markedProjects;

  Project? project;

  ProjectService service = new ProjectService();
  TaskService taskService = new TaskService();

  Future<void> getProjects() async {
    _projects = await service.readAllProjects();
    _projects.map((project) async {
      project.tasks = await taskService.readAllTasks(project.id);
    });

    notifyListeners();
  }

  void getMarkedProjects() async {
    _markedProjects = await service.readMarkedProject();

    notifyListeners();
  }

  Future<void> findProject(String projectId) async {
    final _project = await service.readOneProject(projectId);
    project = _project;

    notifyListeners();
  }

  void addProject(Project project) async {
    final bool isSuccess = await service.createProject(project);

    if (isSuccess) getProjects();
  }

  void updateProject(Project project) async {
    final bool isSuccess = await service.updateProject(project);

    if (isSuccess) {
      await findProject(project.id);
      getProjects();
      getMarkedProjects();
    }
  }

  void toggleMarkProject(String projectId) async {
    if (!project!.isMarked) {
      bool isMarkSuccess = await service.markProject(projectId);

      if (isMarkSuccess) {
        await findProject(projectId);
        getProjects();
        getMarkedProjects();
      }
    } else {
      bool isUnmarkSuccess = await service.unmarkProject(projectId);
      if (isUnmarkSuccess) {
        await findProject(projectId);
        getProjects();
        getMarkedProjects();
      }
    }
  }

  void resetProject() async {
    final bool isSuccess = await service.deleteAllProjects();

    if (isSuccess) {
      getProjects();
      getMarkedProjects();
    }
  }

  void deleteProject(String projectId) async {
    final bool isSuccess = await service.deleteOneProject(projectId);

    if (isSuccess) {
      getProjects();
      getMarkedProjects();
    }
  }
}
