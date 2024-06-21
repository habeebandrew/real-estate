import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Favourite%20Screen/Favourite%20Widgets/favourite_widgets.dart';


class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:ListView.builder(
          padding: const EdgeInsets.all(0.0),
          itemBuilder:(context,value)=>favourite_item(context),
          itemCount: 3,
      )

    );
  }
}
