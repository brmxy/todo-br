import 'package:todo/index.dart';

class CustomAlertDialog extends StatefulWidget {
  CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  final String title;
  final String content;
  final List<Widget> actions;

  static Future<void> show(
    BuildContext context,
    String title,
    String content,
    List<Widget> actions,
  ) async {
    showDialog(
      barrierDismissible: false,
      barrierColor:
          context.read<ThemeProvider>().currentTheme == ActiveTheme.DARK_THEME
              ? Colors.black87
              : Colors.black54,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: title,
          content: content,
          actions: actions,
        );
      },
    );
  }

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(
        widget.content,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          height: 1.6,
        ),
      ),
      actions: widget.actions,
    );
  }
}
