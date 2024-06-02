import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:noteapp/screens/add_note_page.dart';
import 'package:noteapp/screens/archived_notes_page.dart';
import 'package:noteapp/screens/edit_note_page.dart';
import 'package:noteapp/utilities/appearence/color_options.dart';
import 'package:noteapp/utilities/datastore/shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _notes = [];

  late bool? confirm;

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context, int index) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Delete Note?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteNote(index);
            },
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No"),
          ),
        ],
      ),
    );
  }

  void _loadNotes() async {
    await SharedPrefService.init();
    setState(() {
      _notes = SharedPrefService.getList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _deleteNote(int index) async {
    SharedPrefService.removeNote(index);
    setState(() {
      _notes = SharedPrefService.getList();
    });
  }

  void _editNote(int index, String note) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => EditNotePage(index: index, note: note),
          ),
        )
        .then((value) => _loadNotes());
  }

  void _addArchive(String note, int index) {
    SharedPrefService.removeNote(index);
    SharedPrefService.addArchivedNote(note);
    setState(() {
      _notes = SharedPrefService.getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: backgroundcolor,
        title: const Text(
          "NoteIt",
          style: TextStyle(color: appNameColor),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                String notePreview =
                    _notes[index].length > 20 ? _notes[index] : _notes[index];

                return GestureDetector(
                  onTap: () {
                    _editNote(index, _notes[index]);
                  },
                  child: Slidable(
                    key: Key(_notes[index]),
                    startActionPane: ActionPane(
                        extentRatio: 0.2,
                        motion: const StretchMotion(),
                        dragDismissible: true,
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              _addArchive(_notes[index], index);
                            },
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white70,
                            borderRadius: BorderRadius.circular(3),
                            icon: Icons.archive,
                            autoClose: true,
                          )
                        ]),
                    endActionPane: ActionPane(
                      extentRatio: 0.4,
                      dragDismissible: true,
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            _showDeleteConfirmationDialog(context, index);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          autoClose: true,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            _editNote(index, _notes[index]);
                            setState(() {});
                          },
                          backgroundColor: textButtonColor,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          autoClose: true,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        notePreview,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  shadowColor: Colors.transparent,
                  overlayColor: const Color.fromARGB(0, 98, 98, 98),
                  backgroundColor: const Color.fromARGB(255, 35, 35, 35),
                  surfaceTintColor: Colors.black,
                  iconColor: Colors.black,
                  foregroundColor: textButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => const ArchivedNotesPage(),
                        ),
                      )
                      .then((value) => _loadNotes());
                },
                child: const Text("Archived Notes"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: textButtonColor,
        isExtended: true,
        onPressed: () {
          Navigator.of(context)
              .push(
                  MaterialPageRoute(builder: (context) => const AddNotePage()))
              .then(
                (value) => _loadNotes(),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
