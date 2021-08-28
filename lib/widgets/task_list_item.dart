import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo/models/task.dart';

class TaskListItem extends StatelessWidget {
  TaskListItem({
    Key? key,
    this.task,
    this.text,
  }) : super(key: key);

  final Task? task;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            text!.isNotEmpty
                ? FeatherIcons.circle
                : task!.isSuccess
                    ? FeatherIcons.checkCircle
                    : FeatherIcons.circle,
            size: 10,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text!.isNotEmpty ? text! : task!.name,
              overflow:
                  text!.isNotEmpty ? TextOverflow.clip : TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Theme.of(context).dividerColor),
            ),
          ),
        ],
      ),
    );
  }
}
