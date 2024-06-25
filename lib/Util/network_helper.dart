import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pro_2/Util/api_endpoints.dart';

class NetworkHelper {


  static Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse(ApiAndEndpoints.api+endpoint);
    final response = await http.get(url, headers: headers);
    return response;
  }

  static Future<http.Response> post(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    final response = await http.post(
      Uri.parse(ApiAndEndpoints.api+endpoint),
      headers: headers,
      body: json.encode(body),
    );

    return response;
  }
  static Future<http.Response> put(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    final url = Uri.parse(ApiAndEndpoints.api + endpoint);
    final response = await http.put(
      url,
      headers: headers ?? {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    return response;
  }


}
