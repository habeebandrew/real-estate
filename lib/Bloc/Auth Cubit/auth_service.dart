import 'dart:convert';
import 'package:pro_2/Util/api_endpoints.dart';
import 'package:pro_2/Util/network_helper.dart';

class AuthService{

 static Future signUp({
   required firstName,
   required lastName,
   required email,
   required password,
   required passwordConfirm,
 }) async {
    var response = await NetworkHelper.post(
     ApiAndEndpoints.signUp,
      headers: {
       'Content-Type':'application/json'
      },
      body: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "passwoord": password,
        "passwoord_confirmation": passwordConfirm
      },

    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        print(data);
      } catch (e) {
        print('Failed to parse JSON: $e');
      }
    } else {
      print('Failed to load data. HTTP status: ${response.statusCode}');
    }
  }
}