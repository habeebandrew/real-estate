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

  // القيم الجديدة
  double? price;
  double? area;
  String? ownershipType;
  String? furnishing;
  String? orientation;
  String? condition;
  String? rentalDuration;
  int? numberOfRooms;
  double? floors;
  String? description;

  final List<String> ownershipTypes = [
    'طابو اخضر',
    'عقد بيع قطعي',
    'حكم المحكمة',
    'وكالة كاتب العدل',
    'طابو أسهم',
    'طابو زراعي',
    'طابو إسكان',
    'فروغ'
  ];

  final List<String> furnishings = [
    'مفروش',
    'غير مفروش',
    'نصف مفروش'
  ];

  final List<String> orientations = [
    'شمال',
    'جنوب',
    'شرق',
    'غرب',
    'الشمال الشرقي',
    'الجنوب الشرقي',
    'الجنوب الغربي',
    'الشمال الغربي',
    'الشمال الجنوبي',
    'الغرب الشرقي'
  ];

  final List<String> conditions = [
    'سوبر ديلوكس',
    'كسوة جديدة',
    'حالة جيدة',
    'كسوة قديمة',
    'على العظم'
  ];

  final List<String> rentalDurations = [
    'يومي',
    'شهري',
    'سنوي'
  ];

  final List<String> specialFeatures = [
    'مصعد',
    'كهرباء بطاقة شمسية',
    'تراس',
    'كراج',
    'مسبح',
    'التسخين بطاقة الشمس',
    'شرفة'
  ];

  final TextEditingController propertyTypeController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Map<String, bool> selectedFeatures = {
    'مصعد': false,
    'كهرباء بطاقة شمسية': false,
    'تراس': false,
    'كراج': false,
    'مسبح': false,
    'التسخين بطاقة الشمس': false,
    'شرفة': false
  };

  List<Map<String, dynamic>> cities = [];
  bool isLoadingCities = false;

  Future<void> fetchCities(String province) async {
    final Map<String, int> provinceIds = {
      'Damascus': 1,
      'Rif Damascus': 2,
      'Homs': 3
    };
    String token = (await CacheHelper.getString(key: 'token'))!;

    final int provinceId = provinceIds[province]!;
    final response = await http.get(
        Uri.parse(
          // 'http://192.168.1.106:8000/api/fetchAllAddresses?governorate_id=$provinceId'
            ApiAndEndpoints.api+ApiAndEndpoints.fetchAllAddresses+'$provinceId'
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        cities = data.map((city) {
          return {
            'id_address': city['id_address'],
            'address': city['address']
          };
        }).toList();
        isLoadingCities = false;
      });
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

    // جمع الميزات الخاصة التي تم اختيارها
    String selectedSpecialFeatures = selectedFeatures.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .join(',');

    final response = await http.post(
      Uri.parse( ApiAndEndpoints.api+ApiAndEndpoints.addPropertyAd),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'status_id': statusId,
        'property_type_id': propertyTypeId,
        'governorate_id': governorateId,
        'address_id': selectedCityId,
        'user_id': user_id,
        'price': price,
        'size': area,
        'owner_of_the_property': ownershipType,
        'Furnished': furnishing,
        'direction': orientation,
        'condition': condition,
        'rental_period': rentalDuration,
        'numberOfRoom': numberOfRooms,
        'floor': floors,
        'description': description,
        'features': selectedSpecialFeatures,
      }),
    );

    if (response.statusCode == 200) {
      mySnackBar(
        context: context,
        title: 'تم إرسال بيانات العقار بنجاح',
      );
      print('Data sent successfully!');
    } else {
      mySnackBar(
        color: Colors.red,
        context: context,
        title: 'فشل إرسال البيانات',
      );
      print('Failed to send data.');
    }
  }

  @override
  void dispose() {
    propertyTypeController.dispose();
    provinceController.dispose();
    cityController.dispose();
    descriptionController.dispose();
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
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a property type';
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
                    selectedCity = ''; // لإعادة تعيين المدينة عند تغيير المحافظة
                    selectedCityId = -1; // إعادة تعيين id_address
                    isLoadingCities = true;
                  });
                  fetchCities(selectedProvince);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a province';
                  }
                  return null;
                },
              ),
              // City
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'المدينة'),
                value: selectedCity.isEmpty ? null : selectedCity,
                items: cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city['address'],
                    child: Text(city['address']),
                    onTap: () {
                      selectedCityId = city['id_address']; // تعيين id_address
                    },
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a city';
                  }
                  return null;
                },
              ),
              // Price
              TextFormField(
                decoration: InputDecoration(labelText: 'السعر'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    price = double.tryParse(value);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              // Area
              TextFormField(
                decoration: InputDecoration(labelText: 'المساحة'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    area = double.tryParse(value);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an area';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid area';
                  }
                  return null;
                },
              ),
              // Ownership Type
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'نوع الملكية'),
                value: ownershipType,
                items: ownershipTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    ownershipType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an ownership type';
                  }
                  return null;
                },
              ),
              // Furnishing
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'التأثيث'),
                value: furnishing,
                items: furnishings.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    furnishing = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a furnishing type';
                  }
                  return null;
                },
              ),
              // Orientation
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'الاتجاه'),
                value: orientation,
                items: orientations.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    orientation = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an orientation';
                  }
                  return null;
                },
              ),
              // Condition
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'الحالة'),
                value: condition,
                items: conditions.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    condition = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a condition';
                  }
                  return null;
                },
              ),
              // Rental Duration
              if (!isForSale)

                DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'مدة الايجار'),
                value: rentalDuration,
                items: rentalDurations.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    rentalDuration = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a rental duration';
                  }
                  return null;
                },
              ),
              // Number of Rooms
              TextFormField(
                decoration: InputDecoration(labelText: 'عدد الغرف'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    numberOfRooms = int.tryParse(value);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of rooms';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number of rooms';
                  }
                  return null;
                },
              ),
              // Floors
              TextFormField(
                decoration: InputDecoration(labelText: 'عدد الطوابق'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    floors = double.tryParse(value);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of floors';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number of floors';
                  }
                  return null;
                },
              ),
              // Description
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'الوصف'),
                maxLines: 5,
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              // Special Features
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ميزات خاصة',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ...specialFeatures.map((feature) {
                    return CheckboxListTile(
                      title: Text(feature),
                      value: selectedFeatures[feature],
                      onChanged: (value) {
                        setState(() {
                          selectedFeatures[feature] = value!;
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
              // Submit Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // print(selectedSpecialFeatures);
                  if (_formKey.currentState!.validate()) {
                    sendPropertyData();
                  }
                },
                child: Text('إرسال'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}