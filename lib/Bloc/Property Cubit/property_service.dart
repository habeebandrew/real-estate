
import 'package:flutter/cupertino.dart';
import 'package:pro_2/Data/favourite_model.dart';
import 'package:pro_2/Util/api_endpoints.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/network_helper.dart';

class PropertyService{

 String token = (CacheHelper.getString(key: 'token'))!;

  static Future getFavourite() async {
    // try {
    //   String token = (CacheHelper.getString(key: 'token'))!;
    //   debugPrint(token);
    //   var data = await NetworkHelper.get(
    //       ApiAndEndpoints.getFavourite,
    //       headers: {
    //         "Content-Type": "application/json",
    //         'Authorization': 'Bearer $token '
    //       }
    //   );
    //   print(data.statusCode);
    //   print(data.body);
    //   if (data.statusCode == 200) {
    //     return favouriteFromJson(data.body) ;
    //   } else {
    //     return 'Failed to load favourites';
    //   }
    // } catch (e) {
    //   return e.toString();
    // }
  }
}