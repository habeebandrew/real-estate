import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Auctions/api_service_auction.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
    return Scaffold(
      appBar: AppBar(title: Text('إضافة مزاد جديد')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'نوع العقار'),
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
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'العنوان'),
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'الوصف'),
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  validator: (value) =>
                  value!.isEmpty ? 'يرجى إدخال الوصف' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'الميزات'),
                  onChanged: (value) {
                    setState(() {
                      features = value;
                    });
                  },
                  validator: (value) =>
                  value!.isEmpty ? 'يرجى إدخال الميزات' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'اسم المالك'),
                  onChanged: (value) {
                    setState(() {
                      theOwner = value;
                    });
                  },
                  validator: (value) =>
                  value!.isEmpty ? 'يرجى إدخال اسم المالك' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'سعر البداية'),
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
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('إضافة صورة'),
                ),
                SizedBox(height: 10),
                _buildImagePreviewList(),
                SizedBox(height: 20),
                ElevatedButton(
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
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text('تم إضافة المزاد بنجاح!'),
                      // ));
                    }
                  },
                  child: Text('إضافة المزاد'),
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
      itemCount: images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Image.file(images[index], fit: BoxFit.cover),
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeImage(index),
              ),
            ),
          ],
        );
      },
    );
  }
}
