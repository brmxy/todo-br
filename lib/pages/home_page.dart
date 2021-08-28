import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/constants/index.dart';
import 'package:todo/index.dart';
import 'package:todo/models/index.dart';
import 'package:todo/pages/index.dart';
import 'package:todo/providers/index.dart';
import 'package:todo/widgets/index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final projectProvider = Provider.of<ProjectProvider>(
      context,
      listen: false,
    );
    projectProvider.loadPrefProjects();
  }

  @override
  Widget build(BuildContext context) {
    final _homePageScaffoldKey = GlobalKey<ScaffoldState>();
    SystemChrome.setEnabledSystemUIOverlays([]);

    return SafeArea(
      child: Scaffold(
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
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(
      context,
      listen: true,
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

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectPage(project: project),
              ),
            );
          },
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 10,
                          height: 10,
                          color: kColors[project.id % kColors.length],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          project.title,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  tasks.isNotEmpty
                      ? buildTaskListItem(project)
                      : TaskListItem(text: 'There is no task in this project'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTaskListItem(Project project) {
    return ListView.builder(
      itemCount: project.tasks.length,
      itemBuilder: (context, index) {
        final task = project.tasks[index];

        return TaskListItem(task: task);
      },
    );
  }
}
