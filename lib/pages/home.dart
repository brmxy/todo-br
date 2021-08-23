import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/project_provider.dart';
import 'package:todo/widgets/bottom_sheets/new_project.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _homePageScaffoldKey = GlobalKey<ScaffoldState>();

    SystemChrome.setEnabledSystemUIOverlays([]);

    return SafeArea(
      child: Scaffold(
        key: _homePageScaffoldKey,
        appBar: buildAppBar(context),
        drawer: buildDrawer(context),
        body: buildBody(context),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme.copyWith(size: 16.0),
      actionsIconTheme: Theme.of(context).iconTheme,
      actions: [
        IconButton(
          padding: const EdgeInsets.all(0),
          icon: Icon(FeatherIcons.search),
          onPressed: () {},
        ),
      ],
      elevation: 0,
      bottom: PreferredSize(
        child: Container(
          height: 2.0,
          color: Theme.of(context).dividerColor,
        ),
        preferredSize: Size.fromHeight(2.0),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    return Container(
      width: mediaWidth / 1.2,
      child: Drawer(),
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
          padding: const EdgeInsets.all(30.0),
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
        buildFloatingButton(context),
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
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      staggeredTileBuilder: (index) {
        return StaggeredTile.fit(1);
      },
      itemCount: projectProvider.projects.length,
      itemBuilder: (context, index) {
        final project = projectProvider.projects[index];

        return Card(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(project.title),
                Text(
                  project.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(project.isMarked.toString()),
                Text(project.tasks.length.toString()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildFloatingButton(BuildContext context) {
    return Positioned(
      right: 20.0,
      bottom: 20.0,
      child: FloatingActionButton(
        tooltip: 'New Project',
        child: IconTheme(
          data: Theme.of(context).iconTheme.copyWith(
                size: 26.0,
                color: Theme.of(context).textTheme.bodyText2!.color,
              ),
          child: Icon(FeatherIcons.plus),
        ),
        backgroundColor: Theme.of(context).buttonColor,
        onPressed: () async {
          await NewProjectBottomSheet.show(context);
        },
      ),
    );
  }
}
