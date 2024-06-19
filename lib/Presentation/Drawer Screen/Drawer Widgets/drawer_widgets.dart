import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Util/constants.dart';

Widget myDrawerButton({
  required String label,
  required IconData icon,
  required void Function()? onPress,
}) => InkWell(
  onTap: onPress,
  child: Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
    child: Row(
      children: [
        Icon(
          icon,
          size: 22.sp,
          color: Constants.mainColor,
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color:Constants.mainColor,
        ),
      ],
    ),
  ),
);





