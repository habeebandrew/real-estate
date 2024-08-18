import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Presentation/Advanced%20Search%20Screen/show_search_result_screen.dart';
import 'package:pro_2/Util/api_endpoints.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/animation.dart';
import 'package:http/http.dart' as http;

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {

  bool isSale=true;

  final Map<String, int> cityIds = {
    'all Cities': 0,
    'Damascus': 1,
    'Rif-Damascus': 2,
    'Homs': 3,
    'Aleppo': 4,
    'Hama': 5,
    'Lattakia': 6,
    'Tartus': 7,
    'Idlib': 8,
    'Al-Hasakah': 9,
    'Deir ez-Zor': 10,
    'Raqqa': 11,
    'Daraa': 12,
    'As-Suwayda': 13,
    'Quneitra': 14,
  };

  final Map<String, int> propertyTypeIds = {
    'All Property type': 0,
    'house': 1,
    'office': 2,
    'villa': 3,
    'farm': 4,
    'market': 5,
    'land': 6,
    'building': 7,
    'chalet': 8,
  };

  String? selectedCity ='';
  String  selectedAddress='';
  int selectedAdressId =-1;
  List<Map<String, dynamic>> addresses = [];

    
  bool isLoadingCities = false;
   Future<void> fetchCities(String province) async {
      final Map<String, int> provinceIds = {
        'Damascus': 1,
        'Rif-Damascus': 2,
        'Homs': 3,
        'Aleppo': 4,
        'Hama': 5,
        'Lattakia': 6,
        'Tartus': 7,
        'Idlib': 8,
        'Al-Hasakah': 9,
        'Deir ez-Zor': 10,
        'Raqqa': 11,
        'Daraa': 12,
        'As-Suwayda': 13,
        'Quneitra': 14,
      };
     String token = (await CacheHelper.getString(key: 'token'))!;
    String api = await ApiAndEndpoints.api;

    final int provinceId = provinceIds[province]!;
    final response = await http.get(
      Uri.parse(api + ApiAndEndpoints.fetchAllAddresses + '$provinceId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        addresses = data.map((address) {
          return {
            'id_address': address['id_address'],
            'address': address['address']
          };
        }).toList();
        isLoadingCities = false;
      });
    } else {
      throw Exception('Failed to load addresses');
    }
    }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyCubit(),
      child: BlocConsumer<PropertyCubit, PropertyState>(
        listener: (context, state) {
         
        },
        builder: (context, state) {
          PropertyCubit cubit = PropertyCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Constants.mainColor,
              automaticallyImplyLeading: false,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       const Text(
                         'Search options',
                         style: TextStyle(
                           fontSize: 24,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       IconButton(
                         onPressed: (){
                           Navigator.pop(context);
                         }, 
                         icon: const Icon(
                           Icons.cancel
                         )
                       )
                     ],
                   ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Constants.mainColor3,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: cityIds.keys.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              
                              cubit.dropDownItemCites2=value!;
                              selectedAddress =
                                  ''; // لإعادة تعيين المدينة عند تغيير المحافظة
                              selectedAdressId = -1;
                              isLoadingCities = true;
                            });
                            fetchCities(value!);
                          },
                          value: cubit.dropDownItemCites2.isEmpty ? null :cubit.dropDownItemCites2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        // TODO habbeb do your magic
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Constants.mainColor3,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items:  addresses.map((address) {
                                  return DropdownMenuItem<String>(
                                    value: address['address'],
                                    child: Text(address['address']),
                                    onTap: (){
                                     selectedAdressId= address['id_address'];
                                    },
                                  );
                                }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedAddress = value!;
                            });
                          },
                          value: selectedAddress.isEmpty ? null : selectedAddress,
                        ),
                      
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              isSale=true;
                            });
                            
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: isSale?Constants.mainColor3:Colors.white,
                          ),
                          child: const Text(
                            'For sale',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                               isSale=false;
                            });
                           
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: isSale==false?Constants.mainColor3:Colors.white,
                          ),
                          child: const Text(
                            'For rent',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Property Type',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Constants.mainColor3,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items:  propertyTypeIds.keys.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        cubit.dropDownItemPropertyType=value!;
                      });
                    },
                    value: cubit.dropDownItemPropertyType,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cubit.minPrice,
                          decoration: InputDecoration(
                            labelText: 'From',
                            hintText: '26,000,000',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: cubit.maxPrice,
                          decoration: InputDecoration(
                            labelText: 'To',
                            hintText: '150,000,000,000',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Area (m²)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cubit.minSize,
                          decoration: InputDecoration(
                            labelText: 'From',
                            hintText: '1',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: cubit.maxSize,
                          decoration: InputDecoration(
                            labelText: 'To',
                            hintText: '800,000',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: cubit.loading==true
                    ?const CircularProgressIndicator() 
                    :ElevatedButton(
                      onPressed: () async{
                       
                          int? statusId = isSale ? 1 : 2;

                          int? propertyTypeId = propertyTypeIds[cubit.dropDownItemPropertyType] != 0
                              ? propertyTypeIds[cubit.dropDownItemPropertyType]
                              : null;

                          int? cityId = cityIds[cubit.dropDownItemCites2] != 0
                              ? cityIds[cubit.dropDownItemCites2]
                              : null;

                          
                          int? addressId = selectedAdressId==-1  ? null:selectedAdressId;
                            
                            print('addressId   ' + addressId.toString());

                        //   await cubit.advancedSearch(
                        //     statusId: statusId,
                        //     propertyTypeId: propertyTypeId,
                        //     cityId: cityId,
                        //     addressId: addressId,
                        //     minPrice: cubit.minPrice.text.isNotEmpty?cubit.minPrice.text:null,
                        //     maxPrice: cubit.maxPrice.text.isNotEmpty?cubit.maxPrice.text:null,
                        //     minSize: cubit.minSize.text.isNotEmpty?cubit.minSize.text:null,
                        //     maxSize: cubit.maxSize.text.isNotEmpty?cubit.maxSize.text:null,
                        //   );
                        // if(cubit.loading==false){
                        //   Navigator.push(context, MyAnimation.createRoute(ShowSearchResultScreen(propertyList: cubit.properties)));
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Constants.mainColor,
                      ),
                      child: const Text(
                        'Show Result',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
