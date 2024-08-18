import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pro_2/Presentation/sharingtime/AddProperty_sharing_Screen.dart';
import '../../Util/constants.dart';
import 'apiservice_sharing.dart';
import 'property_sharing_detail_screen.dart';

class show_sharing extends StatefulWidget {
  const show_sharing({super.key});

  @override
  State<show_sharing> createState() => _show_sharingState();
}

class _show_sharingState extends State<show_sharing> {
  late Future<List<Property_sharing>> futureProperties;

  @override
  void initState() {
    super.initState();
    futureProperties = ApiService_sharing().fetchProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Add_sharing_Screen()),
        );
      },
      child: Icon(Icons.add_circle_sharp, color: Colors.white),
      backgroundColor: Constants.mainColor,
    ),
      appBar: AppBar(
        title: Text('Real Estate Listings'),
      ),
      body: FutureBuilder<List<Property_sharing>>(
        future: futureProperties,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No properties found.'));
          } else {
            List<Property_sharing> properties = snapshot.data!;
            return ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Property_sharing_DetailScreen(propertyId: properties[index].id),
                      ),
                    );
                  },
                  child: _buildPropertyCard(properties[index]),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildPropertyCard(Property_sharing property) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.home,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 8.0),
                Text(
                  property.propertyType.isNotEmpty ? property.propertyType : 'Unknown Property Type',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    property.address.isNotEmpty ? property.address : 'Unknown Address',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(
                  Icons.description,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    property.description.isNotEmpty ? property.description : 'No Description Available',
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Owners: ${property.owners.isNotEmpty ? property.owners : 'Unknown'}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: Colors.redAccent,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Price: \$${property.price}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            property.images.isNotEmpty
                ? CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: property.images.map<Widget>((image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            )
                : Text('No images available',
                style: TextStyle(color: Colors.redAccent)),
          ],
        ),
      ),
    );
  }

}
