import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pro_2/Presentation/Auctions/api_service_auction.dart';

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
    _auctionParticipantsFuture = _apiService.fetchAuctionParticipants(widget.auctionId);
  }

  void _showAddOfferDialog(Map<String, dynamic> auctionDetails) {
    final TextEditingController _priceController = TextEditingController();
    final int minPrice = auctionDetails['first_price'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تقديم عرض جديد'),
          content: TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'أدخل السعر',
              hintText: 'يجب أن يكون أعلى من $minPrice \$',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () async {
                final double enteredPrice = double.tryParse(_priceController.text) ?? 0.0;

                if (enteredPrice <= minPrice) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('يجب أن يكون السعر أعلى من $minPrice \$')),
                  );
                } else {
                  try {
                    await _apiService.addParticipate(widget.auctionId, enteredPrice, context);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('تم تقديم العرض بنجاح')),
                    // );
                    Navigator.of(context).pop();
                    setState(() {
                      _auctionParticipantsFuture = _apiService.fetchAuctionParticipants(widget.auctionId);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تفاصيل المزاد')),
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
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      auction['address'],
                      style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
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
                    Text(
                      'تاريخ البدء: ${auction['start']}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'تاريخ النهاية: ${auction['end'] ?? 'غير محدد'}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 20.0),
                    images.isNotEmpty
                        ? CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                      ),
                      items: images.map<Widget>((image) {
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
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () => _showAddOfferDialog(auction),
                      child: Text('تقديم عرض جديد'),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'المشاركون في المزاد:',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _auctionParticipantsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('حدث خطأ أثناء تحميل المشاركين'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('لا يوجد مشاركون في هذا المزاد'));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final participant = snapshot.data![index];
                              return ListTile(
                                leading: Icon(Icons.person),
                                title: Text(participant['user_name']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('المزايدة: ${participant['price']} \$'),
                                    Text('التاريخ: ${participant['participated_at']}'),
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