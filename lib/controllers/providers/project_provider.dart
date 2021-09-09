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
    projects.forEach((project) async {
      await initTasks(project);
    });

    notifyListeners();
  }

  Future<void> initTasks(Project project) async {
    final tasks = await taskService.readAllTasks(project.id);

    if (tasks.length > 0) {
      project.tasks = tasks;
    }

    notifyListeners();
  }

  Future<void> updateTasks(String projectId) async {
    project!.tasks = await taskService.readAllTasks(projectId);

    notifyListeners();
  }

  void getMarkedProjects() async {
    _markedProjects = await service.readMarkedProject();

    _markedProjects.forEach((project) async {
      await initTasks(project);
    });

    notifyListeners();
  }

  Future<void> findProject(String projectId) async {
    final _project = await service.readOneProject(projectId);
    project = _project;

    await updateTasks(projectId);
    getProjects();

    notifyListeners();
  }

  void addProject(Project project) async {
    final bool isSuccess = await service.createProject(project);

    if (isSuccess) {
      getProjects();
      await updateTasks(project.id);
    }
  }

  void updateProject(Project project) async {
    final bool isSuccess = await service.updateProject(project);

    if (isSuccess) {
      await findProject(project.id);
      await updateTasks(project.id);
      getProjects();
      getMarkedProjects();
    }
  }

  void toggleMarkProject(String projectId) async {
    if (!project!.isMarked) {
      bool isMarkSuccess = await service.markProject(projectId);

      if (isMarkSuccess) {
        await findProject(projectId);
        await updateTasks(projectId);
        getProjects();
        getMarkedProjects();
      }
    } else {
      bool isUnmarkSuccess = await service.unmarkProject(projectId);
      if (isUnmarkSuccess) {
        await findProject(projectId);
        await updateTasks(projectId);
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
      await updateTasks(projectId);
      getProjects();
      getMarkedProjects();
    }
  }
}
