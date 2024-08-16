import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Presentation/Advanced%20Search%20Screen/show_search_result_screen.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/animation.dart';

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
                              cubit.dropDownItemCites=value!;
                            });
                          },
                          value:  cubit.dropDownItemCites,
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
                          items: const [
                            DropdownMenuItem(
                              value: 'All Address',
                              child: Text('All Address'),
                            ),
                          ],
                          onChanged: (value) {},
                          value: 'All Address',
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

                          int? cityId = cityIds[cubit.dropDownItemCites] != 0
                              ? cityIds[cubit.dropDownItemCites]
                              : null;

                          // TODO habbeb do your magic
                          int? addressId;
                            
                          await cubit.advancedSearch(
                            statusId: statusId,
                            propertyTypeId: propertyTypeId,
                            cityId: cityId,
                            addressId: addressId,
                            minPrice: cubit.minPrice.text.isNotEmpty?cubit.minPrice.text:null,
                            maxPrice: cubit.maxPrice.text.isNotEmpty?cubit.maxPrice.text:null,
                            minSize: cubit.minSize.text.isNotEmpty?cubit.minSize.text:null,
                            maxSize: cubit.maxSize.text.isNotEmpty?cubit.maxSize.text:null,
                          );
                        if(cubit.loading==false){
                          Navigator.push(context, MyAnimation.createRoute(ShowSearchResultScreen(propertyList: cubit.properties)));
                        }
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
