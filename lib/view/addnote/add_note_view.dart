import 'package:flutter/material.dart';
import 'package:noteapp/core/constants/color_constants.dart';
import 'package:noteapp/view/addnote/add_note_view_model.dart';
import 'package:provider/provider.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key});

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.read<AddNoteViewModel>().addNote();

              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorConstants.defaultText,
            )),
        title: const Text(
          "Add Note",
          style: TextStyle(color: ColorConstants.defaultText),
        ),
        backgroundColor: ColorConstants.scaffoldBackGround,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Consumer<AddNoteViewModel>(
                builder: (context, ref, child) => SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(color: ColorConstants.defaultText),
                    onChanged: (value) {
                      ref.textController.text = value;
                      print(ref.textController.text);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
