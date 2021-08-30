import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem({
    Key? key,
    required this.icon,
    required this.menuText,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String menuText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        splashColor: Color(0xFFF5F5F5),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16.0,
                color: Theme.of(context).textTheme.bodyText1!.color,
                textDirection: TextDirection.ltr,
              ),
              SizedBox(width: 20.0),
              Text(
                menuText,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
