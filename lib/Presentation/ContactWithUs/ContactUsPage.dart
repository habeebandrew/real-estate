import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pro_2/generated/l10n.dart';
import '../../Util/api_endpoints.dart';
import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/animation.dart';
import '../../Util/global Widgets/mySnackBar.dart';
import '../../Util/network_helper.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  String _selectedCategory = 'اقتراح';
  final TextEditingController _messageController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedCategory = S.of(context)!.suggestion; // Set a valid default
  }

  Future<void> contacts_us(String title, String content) async {
    final Map<String, String> categoryMap = {
      S.of(context)!.suggestion: 'suggestion',
      S.of(context)!.complaint: 'complaint',
      S.of(context)!.request: 'request',
    };


    String convertedTitle = categoryMap[title] ?? title;
    print(convertedTitle);
    print(content);
    String token = (await CacheHelper.getString(key: 'token'))!;
    final response = await NetworkHelper.post(
      ApiAndEndpoints.contacts,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body:{
        'title': convertedTitle,
        'content': content,
      },
    );

    if (response.statusCode == 200) {
      print("1");
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(response.body);

      mySnackBar(
        context: context,
        title: S.of(context)!.messageSentSuccessfully,
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MyAnimation.createRoute(AppRoutes.homeScreen));
      });
    } else {
      mySnackBar(
        color: Colors.red,
        context: context,
        title: S.of(context)!.messageSendingFailed,
      );
      throw Exception('Failed to send');
    }
  }

  Future<void> handleInquiry(String content) async {
    String token = (await CacheHelper.getString(key: 'token'))!;
    final response = await NetworkHelper.post(
      ApiAndEndpoints.inquiries,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body:{
        'message': content,
      },
    );

    if (response.statusCode == 200) { final Map<String, dynamic> responseData = jsonDecode(response.body);
    print(response.body);
      mySnackBar(
        context: context,
        title: S.of(context)!.inquirySentSuccessfully,
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MyAnimation.createRoute(AppRoutes.homeScreen));
      });
    } else {
      mySnackBar(
        color: Colors.red,
        context: context,
        title: S.of(context)!.inquirySendingFailed,
      );
      throw Exception('Failed to send inquiry');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)!.contactUsTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context)!.emailButton, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.email),
                      label: Text(S.of(context)!.emailButton),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      onPressed: () {
                        // Handle email button press
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.phone),
                      label: Text(S.of(context)!.phoneButton),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () {
                        // Handle phone button press
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(S.of(context)!.workingHours),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: <String>[
                  S.of(context)!.suggestion,
                  S.of(context)!.complaint,
                  S.of(context)!.request,
                  S.of(context)!.inquiry,
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: S.of(context)!.chooseCategory,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "message",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedCategory == S.of(context)!.inquiry) {
                          handleInquiry(_messageController.text);
                        } else {
                          contacts_us(_selectedCategory, _messageController.text);
                        }
                      },
                      child: Text(S.of(context)!.sendRequest),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle cancel button press
                      },
                      child: Text(S.of(context)!.cancel),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}