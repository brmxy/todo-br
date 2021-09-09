import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo/index.dart';

class CustomAppDrawer extends StatefulWidget {
  @override
  _CustomAppDrawerState createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectProvider>().getMarkedProjects();
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    SystemChrome.setEnabledSystemUIOverlays([]);

    return SafeArea(
      child: Container(
        width: mediaWidth / 1.2,
        child: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: mediaWidth,
                margin: const EdgeInsets.only(bottom: 20.0),
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menu',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Theme.of(context).dividerColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    InkWell(
                      child: Icon(
                        FeatherIcons.x,
                        size: 24.0,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
              ),
              DrawerItem(
                icon: FeatherIcons.grid,
                menuText: 'All Projects',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              DrawerItem(
                icon: CupertinoIcons.bookmark_fill,
                menuText: 'Marked',
                onTap: () {},
              ),
              buildMarkedProjectDrawerItem(context),
              DrawerItem(
                icon: FeatherIcons.settings,
                menuText: 'Settings',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/setting');
                },
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMarkedProjectDrawerItem(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    final projectProvider = Provider.of<ProjectProvider>(context, listen: true);
    final projects = projectProvider.markedProjects;

    return Expanded(
      child: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projectProvider.markedProjects[index];
          final tasks = project.tasks;

          return InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectPage(
                    projectId: project.id,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 57.0,
                bottom: 10.0,
                right: 20.0,
              ),
              width: mediaWidth,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      color: kColors[index % kColors.length],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      project.title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  Text(
                    tasks.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).dividerColor),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
