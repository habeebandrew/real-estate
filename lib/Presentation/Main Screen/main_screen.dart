import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Main%20Screen/MainWidgets/main_widgets.dart';
import 'package:pro_2/generated/l10n.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
//S.of(context).Change_language,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Color.fromARGB(255, 255, 255, 255),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(), //باخدها نفسها من مهدي بواجهة العقارات
            CategorySection(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    S.of(context).most_watched,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.visibility)
                ],
              ),
            ),
            mostviewer(),
            SizedBox(
              height: 50,
            )
            // AdBanner(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: S.of(context).Search_real,
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
