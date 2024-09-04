import 'package:flutter/material.dart';
import 'package:noteapp/core/constants/color_constants.dart';
import 'package:noteapp/core/helper/route_helper.dart';
import 'package:noteapp/view/addnote/add_note_view.dart';
import 'package:noteapp/view/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<HomeViewModel>(context, listen: true).getNotes();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          RouteHelper.push(context, const AddNoteView());
        },
        backgroundColor: ColorConstants.textButtonColor,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "NOTE IT",
          style: TextStyle(color: ColorConstants.defaultText),
        ),
      ),
      body: Consumer<HomeViewModel>(
        builder: (BuildContext context, value, Widget? child) {
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: value.notes.length,
            itemBuilder: (context, index) {
              final notes = value.notes;
              if (notes.isEmpty) {
                return const Center(
                  child: Text(
                    "BOŞ LİST",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    title: Text(
                      notes[index],
                      style: const TextStyle(color: ColorConstants.defaultText),
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
