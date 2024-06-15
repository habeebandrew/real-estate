import 'package:flutter/material.dart';

Widget buildpage({
  // required Color color,
  required String urlImage,
  required String title,
  required String subtitle,
}) =>
    SafeArea(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                urlImage,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
              Text(
                title,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  subtitle,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );