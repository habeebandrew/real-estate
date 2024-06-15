import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {required this.color,
      required this.tittle,
      required this.onPreessed,
      required this.minWidth,
      required this.height});
  final Color color;
  final String tittle;
  final VoidCallback onPreessed;
  final double minWidth;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Material(
          elevation: 2, //ارتفاع
          color: color,
          borderRadius: BorderRadius.circular(10),
          child: MaterialButton(
            onPressed: onPreessed,
            minWidth: minWidth,
            height: height,
            child: Text(
              tittle,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
