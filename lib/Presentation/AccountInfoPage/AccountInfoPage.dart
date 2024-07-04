import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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
  File? _imageFile;
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      await _uploadImage(); // تأكد من استخدام await هنا
    }
  }
  Future<void> _uploadImage() async {
    String? token = CacheHelper.getString(key: 'token');
    if (_imageFile == null || token == null) {
      // Handle error for missing token or image
      print("No image file or token provided");
      return;
    }
    // 'http://192.168.1.106:8000/api/editProfile'
    final uri = Uri.parse(ApiAndEndpoints.api+ApiAndEndpoints.editProfile); // تأكد من صحة عنوان URL هنا
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      print("Image uploaded successfully");
      await CacheHelper.putString(key: 'image', value: _imageFile!.path);
      setState(() {
        image = _imageFile!.path;
      });
    } else {
      print("Failed to upload image");
      final responseBody = await response.stream.bytesToString();
      print("Response: $responseBody");
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
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
  _showEditImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Profile Picture"),
          content: Text("Select a new profile picture"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _pickImage();
              },
              child: Text("Choose from Gallery"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
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
                  backgroundImage: image != null
                      ? (File(image!).existsSync()
                      ? FileImage(File(image!))
                      : NetworkImage(image!)) as ImageProvider
                      : AssetImage(''),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blueAccent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: _showEditImageDialog,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              name ?? 'Unknown Name',
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
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(width: 10),
                        Text(
                          phoneNumber.isEmpty
                              ? 'No phone number added'
                              : phoneNumber,
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
                SizedBox(width: 8),
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
