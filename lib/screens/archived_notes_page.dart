import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:noteapp/screens/edit_note_page.dart';
import 'package:noteapp/utilities/appearence/color_options.dart';
import 'package:noteapp/utilities/datastore/shared.dart';

class ArchivedNotesPage extends StatefulWidget {
  const ArchivedNotesPage({super.key});

  @override
  State<ArchivedNotesPage> createState() => _ArchivedNotesPageState();
}

class _ArchivedNotesPageState extends State<ArchivedNotesPage> {
  List<String> _archivedNotes = [];

  @override
  void initState() {
    super.initState();
    _loadArchivedNotes();
  }

  void _loadArchivedNotes() async {
    await SharedPrefService.init();
    setState(() {
      _archivedNotes = SharedPrefService.getArchivedNotes();
    });
  }

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

  void _deleteNote(int index) async {
    SharedPrefService.removeArchivedNote(index);
    setState(() {
      _archivedNotes = SharedPrefService.getList();
    });
  }

  void _editNote(int index, String note) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => EditNotePage(index: index, note: note),
          ),
        )
        .then((value) => _loadArchivedNotes());
  }

  void _removeFromArchive(String note, int index) {
    SharedPrefService.addNote(note);
    SharedPrefService.removeArchivedNote(index);
    setState(() {
      _archivedNotes = SharedPrefService.getArchivedNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          style:
              ButtonStyle(iconColor: WidgetStateProperty.all(Colors.white70)),
        ),
        title: const Text(
          "Archived Notes",
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: backgroundcolor,
      ),
      body: ListView.builder(
        itemCount: _archivedNotes.length,
        itemBuilder: (context, index) {
          String notePreview = _archivedNotes[index].length > 20
              ? _archivedNotes[index].substring(0, 30)
              : _archivedNotes[index];

          return GestureDetector(
            child: Slidable(
                key: Key(_archivedNotes[index]),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        _showDeleteConfirmationDialog(context, index);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                      autoClose: true,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        _editNote(index, _archivedNotes[index]);
                        setState(() {});
                      },
                      backgroundColor: textButtonColor,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                      autoClose: true,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        _removeFromArchive(_archivedNotes[index], index);
                      },
                      backgroundColor: textButtonColor,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Remove from Archive',
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
                )),
          );
        },
      ),
    );
  }
}
