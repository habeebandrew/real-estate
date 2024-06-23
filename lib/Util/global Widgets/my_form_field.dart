import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_2/Util/constants.dart';

class MyFormField extends StatelessWidget {
  final TextEditingController controller;
  final String?labelText;
  final String?hintText;
  final int?maxLength;
  final bool?obscureText;
  final bool?fill;
  final Color?fillColor;
  final TextInputType?type;
  final double radius;
  final String? Function(String?)? validator;
  final int?maxLines;

  const MyFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.maxLength,
    this.obscureText,
    this.fill,
    this.fillColor,
    this.type,
    this.radius=0,
    this.validator,
    this.maxLines,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType:type ,
        decoration: InputDecoration(
          hintText:hintText ,
          labelText: labelText,
          filled: fill,
          fillColor: fillColor,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
                color: Constants.mainColor
            ),
          ),
          focusedBorder:  const OutlineInputBorder(
            borderSide: BorderSide(
                color:  Constants.mainColor
            ),
          ),
        ),
        maxLength: maxLength,
        obscureText: obscureText??false,
        validator: validator,maxLines: maxLines,
    );
  }
}
