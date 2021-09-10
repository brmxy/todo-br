import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo/index.dart';

class TaskListItem extends StatelessWidget {
  TaskListItem({
    Key? key,
    this.task,
    this.text = '',
  }) : super(key: key);

  final Task? task;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(
            text!.isNotEmpty
                ? FeatherIcons.circle
                : task!.isDone
                    ? FeatherIcons.checkCircle
                    : FeatherIcons.circle,
            size: 10.0,
            color: task != null
                ? task!.isDone
                    ? Theme.of(context).textTheme.bodyText1!.color
                    : Theme.of(context).dividerColor
                : Theme.of(context).dividerColor,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text!.isNotEmpty ? text! : task!.task,
              overflow:
                  text!.isNotEmpty ? TextOverflow.clip : TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 15.0,
                    color: Theme.of(context).dividerColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
