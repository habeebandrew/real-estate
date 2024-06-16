import 'package:flutter/material.dart';
import 'package:pro_2/Util/constants.dart';

void mySnackBar({
  required String title,
  required BuildContext context,
}) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
    content: Text(
      title,
    ),
    backgroundColor: Constants.mainColor,
    duration: const Duration(seconds: 2),
  ))
      .closed
      .then((value) => ScaffoldMessenger.of(context).clearSnackBars());