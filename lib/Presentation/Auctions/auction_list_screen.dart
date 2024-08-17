import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Auctions/Add_Auction_screen.dart';
import 'package:pro_2/Presentation/Auctions/auction_detail_screen.dart';

import 'api_service_auction.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AuctionListScreen extends StatefulWidget {
  @override
  _AuctionListScreenState createState() => _AuctionListScreenState();
}

class _AuctionListScreenState extends State<AuctionListScreen> {
  final ApiServiceAuctions _apiService = ApiServiceAuctions();

  Future<List<Map<String, dynamic>>>? _auctionsFuture;

  @override
  void initState() {
    super.initState();
    _auctionsFuture = _apiService.fetchAuctions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddAuctions()),
        );
      },
      child: Icon(Icons.add_box_outlined),
    ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _auctionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('لا يوجد مزادات حاليًا'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final auction = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuctionDetailScreen(auctionId: auction['id']),
                      ),
                    );
                  },
                  child: _buildAuctionCard(auction),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildAuctionCard(Map<String, dynamic> auction) {
    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              auction['propertyType'],
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text(
              auction['address'],
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            ),
            SizedBox(height: 10.0),
            Text(
              auction['description'],
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'المالك: ${auction['the_owner']}',
              style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10.0),
            Text(
              'السعر الابتدائي: ${auction['first_price']} \$',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            auction['Images'].isNotEmpty
                ? CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                autoPlay: true,
              ),
              items: auction['Images'].map<Widget>((image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            )
                : Text('لا توجد صور متاحة'),
          ],
        ),
      ),
    );
  }
}