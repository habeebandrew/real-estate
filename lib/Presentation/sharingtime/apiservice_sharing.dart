import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro_2/Util/global%20Widgets/animation.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';

import '../../Util/api_endpoints.dart';
import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';

class Property_sharing {
  final int id;
  final String propertyType;
  final String address;
  final double price;
  final String createdAt;
  final String end;
  final String description;
  final String number;


  final String owners;
  final String features;
  final String user_name;
  final List<String> images;


  Property_sharing({
    required this.id,
    required this.propertyType,
    required this.address,
    required this.number,

    required this.price,
    required this.createdAt,
    required this.end,
    required this.description,
    required this.user_name,

    required this.owners,
    required this.features,
    required this.images,
  });

  factory Property_sharing.fromJson(Map<String, dynamic> json) {
    return Property_sharing(
      id: json['id'] ?? 0,
      propertyType: json['propertyType'] ?? '',
      address: json['address'] ?? '',
      number: json['number'] ?? '',
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
      createdAt: json['created_at'] ?? '',
      end: json['end'] ?? '',
      description: json['description'] ?? '',
      user_name: json['user_name'] ?? '',
      owners: json['the_owners'] ?? '',
      features: json['features'] ?? '',
      images: json['Images'] != null ? List<String>.from(json['Images']) : [],
    );
  }

}

class ApiService_sharing {
  String token = ( CacheHelper.getString(key: 'token'))!;


  Future<List<Property_sharing>> fetchProperties() async {
    final response = await http.get(
        Uri.parse(ApiAndEndpoints.api + ApiAndEndpoints.showSharingTimePropertyInListHome),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {print(response.body);
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Property_sharing.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load properties');
    }
  }

  Future<Property_sharing> fetchPropertyDetails(int id) async {
    final response = await http.get(
      Uri.parse(ApiAndEndpoints.api + ApiAndEndpoints.showSharingTimePropertyDetails + '$id'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Property_sharing.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load property details');
    }
  }

  Future<void> addSharingTimeProperty(
      String propertyType,
      String address,
      String description,
      String features,
      String theOwners,
      double price,
      DateTime start,
      DateTime end,
      List<File> images,
      BuildContext context,
      ) async {
    String api = await ApiAndEndpoints.api;

    String api_addauctions =api+"addSharingTimeProperty";
    final url = Uri.parse(api_addauctions);
    var request = http.MultipartRequest("POST", url);
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['property_type'] = propertyType;
    request.fields['address'] = address;
    request.fields['description'] = description;
    request.fields['features'] = features;
    request.fields['the_owners'] = theOwners;
    request.fields['price'] = price.toString();
    request.fields['start'] = start.toIso8601String();
    request.fields['end'] = end.toIso8601String();

    for (int i = 0; i < images.length; i++) {
      var image = await http.MultipartFile.fromPath(
          'url_image${i + 1}', images[i].path);
      request.files.add(image);
    }

    var response = await request.send();
    if(response.statusCode==200){
      mySnackBar(title: "Auctions added successful", context: context);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).push(
          MyAnimation.createRoute(AppRoutes.homeScreen),
        );
      });
    }
   else if (response.statusCode != 200) {
      throw Exception("Failed to add property");
    }

  }
}
