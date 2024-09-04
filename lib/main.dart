import 'package:flutter/material.dart';
import 'package:noteapp/core/theme/app_theme.dart';
import 'package:noteapp/view/addnote/add_note_view_model.dart';
import 'package:noteapp/view/home/home_view.dart';
import 'package:noteapp/view/home/home_view_model.dart';
import 'package:noteapp/view/addnote/add_note_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const NoteIt());
}

class NoteIt extends StatefulWidget {
  const NoteIt({super.key});

  @override
  State<NoteIt> createState() => _NoteItState();
}

class _NoteItState extends State<NoteIt> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddNoteViewModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const HomeView(),
      ),
    );
  }
}
