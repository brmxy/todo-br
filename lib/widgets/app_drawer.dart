import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    return Container(
      width: mediaWidth / 1.2,
      child: Drawer(),
    );
  }
}
