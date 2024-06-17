import 'package:flutter/material.dart';
import 'package:pro_2/Util/constants.dart';

class MyFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int?maxLength;
  final bool?obscureText;
  final TextInputType?type;
  final String? Function(String?)? validator;

  const MyFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.maxLength,
    this.obscureText,
    this.type,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType:type ,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
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
        validator: validator,
    );
  }
}
