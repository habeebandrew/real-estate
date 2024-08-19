import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pro_2/Presentation/sharingtime/apiservice_sharing.dart';
import 'package:pro_2/generated/l10n.dart';

import '../../Util/constants.dart';

class Add_sharing_Screen extends StatefulWidget {
  const Add_sharing_Screen({super.key});

  @override
  State<Add_sharing_Screen> createState() => _Add_sharing_ScreenState();
}

class _Add_sharing_ScreenState extends State<Add_sharing_Screen> {
  final ApiService_sharing _apiService = ApiService_sharing();
  final _formKey = GlobalKey<FormState>();

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

  String? selectedPropertyType;
  String? selectedProvince;
  String description = '';
  String features = '';
  String theOwners = '';
  double? price;
  DateTime? startDate;
  DateTime? endDate;
  List<File> images = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        images.addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Check for required fields
      if (selectedPropertyType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('الرجاء اختيار نوع العقار')),
        );
        return;
      }

      if (selectedProvince == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('الرجاء اختيار الموقع')),
        );
        return;
      }

      if (startDate == null || endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('الرجاء اختيار تاريخ البدء وتاريخ النهاية')),
        );
        return;
      }

      if (price == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('الرجاء إدخال السعر')),
        );
        return;
      }

      try {
        await _apiService.addSharingTimeProperty(
            selectedPropertyType!,
            selectedProvince!,
            description,
            features,
            theOwners,
            price!,
            startDate!,
            endDate!,
            images,
            context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم إضافة العقار بنجاح!')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في إضافة العقار')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).addnewreal)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: S.of(context).property_type,
                    prefixIcon: Icon(
                      Icons.home,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: propertyTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPropertyType = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'الرجاء اختيار نوع العقار' : null,
                ),
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: S.of(context).location,
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: provinces.map((String province) {
                    return DropdownMenuItem<String>(
                      value: province,
                      child: Text(province),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedProvince = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'الرجاء اختيار الموقع' : null,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).description,
                    prefixIcon: Icon(
                      Icons.description,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 3,
                  onSaved: (value) {
                    description = value!;
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'الرجاء إدخال وصف للعقار' : null,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).Features,
                    prefixIcon: Icon(
                      Icons.star,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) {
                    features = value!;
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'الرجاء إدخال ميزات العقار' : null,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).Owner_name,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) {
                    theOwners = value!;
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'الرجاء إدخال اسم المالك' : null,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).price,
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Constants.mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    price = double.tryParse(value!);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاء إدخال السعر';
                    } else if (double.tryParse(value) == null) {
                      return 'الرجاء إدخال رقم صالح للسعر';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, true),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: S.of(context).Start_date,
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: Colors.blueAccent,
                            ),
                          ),
                          child: Text(
                            startDate != null
                                ? DateFormat.yMMMd().format(startDate!)
                                : 'اختر تاريخ البدء',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, false),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: S.of(context).end_date,
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: Colors.redAccent,
                            ),
                          ),
                          child: Text(
                            endDate != null
                                ? DateFormat.yMMMd().format(endDate!)
                                : 'اختر تاريخ النهاية',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  label: Text(
                    S.of(context).add_pic,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.mainColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                    textStyle: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: images.map((image) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.file(image, width: 100, height: 100),
                        IconButton(
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              images.remove(image);
                            });
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      S.of(context).sendRequest,
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: 70.0,
                        vertical: 25.0,
                      ),
                      textStyle: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
