import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo/index.dart';
import 'package:uuid/uuid.dart';

enum ProjectBtnOption {
  ADD,
  UPDATE,
}

class ProjectBottomSheet extends StatefulWidget {
  ProjectBottomSheet({
    Key? key,
    this.formKey,
    required this.option,
    this.projectId,
  }) : super(key: key);

  final Key? formKey;
  final ProjectBtnOption option;
  final String? projectId;

  static Future<void> show(
    BuildContext context,
    ProjectBtnOption option, {
    String? projectId = '',
  }) async {
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      useRootNavigator: true,
      builder: (context) => ProjectBottomSheet(
        formKey: _formKey,
        option: option,
        projectId: projectId!,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  _ProjectBottomSheetState createState() => _ProjectBottomSheetState();
}

class _ProjectBottomSheetState extends State<ProjectBottomSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.option == ProjectBtnOption.UPDATE) {
      final projectProvider = Provider.of<ProjectProvider>(
        context,
        listen: false,
      );
      projectProvider.findProject(widget.projectId!);
      _titleController.text = projectProvider.project!.title;
      _descController.text = projectProvider.project!.description;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;

    SystemChrome.setEnabledSystemUIOverlays([]);

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 200),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 40.0,
            ),
            height: mediaHeight / 2,
            child: Column(
              children: [
                Container(
                  width: 20.0,
                  height: 2.0,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Form(
                    key: widget.formKey,
                    child: ListView(
                      children: [
                        TextFormField(
                          autofocus: true,
                          controller: _titleController,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            hintText: 'Project Name',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _descController,
                          keyboardType: TextInputType.multiline,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            hintMaxLines: 100,
                            hintText: 'Description',
                          ),
                          maxLength: 100,
                          minLines: 5,
                          maxLines: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          FloatingActionIconButton(
            icon: FeatherIcons.check,
            tooltip: 'Submit',
            onPressed: () {
              final projectProvider = context.read<ProjectProvider>();
              final ttlValue = _titleController.text;
              final descValue = _descController.text;

              if (ttlValue.isNotEmpty || descValue.isNotEmpty) {
                if (widget.option == ProjectBtnOption.ADD) {
                  var addProject = Project(
                    id: Uuid().v4(),
                    title: ttlValue,
                    description: descValue,
                    createdAt: DateTime.now(),
                  );

                  projectProvider.addProject(addProject);
                } else if (widget.option == ProjectBtnOption.UPDATE) {
                  var updateProject = Project(
                    id: widget.projectId!,
                    title: ttlValue,
                    description: descValue,
                    isMarked: projectProvider.project!.isMarked,
                    createdAt: projectProvider.project!.createdAt,
                  );

                  projectProvider.updateProject(updateProject);
                }

                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}
