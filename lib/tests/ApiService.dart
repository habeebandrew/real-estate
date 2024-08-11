import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Util/api_endpoints.dart'; // تأكد من المسار الصحيح
import '../Util/cache_helper.dart'; // تأكد من المسار الصحيح
import '../Util/network_helper.dart'; // تأكد من المسار الصحيح

class ApiService {
  Future<List<String?>> fetch360Images(int propertyId) async {
    String token = (await CacheHelper.getString(key: 'token'))!;

    final response = await NetworkHelper.get(
      '${ApiAndEndpoints.showAllImagesProperty}?property_id=$propertyId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> images = data['images360'] ?? [];
      return images
          .map<String?>((img) => img != null ? img['image_URL'] as String? : null)
          .toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
