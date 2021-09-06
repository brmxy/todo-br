import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo/index.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key? key, required this.projectId});

  final String projectId;

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  void _initProject() async {
    final provider = context.read<ProjectProvider>();
    await provider.findProject(widget.projectId);
  }

  @override
  void initState() {
    super.initState();

    _initProject();
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    SystemChrome.setEnabledSystemUIOverlays([]);

    final project = Provider.of<ProjectProvider>(context, listen: true).project;
    final String doneTask =
        project!.tasks.where((task) => task.isDone).length.toString();
    final String tasks = project.tasks.length.toString();

    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          IconButton(
            tooltip: 'Mark Project',
            icon: Icon(
              context.watch<ProjectProvider>().project!.isMarked
                  ? CupertinoIcons.bookmark_fill
                  : CupertinoIcons.bookmark,
            ),
            onPressed: () {
              context
                  .read<ProjectProvider>()
                  .toggleMarkProject(widget.projectId);
            },
          ),
          buildPopupMenuButton(context),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        width: mediaWidth,
        height: mediaHeight,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  FeatherIcons.grid,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Text(
                    project.title,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Text(
                  "$doneTask/$tasks",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.list_alt,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                SizedBox(width: 18.0),
                Expanded(
                  child: Text(
                    project.description.isNotEmpty
                        ? project.description
                        : "This project doesn't have description.",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 14.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            project.tasks.length == 0
                ? Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          FeatherIcons.plus,
                          size: 14.0,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                        hintText: 'Add Task',
                        hintStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildPopupMenuButton(BuildContext context) {
    final project =
        Provider.of<ProjectProvider>(context, listen: false).project;

    return PopupMenuButton(
      tooltip: 'Project Options',
      icon: Icon(FeatherIcons.moreVertical),
      onSelected: (value) async {
        final projectProvider = context.read<ProjectProvider>();

        if (value == 1) {
          await ProjectBottomSheet.show(
            context,
            ProjectBtnOption.UPDATE,
            projectId: project!.id,
          );
        } else if (value == 2) {
          projectProvider.deleteProject(project!.id);
          Navigator.pop(context);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 20.0,
            right: 20.0,
          ),
          height: 20.0,
          enabled: false,
          child: Text(
            'Project',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).dividerColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        PopupMenuItem(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          height: 30.0,
          child: Row(
            children: [
              Icon(
                FeatherIcons.edit2,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              SizedBox(width: 10.0),
              Text(
                'Edit Project',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          value: 1,
        ),
        PopupMenuItem(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          height: 30.0,
          child: Row(
            children: [
              Icon(
                FeatherIcons.trash2,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              SizedBox(width: 10.0),
              Text(
                'Delete Project',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          value: 2,
        ),
        PopupMenuItem(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 20.0,
            right: 20.0,
          ),
          height: 20.0,
          enabled: false,
          child: Text(
            'Task',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).dividerColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        PopupMenuItem(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          height: 30.0,
          child: Row(
            children: [
              Icon(
                FeatherIcons.circle,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              SizedBox(width: 10.0),
              Text(
                'Incomplete all',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          value: 3,
        ),
        PopupMenuItem(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          height: 30.0,
          child: Row(
            children: [
              Icon(
                FeatherIcons.checkCircle,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              SizedBox(width: 10.0),
              Text(
                'Complete all',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          value: 4,
        ),
        PopupMenuItem(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          height: 30.0,
          child: Row(
            children: [
              Icon(
                FeatherIcons.xCircle,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              SizedBox(width: 10.0),
              Text(
                'Delete all',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          value: 5,
        ),
      ],
    );
  }
}
