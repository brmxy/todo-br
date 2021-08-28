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
              Icon(icon),
              SizedBox(width: 10.0),
              Text(
                menuText,
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
