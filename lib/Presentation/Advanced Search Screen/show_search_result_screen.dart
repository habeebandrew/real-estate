import 'package:flutter/material.dart';
import 'package:pro_2/Data/property_model.dart';
import 'package:pro_2/Presentation/Properties%20Screen/Properties%20Widgets/properties_widgets.dart';
import 'package:pro_2/Presentation/Property%20Details%20Screen/property_details_screen.dart';
import 'package:pro_2/Util/global%20Widgets/animation.dart';

class ShowSearchResultScreen extends StatelessWidget {
  final List<Property> propertyList;
  const ShowSearchResultScreen({super.key, required this.propertyList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Result"),
        leading: IconButton(
          onPressed:(){
            
              
               Navigator.pop(context);
            
            
            
          } ,
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
          itemCount: propertyList.length,
          itemBuilder: (context, index) {
            final property = propertyList[index];
            return GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MyAnimation.createRoute(PropertyDetailsScreen(
                      propertyId: property.id,
                      favourite: property.existingFavorite,
                    )));
                // final updatedFavourite = await Navigator.push<bool>(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PropertyDetailsScreen(
                //       propertyId: property.id,
                //       favourite: property.existingFavorite,
                //     ),
                //   ),
                // );

                // // Handle the result here, updating the state if necessary
                // if (updatedFavourite != null && updatedFavourite != property.existingFavorite) {
                //   setState(() {
                //     property.existingFavorite = updatedFavourite;
                //   });
                // }
              },
              child: PropertyCard(
                id: property.id,
                propertyType: property.propertyType,
                status: property.status,
                size: property.size,
                price: property.price,
                address: property.address,
                governorate: property.governorate,
                viewers: property.viewers,
                inFavourite: property.existingFavorite,
                createdAt:
                    '${property.createdAt.substring(0, 10)} - ${property.createdAt.substring(11, 16)}',
                images: property.images,
              ),
            );
          }),
    );
  }
}
