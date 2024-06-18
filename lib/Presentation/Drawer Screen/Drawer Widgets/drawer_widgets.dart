
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget myDrawerButton({
  required String label,
  required IconData icon,
  required void Function()? onPress,
})
=> InkWell(
  onTap: onPress,
  child: Row(
    children:
    [
      Icon(icon),
      Text(label),
      SizedBox(
        height: 10.h,
      ),
    ],
  ),
);