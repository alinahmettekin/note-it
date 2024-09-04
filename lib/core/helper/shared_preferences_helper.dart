import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper? _instance;
  SharedPreferences? _prefs;

  static SharedPreferencesHelper get instance {
    return _instance ??= SharedPreferencesHelper._internal();
  }

  SharedPreferencesHelper._internal() {
    init();
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveList(List<String> list) async {
    await _prefs?.setStringList('notes', list);
  }

  List<String> getList() {
    return _prefs?.getStringList('notes') ?? [];
  }

  Future<void> addNote(String note) async {
    List<String>? notes = getList();
    notes.add(note);
    await _prefs?.setStringList('notes', notes);
  }

  Future<void> removeNote(int index) async {
    List<String>? updatedList = _prefs?.getStringList('notes');
    updatedList!.removeAt(index);

    await _prefs?.setStringList('notes', updatedList);
  }

  // Functions for archived notes

  Future<void> saveArchivedNotes(List<String> list) async {
    await _prefs?.setStringList('archivednotes', list);
  }

  List<String> getArchivedNotes() {
    return _prefs?.getStringList('archivednotes') ?? [];
  }

  Future<void> addArchivedNote(String note) async {
    List<String>? notes = getArchivedNotes();
    notes.add(note);
    await _prefs?.setStringList('archivednotes', notes);
  }

  Future<void> removeArchivedNote(int index) async {
    List<String>? updatedList = _prefs?.getStringList('archivednotes');
    updatedList!.removeAt(index);

    await _prefs?.setStringList('archivednotes', updatedList);
  }
}
