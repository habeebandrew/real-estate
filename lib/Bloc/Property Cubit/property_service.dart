
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pro_2/Data/favourite_model.dart';
import 'package:pro_2/Data/property_model.dart';
import 'package:pro_2/Util/api_endpoints.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/network_helper.dart';

class PropertyService{



  static Future getProperty(int userId) async {
    try
    {

      debugPrint(userId.toString());
      var data = await NetworkHelper.get(
          '${ApiAndEndpoints.getProperty}$userId',
          headers: {
            'Content-Type': 'application/json',
          }
      );
      print(data.statusCode);
      print(data.body);
      if (data.statusCode == 200) {
        return propertyFromJson(data.body) ;
      } else {
        return 'Failed to load properties';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future filterProperty({int? statusId, int? propertyTypeId, int? cityId}) async {
    // Construct the base URL
    String baseUrl = ApiAndEndpoints.filterProperty;

    // Append filters to the URL based on provided parameters
    if (cityId != null) {
      baseUrl += '${ApiAndEndpoints.filterGovernorate}$cityId&';
    }
    if (statusId != null) {
      baseUrl += '${ApiAndEndpoints.filterStatus}$statusId&';
    }
    if (propertyTypeId != null) {
      baseUrl += '${ApiAndEndpoints.filterPropertyType}$propertyTypeId&';
    }

    // Remove the trailing '&' if there is one
    if (baseUrl.endsWith('&')) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }

    try {
      var data = await NetworkHelper.get(
          baseUrl,
          headers: {
            'Content-Type': 'application/json',
          }
      );
      print(data.statusCode);
      print(data.body);
      if (data.statusCode == 200) {
        return propertyFromJson(data.body);
      } else {
        return 'Failed to load properties';
      }
    } catch (e) {
      return e.toString();
    }
  }


  static Future addFavourite(int id) async {
    try
    {
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      var data = await NetworkHelper.post(
          ApiAndEndpoints.addFavourite,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: {
            'property_id': '$id',
          }
      );
      print(data.statusCode);
      print(data.body);
      if (data.statusCode == 200 || data.statusCode == 201) {
        var res= jsonDecode(data.body)['message'];
        return res;
      } else {
        return 'Failed to add to favourites';
      }
    } catch (e) {
      return e.toString();
    }

  }

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
  }

  static Future deleteFavourite(int propertyId) async {
    try {
      debugPrint(propertyId.toString());
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      var data = await NetworkHelper.delete(
        '${ApiAndEndpoints.addFavourite}${ApiAndEndpoints.deleteFavourite}property_id=$propertyId',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print(data.statusCode);
      print(data.body);
      if (data.statusCode == 200) {
        var res= jsonDecode(data.body)['message'];
        return res;
      } else {
        return 'Failed to delete favourites';
      }
    } catch (e) {
      return e.toString();
    }
  }
}