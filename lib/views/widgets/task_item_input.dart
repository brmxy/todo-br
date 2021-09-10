import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo/index.dart';

class TaskItemInput extends StatefulWidget {
  TaskItemInput({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  _TaskItemInputState createState() => _TaskItemInputState();
}

class _TaskItemInputState extends State<TaskItemInput> {
  final TextEditingController _inputCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final project = context.watch<ProjectProvider>().project;
    _inputCtrl.text =
        project!.tasks.firstWhere((task) => widget.task == task).task;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: TextFormField(
        controller: _inputCtrl,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16.0,
              color: widget.task.isDone
                  ? Theme.of(context).dividerColor
                  : Theme.of(context).textTheme.bodyText1!.color,
            ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          prefixIcon: InkWell(
            child: IconButton(
              icon: Icon(
                widget.task.isDone
                    ? FeatherIcons.checkCircle
                    : FeatherIcons.circle,
                size: 12.0,
                color: widget.task.isDone
                    ? Theme.of(context).dividerColor
                    : Theme.of(context).textTheme.bodyText1!.color,
              ),
              onPressed: () {
                context.read<TaskProvider>().updateTaskStatus(
                      widget.task.isDone ? TaskStatus.UNDONE : TaskStatus.DONE,
                      isAll: false,
                      taskId: widget.task.id,
                    );
                context
                    .read<ProjectProvider>()
                    .updateTasks(widget.task.projectId);
              },
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              FeatherIcons.xCircle,
              size: 14.0,
              color: widget.task.isDone
                  ? Theme.of(context).dividerColor
                  : Theme.of(context).textTheme.bodyText1!.color,
            ),
            onPressed: () {
              context.read<TaskProvider>().deleteTask(widget.task.id);
              context
                  .read<ProjectProvider>()
                  .updateTasks(widget.task.projectId);
            },
          ),
        ),
        onFieldSubmitted: (value) {
          context.read<TaskProvider>().updateTask(
                widget.task.projectId,
                widget.task.id,
                value,
              );
          context.read<ProjectProvider>().updateTasks(widget.task.projectId);
        },
      ),
    );
  }
}
