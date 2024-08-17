import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro_2/Presentation/Ad%20Propert%20Screen/SelectLocationScreen.dart';
import 'package:pro_2/Util/api_endpoints.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/animation.dart';
import '../../Util/global Widgets/mySnackBar.dart';

class AdPropertyScreen extends StatefulWidget {
  const AdPropertyScreen({super.key});

  @override
  State<AdPropertyScreen> createState() => _AdPropertyScreenState();
}

class _AdPropertyScreenState extends State<AdPropertyScreen> {
  LatLng? _selectedLocation;

  void _openSelectLocationScreen() async {
    final LatLng? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectLocationScreen(),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        _selectedLocation = selectedLocation;
      });

      // طباعة الإحداثيات في الـ debug console
      print('Selected Location: Latitude ${selectedLocation
          .latitude}, Longitude ${selectedLocation.longitude}');
      await CacheHelper.putdouble(key: 'x', value: selectedLocation
          .latitude);
      await CacheHelper.putdouble(key: 'y', value: selectedLocation.longitude);


    }
  }


  List<XFile> images = [];
  List<XFile> images360 = [];
  Future<void> pickImage() async {
    final XFile? selectedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        images!.add(selectedImage);
      });
    }
  }
  Future<void> pickImage360() async {
    final XFile? selectedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        images360!.add(selectedImage);
      });
    }
  }
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
  // String? num_of_floor;
  String? rentalDuration;
  int? numberOfRooms;
  int? floors;
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
  final List<String> furnishings = ['مفروش', 'غير مفروش', 'نصف مفروش'];
  //الاتجاهات
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
  final List<int> _num_of_floor = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
  ];
  final List<String> rentalDurations = ['يومي', 'شهري', 'سنوي'];
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
    String api = await ApiAndEndpoints.api; // انتظار قيمة الـ api هنا

    final int provinceId = provinceIds[province]!;
    final response = await http.get(Uri.parse(
      // 'http://192.168.1.106:8000/api/fetchAllAddresses?governorate_id=$provinceId'
        api + ApiAndEndpoints.fetchAllAddresses + '$provinceId'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        cities = data.map((city) {
          return {'id_address': city['id_address'], 'address': city['address']};
        }).toList();
        isLoadingCities = false;
      });
    } else {
      throw Exception('Failed to load cities');
    }
  }

  Future<void> sendPropertyData() async {
    String token = (await CacheHelper.getString(key: 'token'))!;
    int? user_id = (await CacheHelper.getInt(key: 'id'))!;

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
    String api = await ApiAndEndpoints.api; // انتظار قيمة الـ api هنا
    
    // إعداد البيانات للإرسال
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(api + ApiAndEndpoints.addPropertyAd),
    );
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['status_id'] = statusId.toString() ?? '';
    request.fields['property_type_id'] = propertyTypeId.toString() ?? '';
    request.fields['governorate_id'] = governorateId.toString() ?? '';
    request.fields['address_id'] = selectedCityId.toString() ?? '';
    request.fields['user_id'] = user_id.toString() ?? '';
    request.fields['price'] = price.toString() ?? '';
    request.fields['size'] = area.toString() ?? '';
    request.fields['owner_of_the_property'] = ownershipType ?? '';
    request.fields['Furnished'] = furnishing ?? '';
    request.fields['direction'] = orientation ?? '';
    request.fields['condition'] = condition ?? '';
    request.fields['rental_period'] = rentalDuration ?? '';
    request.fields['numberOfRoom'] = numberOfRooms.toString() ?? '';
    request.fields['floor'] = floors.toString();
    request.fields['description'] = description ?? '';
    request.fields['features'] = selectedSpecialFeatures ?? '';

    //position
   double? x= await CacheHelper.getdouble(key: 'x');
    double? y=   await CacheHelper.getdouble(key: 'y');

    request.fields['x'] = "$x"?? '';
    request.fields['y'] =  "$y" ?? '';

    // إضافة الصور للطلب
    for (int i = 0; i < images.length; i++) {
      var image = await http.MultipartFile.fromPath(
          'url_image${i + 1}', images[i].path);
      request.files.add(image);
    }
    int length =images.length;
    request.fields['imageCount'] ="$length";

    //360****
    for (int i = 0; i < images360.length; i++) {
      var image = await http.MultipartFile.fromPath(
          'url_image360${i + 1}', images360[i].path);
      request.files.add(image);
    }
    request.fields['image360Count'] ="$length";

    var response = await request.send();

    if (response.statusCode == 200) {
   await CacheHelper.deleteDouble(key: 'x');
         await CacheHelper.deleteDouble(key: 'y');

      mySnackBar(
        context: context,
        title: 'تم إرسال بيانات العقار بنجاح',
      );
      print('Data sent successfully!');
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MyAnimation.createRoute(AppRoutes.homeScreen));
      });
    } else {
      await CacheHelper.deleteDouble(key: 'x');
      await CacheHelper.deleteDouble(key: 'y');

      print(response.statusCode);
      print(await response.stream.bytesToString());
      print('*********************');
      mySnackBar(
        color: Colors.red,
        context: context,
        title: 'فشل إرسال البيانات الرجاء ادخال البيانات بشكلها الصحيح',
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
    return Scaffold( floatingActionButton: FloatingActionButton(
      onPressed: _openSelectLocationScreen,
      child: const Icon(Icons.add_location),
    ),


      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.mainColor2,
        title: const Text('Property Form'),
      ),
      body:
      Padding(
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
                      title: const Text('شراء'),
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
                      title: const Text('اجار'),
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
              Center(
                  child: _selectedLocation == null
                      ? const Text('No location selected.')
                      : Text(
                    'Selected Location:\nLatitude: ${_selectedLocation!.latitude}\nLongitude: ${_selectedLocation!.longitude}',
                    textAlign: TextAlign.center,
                  )),
              // Property Type
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'نوع العقار',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Constants.mainColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value:
                selectedPropertyType.isEmpty ? null : selectedPropertyType,
                items: propertyTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(
                      type,
                      style: const TextStyle(fontSize: 14),
                    ),
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
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Constants.mainColor,
                ),
                iconSize: 24,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Province
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'المحافظة',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Constants.mainColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: selectedProvince.isEmpty ? null : selectedProvince,
                items: provinces.map((province) {
                  return DropdownMenuItem<String>(
                    value: province,
                    child: Text(
                      province,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedProvince = value!;
                    selectedCity =
                    ''; // لإعادة تعيين المدينة عند تغيير المحافظة
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
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Constants.mainColor,
                ),
                iconSize: 24,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // City
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'المدينة',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Constants.mainColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: selectedCity.isEmpty ? null : selectedCity,
                items: cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city['address'],
                    child: Text(
                      city['address'],
                      style: const TextStyle(fontSize: 14),
                    ),
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
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Constants.mainColor,
                ),
                iconSize: 24,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Price
              Container(
                // width: 10, // تحديد عرض الحقل
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'السعر SP',
                    labelStyle: const TextStyle(
                      fontSize: 14, // تقليل حجم نص التسمية
                      fontWeight: FontWeight.bold,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8), // تحسين الحشو
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true), // دعم الأرقام مع النقاط العشرية
                  onChanged: (value) {
                    setState(() {
                      price = double.tryParse(value) ?? 0; // تعيين قيمة السعر
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
                  style: const TextStyle(
                    fontSize: 14, // تقليل حجم النص داخل الحقل
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Area
              Container(
                width: 150, // تحديد عرض الحقل
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'المساحة م2',
                    labelStyle: const TextStyle(
                      fontSize: 14, // تقليل حجم نص التسمية
                      fontWeight: FontWeight.bold,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8), // تحسين الحشو
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true), // دعم الأرقام مع النقاط العشرية
                  onChanged: (value) {
                    setState(() {
                      area = double.tryParse(value) ?? 0;
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
                  style: const TextStyle(
                    fontSize: 14, // تقليل حجم النص داخل الحقل
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // Ownership Type
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'نوع الملكية',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Constants.mainColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: ownershipType,
                items: ownershipTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(
                      type,
                      style: const TextStyle(fontSize: 14),
                    ),
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
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Constants.mainColor,
                ),
                iconSize: 24,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Furnishing
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'التأثيث',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Constants.mainColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: furnishing,
                items: furnishings.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(
                      type,
                      style: const TextStyle(fontSize: 14),
                    ),
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
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Constants.mainColor,
                ),
                iconSize: 24,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

// Orientation
              if (selectedPropertyType != "فيلا" &&
                  selectedPropertyType != "أرض" &&
                  selectedPropertyType != "بناء" &&
                  selectedPropertyType != "مزرعة")
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'الاتجاه',
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: orientation,
                  items: orientations.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: const TextStyle(fontSize: 14),
                      ),
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
                  dropdownColor: Colors.white,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Constants.mainColor,
                  ),
                  iconSize: 24,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              // Condition
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'الحالة',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Constants.mainColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Constants.mainColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: condition,
                items: conditions.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(
                      type,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    condition = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a condition';
                  }
                  return null;
                },
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Constants.mainColor,
                ),
                iconSize: 24,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Rental Duration
              if (!isForSale)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'مدة الايجار',
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: rentalDuration,
                  items: rentalDurations.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      rentalDuration = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a rental duration';
                    }
                    return null;
                  },
                  dropdownColor: Colors.white,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Constants.mainColor,
                  ),
                  iconSize: 24,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),

              // Number of Rooms
              const SizedBox(
                height: 10,
              ),

              Container(
                // width: 150, // تحديد عرض الحقل
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'عدد الغرف',
                    labelStyle: const TextStyle(
                      fontSize: 14, // تقليل حجم نص التسمية
                      fontWeight: FontWeight.bold,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8), // تحسين الحشو
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number, // دعم الأرقام فقط
                  onChanged: (value) {
                    setState(() {
                      numberOfRooms =
                          int.tryParse(value) ?? 0; // تعيين قيمة عدد الغرف
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
                  style: const TextStyle(
                    fontSize: 14, // تقليل حجم النص داخل الحقل
                  ),
                ),
              ),
              // Floors

              if (selectedPropertyType == "شقة" ||
                  selectedPropertyType == "مكتب")
                const SizedBox(
                  height: 10,
                ),
              if (selectedPropertyType ==
                  "شقة" || //test here  and remove*******************
                  selectedPropertyType == "مكتب")
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: 'رقم الطابق',
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: floors,
                  items: _num_of_floor.map((type) {
                    return DropdownMenuItem<int>(
                      value: type,
                      child: Text(
                        type.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      floors = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a floor number';
                    }
                    return null;
                  },
                  dropdownColor: Colors.white,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Constants.mainColor,
                  ),
                  iconSize: 24,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),

              const SizedBox(
                height: 10,
              ),
              if (selectedPropertyType != "شقة" &&
                  selectedPropertyType != "مكتب")
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: 'عدد الطوابق',
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: floors,
                  items: _num_of_floor.map((type) {
                    return DropdownMenuItem<int>(
                      value: type,
                      child: Text(
                        type.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      floors = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select the number of floors';
                    }
                    return null;
                  },
                  dropdownColor: Colors.white,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Constants.mainColor,
                  ),
                  iconSize: 24,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),

              // TextFormField(
              //   decoration: InputDecoration(labelText: 'عدد الطوابق'),
              //   keyboardType: TextInputType.number,
              //   onChanged: (value) {
              //     setState(() {
              //       floors = double.tryParse(value);
              //     });
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the number of floors';
              //     }
              //     if (double.tryParse(value) == null) {
              //       return 'Please enter a valid number of floors';
              //     }
              //     return null;
              //   },
              // ),
              // Description
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'الوصف'),
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
              const SizedBox(
                height: 20,
              ),
              // Special Features
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickImage,
                child: const Text('اختر الصور'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.mainColor2,
                ),
              ),
              const SizedBox(height: 20),
              // عرض الصور المختارة
              if (images != null && images!.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: images.length + 1,
                  itemBuilder: (context, index) {
                    if (index == images.length) {
                      return GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.add,
                            size: 50,
                          ),
                        ),
                      );
                    } else {
                      return Stack(
                        children: [
                          Image.file(
                            File(images[index].path),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  images.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),

              ElevatedButton(
                onPressed: pickImage360,
                child: const Text(' 360*اختر الصور'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.mainColor2,
                ),
              ),
              // عرض الصور المختارة
              if (images360 != null && images360!.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: images360.length + 1,
                  itemBuilder: (context, index) {
                    if (index == images360.length) {
                      return GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.add,
                            size: 50,
                          ),
                        ),
                      );
                    } else {
                      return Stack(
                        children: [
                          Image.file(
                            File(images360[index].path),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  images360.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.mainColor2,
                ),
                onPressed: () {
                  if (CacheHelper.getdouble(key: 'x')==null) {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: const Text('Location Confirmation'),
    content: const Text('Please select a location on the map to proceed.'),
    actions: [
    TextButton(
    onPressed: () {
    Navigator.of(context).pop(); // إغلاق الـ Dialog
    },
    child: const Text('OK'),
    ),
    ],
    );                  });}
                 else if (_formKey.currentState!.validate()) {
                    sendPropertyData();
                  }
                },
                child: const Text('إرسال'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
