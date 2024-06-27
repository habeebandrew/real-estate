
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pro_2/Data/favourite_model.dart';
import 'package:pro_2/Util/api_endpoints.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/network_helper.dart';

class PropertyService{

 String token = (CacheHelper.getString(key: 'token'))!;

  static Future getFavourite() async {
    try
    {
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      var data = await NetworkHelper.get(
          ApiAndEndpoints.getFavourite,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      print(data.statusCode);
      print(data.body);
      if (data.statusCode == 200) {
        return favouriteFromJson(data.body) ;
      } else {
        return 'Failed to load favourites';
      }
    } catch (e) {
      return e.toString();
    }
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

  static Future deleteFavourite(int id) async {
    try {
      debugPrint(id.toString());
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      var data = await NetworkHelper.delete(
        '${ApiAndEndpoints.addFavourite}${ApiAndEndpoints.deleteFavourite}id=$id',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (data.statusCode == 200) {
        var res= jsonDecode(data.body);
        return res;
      } else {
        return 'Failed to delete favourites';
      }
    } catch (e) {
      return e.toString();
    }
  }
}