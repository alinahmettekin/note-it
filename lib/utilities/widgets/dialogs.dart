import 'package:flutter/material.dart';

class DialogsAppearance {
  Future<bool?> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Delete Note?"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes")),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("No"),
          ),
        ],
      ),
    );
  }
}
