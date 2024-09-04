import 'package:flutter/material.dart';
import 'package:noteapp/core/helper/shared_preferences_helper.dart';

class HomeViewModel extends ChangeNotifier {
  List<String>? _notes;

  List<String> get notes {
    return _notes = SharedPreferencesHelper.instance.getList();
  }

  deleteNote(int index) {
    SharedPreferencesHelper.instance.removeNote(index);
    notifyListeners();
  }

  getNotes() async {
    _notes = SharedPreferencesHelper.instance.getList();
    notifyListeners();
  }
}
