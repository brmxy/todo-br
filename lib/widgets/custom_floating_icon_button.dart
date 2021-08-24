import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFloatingIconButton extends StatelessWidget {
  CustomFloatingIconButton({
    Key? key,
    this.tooltip,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String? tooltip;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20.0,
      bottom: 20.0,
      child: FloatingActionButton(
        tooltip: tooltip,
        child: IconTheme(
          data: Theme.of(context).iconTheme.copyWith(
                size: 26.0,
                color: Theme.of(context).textTheme.bodyText2!.color,
              ),
          child: Icon(icon),
        ),
        backgroundColor: Theme.of(context).buttonColor,
        onPressed: onPressed,
      ),
    );
  }
}
