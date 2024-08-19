import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pro_2/Presentation/Auctions/api_service_auction.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class AuctionDetailScreen extends StatefulWidget {
  final int auctionId;

  AuctionDetailScreen({required this.auctionId});

  @override
  _AuctionDetailScreenState createState() => _AuctionDetailScreenState();
}

class _AuctionDetailScreenState extends State<AuctionDetailScreen> {
  final ApiServiceAuctions _apiService = ApiServiceAuctions();
  Future<Map<String, dynamic>>? _auctionDetailsFuture;
  Future<List<Map<String, dynamic>>>? _auctionParticipantsFuture;

  @override
  void initState() {
    super.initState();
    _auctionDetailsFuture = _apiService.fetchAuctionDetails(widget.auctionId);
    _auctionParticipantsFuture =
        _apiService.fetchAuctionParticipants(widget.auctionId);
  }

  void _showAddOfferDialog(Map<String, dynamic> auctionDetails) {
    final TextEditingController _priceController = TextEditingController();
    final int minPrice = auctionDetails['first_price'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            S.of(context).Submit_new_offer,
            style: TextStyle(color: Colors.black),
          ),
          content: TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'أدخل السعر',
              hintText: 'يجب أن يكون أعلى من $minPrice \$',
              prefixIcon: Icon(Icons.attach_money),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                final double enteredPrice =
                    double.tryParse(_priceController.text) ?? 0.0;

                if (enteredPrice <= minPrice) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('يجب أن يكون السعر أعلى من $minPrice \$')),
                  );
                } else {
                  try {
                    await _apiService.addParticipate(
                        widget.auctionId, enteredPrice, context);
                    Navigator.of(context).pop();
                    setState(() {
                      _auctionParticipantsFuture = _apiService
                          .fetchAuctionParticipants(widget.auctionId);
                    });
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('فشل في تقديم العرض')),
                    );
                  }
                }
              },
              child: Text('تقديم'),
            ),
          ],
        );
      },
    );
  }

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
      appBar: AppBar(title: Text(S.of(context).Auction_Details)),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _auctionDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('لا توجد بيانات متاحة'));
          } else {
            final auction = snapshot.data!['Property'];
            final images = snapshot.data!['images'];

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      auction['property_type'],
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
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
                            auction['address'],
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.grey[600]),
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
                          auction['description'],
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
                          '${S.of(context).Owner_name}: ${auction['the_owner']}',
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
                          '${S.of(context).Starting_price}: ${auction['first_price']} \$',
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
                        Icon(Icons.date_range, color: Constants.mainColor),
                        SizedBox(width: 8.0),
                        Text(
                          '${S.of(context).Start_date}: ${auction['start']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    images.isNotEmpty
                        ? CarouselSlider(
                            options: CarouselOptions(
                              height: 200.0,
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
                            items: images.map<Widget>((image) {
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
                        : Text('لا توجد صور متاحة',
                            style: TextStyle(color: Colors.redAccent)),
                    SizedBox(height: 20.0),
                    ElevatedButton.icon(
                      onPressed: () => _showAddOfferDialog(auction),
                      icon: Icon(
                        Icons.gavel,
                        color: Colors.white,
                      ),
                      label: Text(
                        S.of(context).Submit_new_offer,
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        textStyle: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Divider(color: Colors.grey[400]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection:
                            Axis.horizontal, // تمكين التمرير الأفقي
                        child: Row(
                          children: [
                            Icon(Icons.account_circle,
                                color: Constants.mainColor),
                            SizedBox(width: 8.0),
                            Text(
                              '${S.of(context).broker}: ${auction['user_name']}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 16.0), // مسافة بين العناصر
                            IconButton(
                              icon:
                                  Icon(Icons.phone, color: Constants.mainColor),
                              onPressed: () {
                                _launchPhoneDialer(auction['number']);
                              },
                            ),
                            Text(
                              auction['number'],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey[400]),
                    Text(
                      '${S.of(context).Auction_participants}:',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _auctionParticipantsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('حدث خطأ أثناء تحميل المشاركين'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                              child: Text('لا يوجد مشاركون في هذا المزاد'));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final participant = snapshot.data![index];
                              return ListTile(
                                leading: Icon(Icons.person, color: Colors.blue),
                                title: Text(participant['user_name']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'المزايدة: ${participant['price']} \$'),
                                    Text(
                                        'التاريخ: ${participant['participated_at']}'),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
