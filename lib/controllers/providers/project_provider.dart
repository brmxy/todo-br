import 'package:todo/index.dart';

class ProjectProvider extends ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<SharedPreferences> get prefs async => await _prefs;

  List<Project> _projects = <Project>[];
  List<Project> get projects => _projects;

  void loadPrefProjects() async {
    await prefs.then((value) {
      if (value.containsKey('PROJECTS')) {
        _projects = value
            .getStringList('PROJECTS')!
            .map((project) => Project.fromRawJson(project))
            .toList();
      } else {
        _projects = <Project>[];
      }
    });

    notifyListeners();
  }

  void addNewProject(Project project) async {
    _projects.insert(0, project);

    await prefs.then((value) {
      value.setStringList(
        'PROJECTS',
        _projects.map((project) => project.toRawJson()).toList(),
      );
    });

    notifyListeners();
  }

  Project findProject(int id) {
    Project project = _projects.firstWhere((project) => project.id == id);

    return project;
  }

  void resetApp() async {
    await prefs.then((value) {
      value.clear();
    });

    loadPrefProjects();
    print(_projects.length);

    notifyListeners();
  }
}
