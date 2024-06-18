import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Drawer%20Screen/Drawer%20Widgets/drawer_widgets.dart';
import 'package:pro_2/Util/dimensions.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      width: Dimensions.screenWidth(context)/2,
      elevation: 0.0,
      child:   Material(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 40.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text("name"),
              Divider(
               indent: Dimensions.widthPercentage(context, 3),
               endIndent: Dimensions.widthPercentage(context, 2),
              ),
              myDrawerButton(
                  label: 'adsdsada',
                  icon: Icons.add,
                  onPress: (){}
              ),
              myDrawerButton(
                  label: 'Logout',
                  icon: Icons.power_settings_new,
                  onPress: (){}
              ),
            ],
          ),
        ),
      ),
    );
  }
}
