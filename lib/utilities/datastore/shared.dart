import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Functions for visible notes
  static Future<void> saveList(List<String> list) async {
    await _prefs?.setStringList('notes', list);
  }

  static List<String> getList() {
    return _prefs?.getStringList('notes') ?? [];
  }

  static Future<void> addNote(String note) async {
    List<String>? notes = getList();
    notes.add(note);
    await _prefs?.setStringList('notes', notes);
  }

  static Future<void> removeNote(int index) async {
    List<String>? updatedList = _prefs?.getStringList('notes');
    updatedList!.removeAt(index);

    await _prefs?.setStringList('notes', updatedList);
  }

  // Functions for archived notes

  static Future<void> saveArchivedNotes(List<String> list) async {
    await _prefs?.setStringList('archivednotes', list);
  }

  static List<String> getArchivedNotes() {
    return _prefs?.getStringList('archivednotes') ?? [];
  }

  static Future<void> addArchivedNote(String note) async {
    List<String>? notes = getArchivedNotes();
    notes.add(note);
    await _prefs?.setStringList('archivednotes', notes);
  }

  static Future<void> removeArchivedNote(int index) async {
    List<String>? updatedList = _prefs?.getStringList('archivednotes');
    updatedList!.removeAt(index);

    await _prefs?.setStringList('archivednotes', updatedList);
  }
}
