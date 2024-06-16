import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Onboarding_screens/onboarding1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {


  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
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
      body: Scaffold(
        body: Center(child: Text("welcome mehdi\nXD hala madried !!")),
      ),
    );
  }
}
