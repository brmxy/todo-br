import 'package:todo/index.dart';

class SettingItemWidget extends StatelessWidget {
  SettingItemWidget({
    Key? key,
    required this.onTap,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final void Function() onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.0,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            SizedBox(width: 10.0),
            Text(
              text,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
