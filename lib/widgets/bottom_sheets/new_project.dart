import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo/models/project.dart';
import 'package:todo/providers/project_provider.dart';

class NewProjectBottomSheet extends StatefulWidget {
  NewProjectBottomSheet({Key? key, this.formKey}) : super(key: key);

  final Key? formKey;

  static Future<void> show(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      useRootNavigator: true,
      builder: (context) => NewProjectBottomSheet(formKey: _formKey),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  _NewProjectBottomSheetState createState() => _NewProjectBottomSheetState();
}

class _NewProjectBottomSheetState extends State<NewProjectBottomSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 500),
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
                          decoration: InputDecoration(
                            hintText: 'Title',
                          ),
                        ),
                        TextFormField(
                          controller: _descController,
                          keyboardType: TextInputType.multiline,
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
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              tooltip: 'New Project',
              child: IconTheme(
                data: Theme.of(context).iconTheme.copyWith(
                      size: 26.0,
                      color: Theme.of(context).textTheme.bodyText2!.color,
                    ),
                child: Icon(FeatherIcons.check),
              ),
              backgroundColor: Theme.of(context).buttonColor,
              onPressed: () {
                final projectProvider = context.read<ProjectProvider>();
                final ttlValue = _titleController.text;
                final descValue = _descController.text;

                if (ttlValue.isNotEmpty || descValue.isNotEmpty) {
                  final project = Project(
                    title: ttlValue,
                    description: descValue,
                  );

                  print(project);
                  projectProvider.addNewProject(project);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
