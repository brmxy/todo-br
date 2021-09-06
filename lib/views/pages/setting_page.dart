import 'package:todo/index.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    final _settingItems = getSettingItems(context);

    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        width: mediaWidth,
        height: mediaHeight,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Settings',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 24.0),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _settingItems.length,
                itemBuilder: (context, index) {
                  final item = _settingItems[index];
                  return SettingItemWidget(
                    onTap: item.onTap,
                    text: item.text,
                    icon: item.icon,
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '© 2021 by Yara Bramasta. All Rights Reserved.',
                  style: TextStyle(color: Theme.of(context).dividerColor),
                ),
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
