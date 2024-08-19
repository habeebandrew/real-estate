import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Auctions/api_service_auction.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/generated/l10n.dart';

class AddAuctions extends StatefulWidget {
  @override
  State<AddAuctions> createState() => _AddAuctionsState();
}

class _AddAuctionsState extends State<AddAuctions> {
  final _formKey = GlobalKey<FormState>();
  final ApiServiceAuctions _apiService = ApiServiceAuctions();

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
  String? selectedAddress;
  String description = '';
  String features = '';
  String theOwner = '';
  double? firstPrice;
  List<File> images = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).AddAuctions),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: S.of(context).property_type,
                    prefixIcon: Icon(
                      Icons.home,
                      color: Constants.mainColor,
                    ), // أيقونة إضافية هنا
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
                      value == null ? 'يرجى اختيار نوع العقار' : null,
                ),
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: S.of(context).location,
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Constants.mainColor,
                    ), // أيقونة إضافية هنا
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
                      selectedAddress = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'يرجى اختيار العنوان' : null,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).description,
                    prefixIcon: Icon(
                      Icons.description,
                      color: Constants.mainColor,
                    ), // أيقونة إضافية هنا
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال الوصف' : null,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).Features,
                    prefixIcon: Icon(
                      Icons.star,
                      color: Constants.mainColor,
                    ), // أيقونة إضافية هنا
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      features = value;
                    });
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال الميزات' : null,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).Owner_name,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Constants.mainColor,
                    ), // أيقونة إضافية هنا
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      theOwner = value;
                    });
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال اسم المالك' : null,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).Starting_price,
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Constants.mainColor,
                    ), // أيقونة إضافية هنا
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      firstPrice = double.tryParse(value);
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجى إدخال السعر';
                    } else if (double.tryParse(value) == null) {
                      return 'يرجى إدخال رقم صحيح';
                    }
                    return null;
                  },
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
                _buildImagePreviewList(),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _apiService.addAuction(
                        context: context,
                        propertyType: selectedPropertyType!,
                        address: selectedAddress!,
                        description: description,
                        features: features,
                        theOwner: theOwner,
                        firstPrice: firstPrice!,
                        images: images,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: Text(
                    S.of(context).AddAuctions,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreviewList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.file(images[index], fit: BoxFit.cover),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => _removeImage(index),
              ),
            ),
          ],
        );
      },
    );
  }
}
