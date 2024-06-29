import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Drawer%20Screen/Drawer%20Widgets/drawer_widgets.dart';
import 'package:pro_2/Util/dimensions.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/constants.dart';


class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});


  @override
  Widget build(BuildContext context) {
    String? image=CacheHelper.getString(key: 'image');

    return Drawer(
      width: Dimensions.screenWidth(context) / 1.5,
      elevation: 0.0,
      child: Material(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [TextButton(onPressed: (){
              print(image);
              image=CacheHelper.getString(key: 'image');
              print("************************************************************");
              print("************************************************************");
              print("************************************************************");
              print("************************************************************");
              print("************************************************************");

              print(image);

            }, child: Text("dsd")),
            image != null?
            CircleAvatar(
              backgroundImage:
              NetworkImage(image!),
              radius: 40.0,
              backgroundColor: Colors.white,
            ):
              CircleAvatar(
                backgroundImage:
                AssetImage("assets/images/General/App_Icon.png"),
                radius: 40.0,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 10.0,
              ),
              CacheHelper.getString(key: 'name') != null
                  ? Text(
                      CacheHelper.getString(key: 'name') ?? 'No value stored',
                      style: const TextStyle(fontSize: 24),
                    )
                  : const SizedBox(),
              Divider(
                color: Constants.mainColor,
                indent: Dimensions.widthPercentage(context, 3),
                endIndent: Dimensions.widthPercentage(context, 2),
              ),

              CacheHelper.getInt(key: 'role_id') == null
                  ? build_for_guest(context)
                  : CacheHelper.getInt(key: 'role_id') == 1
                      ? build_for_user(context)
                      : (CacheHelper.getInt(key: 'role_id') == 2
                          ? build_for_Broker(context)
                          : const Text("Error confirming identity")),
            ],
          ),
        ),
      ),
    );
  }

}

