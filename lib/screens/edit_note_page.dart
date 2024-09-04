import 'package:flutter/material.dart';
import 'package:noteapp/utilities/appearence/color_options.dart';
import 'package:noteapp/utilities/datastore/shared.dart';

class EditNotePage extends StatefulWidget {
  final int index;
  final String note;
  const EditNotePage({super.key, required this.index, required this.note});
  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  TextEditingController _textController = TextEditingController();
  List<String> _currentList = [];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.note);
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  void _updateNote(int index, String note) {
    _currentList = SharedPrefService.getList();
    _currentList[index] = note;
    SharedPrefService.saveList(_currentList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundcolor,
        appBar: AppBar(
          title: const Text(
            "Edit Note",
            style: TextStyle(color: appNameColor),
          ),
          backgroundColor: backgroundcolor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _updateNote(
                widget.index,
                _textController.text,
              );
              Navigator.pop(context);
            },
            style:
                ButtonStyle(iconColor: WidgetStateProperty.all(appNameColor)),
          ),
        ),
        body: SingleChildScrollView(
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 1,
            controller: _textController,
            style: const TextStyle(color: Colors.white70),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 500),
            ),
          ),
        ));
  }
}
