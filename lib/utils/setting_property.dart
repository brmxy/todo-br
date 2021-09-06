import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo/index.dart';

class _SettingItem {
  _SettingItem({
    required this.icon,
    required this.onTap,
    required this.text,
  });

  final IconData icon;
  final void Function() onTap;
  final String text;
}

const String _license =
    'MIT License\n\nCopyright (c) 2021 Yara Bramasta\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE.';

void _showAlertDialog(BuildContext context) async {
  await CustomAlertDialog.show(
    context,
    "Reset Application",
    "This will reset all your projects and tasks that you have done before.",
    [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Cancel"),
      ),
      TextButton(
        onPressed: () {
          context.read<ProjectProvider>().resetProject();
          context.read<TaskProvider>().resetTask();
          context.read<ThemeProvider>().resetTheme();
          SystemNavigator.pop();
        },
        child: Text("Confirm"),
      ),
    ],
  );
}

List<_SettingItem> getSettingItems(BuildContext context) {
  final settingItems = <_SettingItem>[
    new _SettingItem(
      icon: FeatherIcons.user,
      onTap: () {},
      text: 'Profile (Coming Soon)',
    ),
    new _SettingItem(
      icon:
          context.watch<ThemeProvider>().currentTheme == ActiveTheme.DARK_THEME
              ? FeatherIcons.moon
              : FeatherIcons.sun,
      onTap: () {
        context.read<ThemeProvider>().toggleTheme();
      },
      text:
          '${context.watch<ThemeProvider>().currentTheme == ActiveTheme.DARK_THEME ? "Dark" : "Light"} Theme',
    ),
    new _SettingItem(
      icon: FeatherIcons.helpCircle,
      onTap: () {
        showAboutDialog(
          context: context,
          applicationName: "Todo Br",
          applicationVersion: "v1.0.0",
          applicationLegalese: "Copyright(c) 2021 Yara Bramasta",
          applicationIcon: Image.asset(
            "icons/ic_launcher.png",
            width: 40.0,
            height: 40.0,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10.0,
                bottom: 0,
                right: 10.0,
              ),
              child: Text(
                "Todo Br is an todo list application that targetting especially developers.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  height: 1.6,
                ),
              ),
            ),
          ],
        );
      },
      text: "About App",
    ),
    new _SettingItem(
      icon: Icons.copyright,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LicensePage(
              applicationIcon: Image.asset(
                "icons/ic_launcher.png",
                width: 40.0,
                height: 40.0,
              ),
              applicationName: "Todo Br",
              applicationVersion: "v1.0.0",
              applicationLegalese: _license,
            ),
          ),
        );
      },
      text: "Copyright",
    ),
    new _SettingItem(
      icon: Icons.rotate_left,
      onTap: () {
        _showAlertDialog(context);
      },
      text: "Reset App",
    ),
  ];

  return settingItems;
}
