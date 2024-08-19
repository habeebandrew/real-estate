import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../generated/l10n.dart';
import 'apiservice_sharing.dart';

class Property_sharing_DetailScreen extends StatelessWidget {
  final int propertyId;

  Property_sharing_DetailScreen({required this.propertyId});

  Future<void> _launchPhoneDialer(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).property_Detail),
      ),
      body: FutureBuilder<Property_sharing>(
        future: ApiService_sharing().fetchPropertyDetails(propertyId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('تفاصيل العقار غير متاحة.'));
          } else {
            Property_sharing property = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  property.images.isNotEmpty
                      ? CarouselSlider(
                          options: CarouselOptions(
                            height: 300.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
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
                      : Container(
                          height: 300.0,
                          color: Colors.grey[200],
                          child: Center(
                            child: Text(
                              'لا توجد صور مضافة',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        property.propertyType,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Constants.mainColor,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          property.address,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600],
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
                        Icons.star,
                        color: Constants.mainColor,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        property.description,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Constants.mainColor,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '${S.of(context).Owner_name}: ${property.owners}',
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
                      Icon(Icons.attach_money, color: Colors.redAccent),
                      SizedBox(width: 8.0),
                      Text(
                        '${S.of(context).price}: ${property.price} \$',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.date_range, color: Colors.blueAccent),
                      SizedBox(width: 8.0),
                      Text(
                        '${S.of(context).Start_date}: ${property.createdAt}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.date_range, color: Colors.red),
                      SizedBox(width: 8.0),
                      Text(
                        '${S.of(context).end_date}: ${property.end}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.account_circle, color: Constants.mainColor),
                        SizedBox(width: 8.0),
                        Text(
                          '${S.of(context).broker}: ${property.user_name}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.phone, color: Constants.mainColor),
                          onPressed: () {
                            _launchPhoneDialer(property.number);
                          },
                        ),
                        Text(
                          property.number,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
