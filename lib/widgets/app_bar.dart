import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key, this.actions})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final List<Widget>? actions;

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme.copyWith(size: 16.0),
      actionsIconTheme: Theme.of(context).iconTheme,
      actions: widget.actions,
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
}
