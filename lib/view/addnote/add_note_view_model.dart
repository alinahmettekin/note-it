import 'package:flutter/material.dart';
import 'package:noteapp/core/helper/shared_preferences_helper.dart';
import 'package:provider/provider.dart';

class AddNoteViewModel extends ChangeNotifier {
  TextEditingController textController = TextEditingController();

  addNote() {
    SharedPreferencesHelper.instance.addNote(textController.text);
    textController.clear();
    notifyListeners();
  }
}
