import 'package:flutter/material.dart';
import 'package:pro_2/Util/constants.dart';

class MyButton extends StatelessWidget {

  final Color?color;
  final String tittle;
  final VoidCallback onPreessed;
  final double minWidth;
  final double height;

  const MyButton({
      super.key,
      this.color,
      required this.tittle,
      required this.onPreessed,
      required this.minWidth,
      required this.height
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Material(
          elevation: 2, //ارتفاع
          color: Constants.mainColor,
          borderRadius: BorderRadius.circular(10),
          child: MaterialButton(
            onPressed: onPreessed,
            minWidth: minWidth,
            height: height,
            child: Text(
              tittle,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
