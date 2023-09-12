import 'package:driver/global/utils/helpers/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: text,
    content: text,
    optionsBuilder: () {
      return {
        'OK': null,
      };
    },
  );
}
