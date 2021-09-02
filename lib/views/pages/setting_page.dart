import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo/index.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      sized: false,
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          width: mediaWidth,
          height: mediaHeight,
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Text(
                'Settings',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 22.0),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(FeatherIcons.user),
                  Text('Profile (Coming Soon)'),
                ],
              ),
              SizedBox(height: 20.0),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      context.watch<ThemeProvider>().currentTheme ==
                              ActiveTheme.DARK_THEME
                          ? FeatherIcons.moon
                          : FeatherIcons.sun,
                    ),
                    Text('Theme (Coming Soon)'),
                  ],
                ),
                onTap: () {
                  context.read<ThemeProvider>().toggleTheme();
                },
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(FeatherIcons.helpCircle),
                  Text('About App'),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(FeatherIcons.code),
                  Text('License'),
                ],
              ),
              SizedBox(height: 20.0),
              InkWell(
                  child: Row(
                    children: [
                      Icon(FeatherIcons.refreshCcw),
                      Text('Reset App'),
                    ],
                  ),
                  onTap: () {
                    context.read<ProjectProvider>().resetApp();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
