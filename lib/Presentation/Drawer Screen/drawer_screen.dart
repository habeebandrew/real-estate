import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Drawer%20Screen/Drawer%20Widgets/drawer_widgets.dart';
import 'package:pro_2/Util/api_endpoints.dart';
import 'package:pro_2/Util/dimensions.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pro_2/Util/network_helper.dart';


class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  Future<String?> fetchImage() async {
    String? token = CacheHelper.getString(key: 'token');

    final response = await NetworkHelper.get(
      ApiAndEndpoints.showMyImage,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );


    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Dimensions.screenWidth(context) / 1.5,
      elevation: 0.0,
      child: Material(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              FutureBuilder<String?>(
                future: fetchImage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.grey,
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return CircleAvatar(
                      backgroundImage: AssetImage("assets/images/General/App_Icon.png"),
                      radius: 40.0,
                      backgroundColor: Colors.white,
                    );
                  } else if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data!),
                      radius: 40.0,
                      backgroundColor: Colors.white,
                    );
                  } else {
                    return CircleAvatar(
                      backgroundImage: AssetImage("assets/images/General/App_Icon.png"),
                      radius: 40.0,
                      backgroundColor: Colors.white,
                    );
                  }
                },
              ),
              const SizedBox(height: 10.0),
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
                  ? build_for_Broker(context):build_for_banned(context))
                  // : const Text("Error confirming identity")),
            ],
          ),
        ),
      ),
    );
  }
}

