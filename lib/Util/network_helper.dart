import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pro_2/Util/api_endpoints.dart';

class NetworkHelper {


  static Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    String api = await ApiAndEndpoints.api; // انتظار قيمة الـ api هنا

    final url = Uri.parse(api+endpoint);
    final response = await http.get(url, headers: headers);
    return response;
  }

  static Future<http.Response> post(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    String api = await ApiAndEndpoints.api; // انتظار قيمة الـ api هنا

    final response = await http.post(
      Uri.parse(api+endpoint),
      headers: headers,
      body: json.encode(body),
    );

    return response;
  }
  static Future<http.Response> put(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    String api = await ApiAndEndpoints.api; // انتظار قيمة الـ api هنا

    final url = Uri.parse(api+endpoint);
    final response = await http.put(
      url,
      headers: headers ?? {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    return response;
  }

  static Future<http.Response> delete(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    String api = await ApiAndEndpoints.api; // انتظار قيمة الـ api هنا

    final url = Uri.parse(api+endpoint);
    final response = await http.delete(
      url,
      headers: headers,

    );
    return response;
  }

}
