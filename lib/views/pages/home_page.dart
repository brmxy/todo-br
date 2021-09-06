import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/index.dart';

class HomePage extends StatelessWidget {
  Future<bool> _loadProjects(BuildContext context) async {
    final projectProvider = Provider.of<ProjectProvider>(
      context,
      listen: false,
    );

    return await projectProvider.getProjects().then((value) => true);
  }

  @override
  Widget build(BuildContext context) {
    final _homePageScaffoldKey = GlobalKey<ScaffoldState>();

    return FutureBuilder(
      future: _loadProjects(context),
      builder: (context, snapshot) {
        SystemChrome.setEnabledSystemUIOverlays([]);

        if (snapshot.hasData) {
          return Scaffold(
            key: _homePageScaffoldKey,
            appBar: CustomAppBar(
              actions: [
                IconButton(
                  tooltip: 'Search Project',
                  icon: Icon(FeatherIcons.search),
                  onPressed: () {},
                ),
              ],
            ),
            drawer: CustomAppDrawer(),
            body: buildBody(context),
          );
        } else {
          return Container(
            color: context.watch<ThemeProvider>().currentTheme ==
                    ActiveTheme.DARK_THEME
                ? Color(0xFF171717)
                : Color(0xFFF5F5F5),
            child: CustomCircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildBody(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(
      context,
      listen: false,
    );

    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          alignment: projectProvider.projects.length == 0
              ? Alignment.center
              : Alignment.topCenter,
          width: mediaWidth,
          height: mediaHeight,
          child: projectProvider.projects.length == 0
              ? Text(
                  'There is no project to display.\nIf you want to make a new project,\nclick the + button below.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).dividerColor),
                  textAlign: TextAlign.center,
                )
              : buildProjectMasonry(context),
        ),
        FloatingActionIconButton(
          tooltip: 'Add New Project',
          icon: FeatherIcons.plus,
          onPressed: () async {
            await ProjectBottomSheet.show(context, ProjectBtnOption.ADD);
          },
        ),
      ],
    );
  }

  Widget buildProjectMasonry(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(
      context,
      listen: true,
    );

    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      staggeredTileBuilder: (index) {
        return StaggeredTile.fit(1);
      },
      itemCount: projectProvider.projects.length,
      itemBuilder: (context, index) {
        final project = projectProvider.projects[index];
        final tasks = project.tasks;
        final color = kColors[index % kColors.length];

        return buildProjectCard(project, context, tasks, color);
      },
    );
  }

  Widget buildProjectCard(
    Project project,
    BuildContext context,
    List<Task> tasks,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectPage(projectId: project.id),
          ),
        );
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      project.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              tasks.isNotEmpty
                  ? buildTaskListItem(context, project)
                  : TaskListItem(text: 'There is no task in this project'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTaskListItem(BuildContext context, Project project) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: project.tasks.length,
      itemBuilder: (context, index) {
        final task = project.tasks[index];

        return TaskListItem(task: task);
      },
    );
  }
}
