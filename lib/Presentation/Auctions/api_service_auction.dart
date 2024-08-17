import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Util/api_endpoints.dart';
import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/animation.dart';
import '../../Util/global Widgets/mySnackBar.dart';

class ApiServiceAuctions {
  String token = ( CacheHelper.getString(key: 'token'))!;


  Future<List<Map<String, dynamic>>> fetchAuctions() async {


    final response = await http.get(
        Uri.parse(ApiAndEndpoints.api + ApiAndEndpoints.showAuctions),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      List<dynamic> auctions = json.decode(response.body);
      return auctions.map((auction) => auction as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load auctions');
    }
  }
  Future<void> addAuction({
    required String propertyType,
    required String address,
    required String description,
    required String features,
    required String theOwner,
    required double firstPrice,
    required List<File> images,
    required BuildContext context,
  }) async {
    String api = await ApiAndEndpoints.api;

    String api_addauctions =api+"addAuction";
    final url = Uri.parse(api_addauctions);
    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['property_type'] = propertyType;
    request.fields['address'] = address;
    request.fields['description'] = description;
    request.fields['features'] = features;
    request.fields['the_owner'] = theOwner;
    request.fields['first_price'] = firstPrice.toString();

    for (int i = 0; i < images.length; i++) {
      var image = await http.MultipartFile.fromPath(
          'url_image${i + 1}', images[i].path);
      request.files.add(image);
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      mySnackBar(title: "Auctions added successful", context: context);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).push(
          MyAnimation.createRoute(AppRoutes.homeScreen),
        );
      });
      print('Auction added successfully');
    } else {
      throw Exception('Failed to add auction: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchAuctionDetails(int id) async {
    final response = await http.get(
        Uri.parse(ApiAndEndpoints.api + ApiAndEndpoints.auctionid+"$id"),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load auction details');
    }
  }
  Future<List<Map<String, dynamic>>> fetchAuctionParticipants(int auctionId) async {
    final response = await http.get(
        Uri.parse(ApiAndEndpoints.api + ApiAndEndpoints.auctionParticipants+"$auctionId"),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token',
        });


    if (response.statusCode == 200) {
      List<dynamic> participants = json.decode(response.body);
      return participants.map((participant) => participant as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load auction participants');
    }
  }
  Future<void> addParticipate(int auctionId, double price, BuildContext context) async {
    final response = await http.post(
      Uri.parse(ApiAndEndpoints.api + ApiAndEndpoints.addParticipate),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'auction_id': auctionId.toString(),
        'price': price.toString(),
      }),
    );
    print("1");
    if (response.statusCode != 200) {
      print(response.body);
      print(response.statusCode);

      // throw Exception('Failed to submit the offer');
      mySnackBar(title: 'added Participate failed', context: context,color: Colors.red);

  }
    else if (response.statusCode == 200) {    print("1");
mySnackBar(title: 'added Participate successful', context: context,color: Colors.green);  }
  }
}
