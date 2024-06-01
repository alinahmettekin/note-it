import 'package:flutter/material.dart';
import 'package:noteapp/utilities/appearence/color_options.dart';
import 'package:noteapp/utilities/datastore/shared.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPrefService.init();
  }

  final TextEditingController _textController = TextEditingController();
  bool _isLongPress = false;
  List<String> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundcolor,
        appBar: AppBar(
          backgroundColor: backgroundcolor,
          title: const Text(
            "Add Note",
            style: TextStyle(color: appNameColor),
          ),
          leading: IconButton(
            style:
                ButtonStyle(iconColor: WidgetStateProperty.all(appNameColor)),
            onPressed: () {
              SharedPrefService.addNote(_textController.text);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        WidgetStateProperty.all(Colors.transparent),
                    overlayColor: WidgetStateProperty.all(Colors.transparent)),
                onPressed: () {
                  SharedPrefService.addNote(_textController.text);
                  Navigator.pop(context);
                },
                child: GestureDetector(
                  onLongPress: () {
                    setState(() {
                      _isLongPress = true;
                    });
                  },
                  onLongPressEnd: (_) {
                    setState(() {
                      _isLongPress = false;
                    });
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: _isLongPress ? Colors.grey : textButtonColor),
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: TextField(
            style: const TextStyle(color: Colors.white70),
            autofocus: true,
            controller: _textController,
            maxLines: null,
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ));
  }
}
