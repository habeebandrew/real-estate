import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Auctions/Add_Auction_screen.dart';
import 'package:pro_2/Presentation/Auctions/auction_detail_screen.dart';
import 'package:pro_2/Util/constants.dart';
import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/animation.dart';
import '../../generated/l10n.dart';
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
  void _handleFloatingActionButton(BuildContext context) {
    int? role_id = CacheHelper.getInt(key: 'role_id');
    if (role_id == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              S.of(context).alert,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            content: Text(S.of(context).Please_log_in),
            actions: <Widget>[
              TextButton(
                child: Text(
                  S.of(context).Log_In,
                  style: TextStyle(
                      color: Constants.mainColor, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MyAnimation.createRoute(AppRoutes.logInScreen));
                },
              ),
            ],
          );
        },
      );
    } else if (role_id == 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              S.of(context).Add,
              style: TextStyle(
                  color: Constants.mainColor, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Text(
                              S.of(context).alert,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            content: Text(S.of(context).Please_subscription),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  S.of(context).Subscription,
                                  style: TextStyle(
                                      color: Constants.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                      MyAnimation.createRoute(
                                          AppRoutes.subscription));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.info, color: Constants.mainColor),
                      title: Text(S.of(context).AddAuctions),
                    ),
                  ),

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  S.of(context).close,
                  style: TextStyle(color: Constants.mainColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (role_id == 2) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              S.of(context).Add,
              style: TextStyle(
                  color: Constants.mainColor, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MyAnimation.createRoute(AppRoutes.addauctions));
                    },
                    child: ListTile(
                      leading: Icon(Icons.info, color: Constants.mainColor),
                      title: Text(S.of(context).AddAuctions),
                    ),
                  ),

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  S.of(context).close,
                  style: TextStyle(color: Constants.mainColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {_handleFloatingActionButton(context);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => AddAuctions()),
          // );
        },
        child: Icon(Icons.add_circle_sharp, color: Colors.white),
        backgroundColor: Constants.mainColor,
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
                        builder: (context) =>
                            AuctionDetailScreen(auctionId: auction['id']),
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
                  color: Constants.mainColor,
                ),
                SizedBox(width: 8.0),
                Text(
                  auction['propertyType'],
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
                  color: Constants.mainColor,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    auction['address'],
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Constants.mainColor,
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
                  color: Constants.mainColor,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    auction['description'],
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
                  color: Constants.mainColor,
                ),
                SizedBox(width: 8.0),
                Text(
                  'المالك:  ${auction['the_owner']}',
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
                  'السعر الابتدائي: ${auction['first_price']} ',
                  // textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            auction['Images'].isNotEmpty
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
                    items: auction['Images'].map<Widget>((image) {
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
          ],
        ),
      ),
    );
  }
}
