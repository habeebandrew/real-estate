import 'package:flutter/material.dart';
import 'package:pro_2/Util/constants.dart';

void mySnackBar({
  required String title,
  required BuildContext context,
  Color color = Constants.mainColor,
}) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            title,
          ),
          backgroundColor: color,
          duration: const Duration(seconds: 2),
        ))
        .closed
        .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
