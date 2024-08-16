import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pro_2/Data/add_rate_info_model.dart';
import 'package:pro_2/Data/broker_Info_model.dart';
import 'package:pro_2/Data/favourite_model.dart';
import 'package:pro_2/Data/property_details_model.dart';
import 'package:pro_2/Data/property_model.dart';
import 'package:pro_2/Data/rate_info_model.dart';
import 'package:pro_2/Util/api_endpoints.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/network_helper.dart';

class PropertyService {

  static Future getProperty(int userId) async {
    try {
      debugPrint(userId.toString());
      var data = await NetworkHelper.get(
          '${ApiAndEndpoints.getProperty}$userId',
          headers: {
            'Content-Type': 'application/json',
          });
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

  static Future filterProperty(
      {int? statusId, int? propertyTypeId, int? cityId,int? userId}) async {
    String baseUrl = ApiAndEndpoints.filterProperty;

    if (cityId != null) {
      baseUrl += '${ApiAndEndpoints.filterGovernorate}$cityId&';
    }
    if (statusId != null) {
      baseUrl += '${ApiAndEndpoints.filterStatus}$statusId&';
    }
    if (propertyTypeId != null) {
      baseUrl += '${ApiAndEndpoints.filterPropertyType}$propertyTypeId&';
    }
    if(userId != null){
      baseUrl += 'user_id=$userId&';
    }

    if (baseUrl.endsWith('&')) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }

    try {
      var data = await NetworkHelper.get(baseUrl, headers: {
        'Content-Type': 'application/json',
      });
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

  static Future getPropertyDetails(int id) async {
    try {
      var data = await NetworkHelper.get(
        ApiAndEndpoints.getPropertyDetails+id.toString(),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(data.statusCode);
      print(data.body);
      if (data.statusCode == 200) {
        return propertyDetailsFromJson(data.body);
      }else {
        return 'Failed to load details';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future addFavourite(int id) async {
    try {
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      var data =
          await NetworkHelper.post(ApiAndEndpoints.addFavourite, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        'property_id': '$id',
      });
      print(data.statusCode);
      print(data.body);
      if (data.statusCode == 200 || data.statusCode == 201) {
        var res = jsonDecode(data.body)['message'];
        return res;
      } else {
        return 'Failed to add to favourites';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future getFavourite() async {
    try {
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      var data = await NetworkHelper.get(ApiAndEndpoints.getFavourite,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      print(data.statusCode);
      print(data.body);
      if (data.statusCode == 200) {
        return favouriteFromJson(data.body);
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
        var res = jsonDecode(data.body)['message'];
        return res;
      } else {
        return 'Failed to delete favourites';
      }
    } catch (e) {
      return e.toString();
    }
  }
  static Future getBrokerInfo(int brokerId)async{
    try {
      debugPrint(brokerId.toString());
      var data = await NetworkHelper.get(
          '${ApiAndEndpoints.getBrokerInfo}$brokerId',
          headers: {
            'Content-Type': 'application/json',
          });
      print(data.statusCode);
      print(data.body);
      if (data.statusCode == 200) {
        return brokerInfoModelFromJson(data.body);
      } else {
        return 'Failed to load info';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future getPropertyAdsByBroker(int brokerId)async{
    try {
      debugPrint(brokerId.toString());
      var data = await NetworkHelper.get(
          '${ApiAndEndpoints.getBrokerProperties}$brokerId',
          headers: {
            'Content-Type': 'application/json',
          });
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

  static Future reportBroker(userId,brokerId)async{
    try {
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      var data =
          await NetworkHelper.post(ApiAndEndpoints.reports, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        "reporter_id": userId,
        "reportable_type": "user",
        "reportable_id": brokerId,
        "report": "there is a report on this broker."
      });
      debugPrint(data.statusCode.toString());
      debugPrint(data.body);
      if (data.statusCode == 200 || data.statusCode == 201) {
        var res = jsonDecode(data.body)['message'];
        return res;
      } else {
        return 'Failed to report';
      }
    } catch (e) {
      return e.toString();
    }
  } 
   static Future<AddRateInfoModel?> rateBroker(userId,brokerId,double rate)async{
    
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      var data =
          await NetworkHelper.post(ApiAndEndpoints.rate, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
         'evaluate_id': '$userId',
         'evaluated_id': '$brokerId',
         'evaluation': '${rate.toInt()}'
      });
      debugPrint(data.statusCode.toString());
      debugPrint(data.body);
      if (data.statusCode == 200 || data.statusCode == 201) {
        var res = addrateInfoModelFromJson(data.body);
        return res;
      } else {
        return null ;
      }
    
  } 
  static Future <RateInfoModel?>  updateRateBroker(userId,brokerId,double rate,int rateId)async{
    
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      //need the rate id 
      var data =
          await NetworkHelper.put('${ApiAndEndpoints.rate}/$rateId',//rateId 
        headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
         'evaluate_id': userId,
         'evaluated_id': brokerId,
         'evaluation': rate.toInt()
      });
      debugPrint(data.statusCode.toString());
      debugPrint(data.body);
      if (data.statusCode == 200 || data.statusCode == 201) {
        var res = rateInfoModelFromJson(data.body);
        return res;
      } else {
        return null ;
      }
    
  } 
  static Future deleteRateBroker(int rateId)async{
    
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      //need the rate id 
      var data =
          await NetworkHelper.delete('${ApiAndEndpoints.rate}/delete?id=$rateId',//rateId 
        headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint(data.statusCode.toString());
      debugPrint(data.body);
      if (data.statusCode == 200 || data.statusCode == 201) {
         var res = jsonDecode(data.body)['message'];
        return res;
      } else {
        return 'failed to delete' ;
      }
    
  } 

  static Future<List<dynamic>> advancedSearch({
  int? statusId,
  int? propertyTypeId,
  int? cityId,
  int? addressId,
  String? minPrice,
  String? maxPrice,
  String? minSize,
  String? maxSize,
}) async {
  String url = '${ApiAndEndpoints.advancedSearch}';
  
  // Building the query parameters dynamically
  if (cityId != null) url += 'governorate_id=$cityId&';
  if (statusId != null) url += 'status_id=$statusId&';
  if (propertyTypeId != null) url += 'property_type_id=$propertyTypeId&';
  if (minPrice != null) url += 'min=$minPrice&';
  if (maxPrice != null) url += 'max=$maxPrice&';
  if (minSize != null) url += 'minSize=$minSize&';
  if (maxSize != null) url += 'maxSize=$maxSize&';
  if (addressId != null) url += 'address_id=$addressId&';
  
  if (url.endsWith('&')) {
      url = url.substring(0, url.length - 1);
    }
   
   debugPrint('SearchUrl:  $url');
  
  var data = await NetworkHelper.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  
  print(data.statusCode);
  print(data.body);
   
  if (data.statusCode == 200) {
    return propertyFromJson(data.body);
  } else {
    return [];
  }
}

}
  

