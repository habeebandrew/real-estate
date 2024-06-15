import 'package:flutter/material.dart';
import 'package:pro_2/Onboarding_screens/onboarding1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME PAGE'),
        actions: [
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final showHome = prefs.getBool("showHome") ?? false;
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Onboarding()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
