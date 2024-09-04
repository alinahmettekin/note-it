import 'package:flutter/material.dart';
import 'package:noteapp/core/helper/shared_preferences_helper.dart';

class DialogHelper {
  static DialogHelper? _instance;

  static DialogHelper get instance {
    return _instance ??= DialogHelper._internal();
  }

  DialogHelper._internal();

  Future<bool?> confirmationDeleteDialog(BuildContext context, int index) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Delete Note?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              SharedPreferencesHelper.instance.removeNote(index);
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
}
