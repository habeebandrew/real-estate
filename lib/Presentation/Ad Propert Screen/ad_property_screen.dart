import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro_2/Util/api_endpoints.dart';
import 'dart:convert';

import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/mySnackBar.dart';

class AdPropertyScreen extends StatefulWidget {
  const AdPropertyScreen({super.key});

  @override
  State<AdPropertyScreen> createState() => _AdPropertyScreenState();
}

class _AdPropertyScreenState extends State<AdPropertyScreen> {
  bool isForSale = true;
  String selectedPropertyType = '';
  String selectedProvince = '';
  String selectedCity = '';
  int selectedCityId = -1; // لإمساك id_address

  final List<String> propertyTypes = [
    'فيلا',
    'شقة',
    'مكتب',
    'مزرعة',
    'محل تجاري',
    'أرض',
    'بناء',
    'شاليه'
  ];

  final List<String> provinces = ['Damascus', 'Rif Damascus', 'Homs'];

  final TextEditingController propertyTypeController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<List<Map<String, dynamic>>> fetchCities(String province) async {
    final Map<String, int> provinceIds = {
      'Damascus': 1,
      'Rif Damascus': 2,
      'Homs': 3
    };
    String token = (await CacheHelper.getString(key: 'token'))!;

    final int provinceId = provinceIds[province]!;
    final response = await http.get(
        Uri.parse('http://192.168.1.106:8000/api/fetchAllAddresses?governorate_id=$provinceId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((city) {
        return {
          'id_address': city['id_address'],
          'address': city['address']
        };
      }).toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }

  Future<void> sendPropertyData() async {
    String token = (await CacheHelper.getString(key: 'token'))!;
    int? user_id = (await CacheHelper.getInt(key: 'role_id'))!;

    // تحويل القيم
    int statusId = isForSale ? 1 : 2;
    int governorateId;
    switch (selectedProvince) {
      case 'Damascus':
        governorateId = 1;
        break;
      case 'Rif Damascus':
        governorateId = 2;
        break;
      case 'Homs':
        governorateId = 3;
        break;
      default:
        governorateId = 0; // قيمة افتراضية غير صحيحة
    }

    int propertyTypeId;
    switch (selectedPropertyType) {
      case 'شقة':
        propertyTypeId = 1;
        break;
      case 'مكتب':
        propertyTypeId = 2;
        break;
      case 'فيلا':
        propertyTypeId = 3;
        break;
      case 'مزرعة':
        propertyTypeId = 4;
        break;
      case 'محل تجاري':
        propertyTypeId = 5;
        break;
      case 'أرض':
        propertyTypeId = 6;
        break;
      case 'بناء':
        propertyTypeId = 7;
        break;
      case 'شاليه':
        propertyTypeId = 8;
        break;
      default:
        propertyTypeId = 0; // قيمة افتراضية غير صحيحة
    }

    final response = await http.post(
      Uri.parse('http://192.168.1.106:8000/api/addPropertyAd'),
      headers: {'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'status_id': statusId,
        'property_type_id': propertyTypeId,
        'governorate_id':  governorateId,
        'address_id':  selectedCityId,
        'user_id': user_id
      }),
    );

    if (response.statusCode == 200) {
      mySnackBar(
      context: context,
      title: 'send Property Data in successful',
    );
      print('Data sent successfully!');
    } else {
      mySnackBar(color: Colors.red,
        context: context,
        title: 'send Property Data in successful',
      );
      print('Failed to send data.');
    }
  }

  @override
  void dispose() {
    propertyTypeController.dispose();
    provinceController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Property Status
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('شراء'),
                      value: isForSale,
                      onChanged: (value) {
                        setState(() {
                          isForSale = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('اجار'),
                      value: !isForSale,
                      onChanged: (value) {
                        setState(() {
                          isForSale = !value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // Property Type
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'نوع العقار'),
                value: selectedPropertyType.isEmpty ? null : selectedPropertyType,
                items: propertyTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPropertyType = value!;
                    propertyTypeController.text = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى اختيار نوع العقار';
                  }
                  return null;
                },
              ),
              // Province
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'المحافظة'),
                value: selectedProvince.isEmpty ? null : selectedProvince,
                items: provinces.map((province) {
                  return DropdownMenuItem<String>(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedProvince = value!;
                    selectedCity = ''; // Reset city to empty string
                    selectedCityId = -1; // Reset city ID
                    provinceController.text = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى اختيار المحافظة';
                  }
                  return null;
                },
              ),
              // City
              if (selectedProvince.isNotEmpty)
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchCities(selectedProvince),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(labelText: 'المدينة'),
                        value: selectedCity.isEmpty ? null : selectedCity,
                        items: snapshot.data!.map((city) {
                          return DropdownMenuItem<String>(
                            value: city['address'],
                            child: Text(city['address']),
                            onTap: () {
                              selectedCityId = city['id_address'];
                            },
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCity = value!;
                            cityController.text = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى اختيار المدينة';
                          }
                          return null;
                        },
                      );
                    }
                  },
                ),
              // Submit Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sendPropertyData();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}