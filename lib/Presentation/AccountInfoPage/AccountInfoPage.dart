import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // إضافة مكتبة خدمات

import '../../Util/api_endpoints.dart';
import '../../Util/cache_helper.dart';
import '../../Util/network_helper.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({super.key});

  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  String? image = CacheHelper.getString(key: 'image');
  String? name = CacheHelper.getString(key: 'name');
  String? number = CacheHelper.getString(key: 'number');
  String phoneNumber = '';
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // إذا لم يكن هناك رقم هاتف محفوظ، نقوم بتعيين قيمة افتراضية توضح عدم توفر رقم
    phoneNumber = number ?? '';
    phoneController.text = phoneNumber;
  }

  void _editPhoneNumber() {
    setState(() {
      phoneNumber = phoneController.text;
    });
    Navigator.of(context).pop();
  }

  Future<void> editNumber() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String? token = CacheHelper.getString(key: 'token');
    if (token == null) {
      // Handle error for missing token
      return;
    }
    var response = await NetworkHelper.post(
      ApiAndEndpoints.editProfile,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        'phone_number': phoneController.text,
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      print("Phone number has been edited");
      await CacheHelper.putString(key: 'number', value: phoneController.text);
      _editPhoneNumber();
      phoneController.clear();
    } else {
      // Handle error
    }
  }

  void _showEditPhoneDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit phone number"),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: "Enter the new phone number"),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],  // تصفية الإدخال لقبول الأرقام فقط
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                } else if (value.length < 10 || value.length > 13) {
                  return 'Phone number must be between 10 and 13 digits';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                editNumber();
              },
              child: Text("Edit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account informations"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(image ?? 'https://via.placeholder.com/150'), // ضع صورة افتراضية إذا كانت الصورة null
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // أضف هنا وظيفة لتعديل الصورة الشخصية
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              name ?? 'Unknown Name', // ضع نص افتراضي إذا كان الاسم null
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(width: 10),
                        Text(
                          phoneNumber.isEmpty ? 'No phone number added' : phoneNumber,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8), // إضافة مسافة بين النص والزر
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blueAccent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: _showEditPhoneDialog,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
