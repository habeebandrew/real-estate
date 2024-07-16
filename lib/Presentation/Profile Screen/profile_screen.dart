import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pro_2/Util/constants.dart';


class ProfileScreen extends StatelessWidget {
  late int id;
  ProfileScreen({super.key,required id});
  int rate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brokers'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            const SizedBox(height: 16),
            ContactInformation(),
            // const SizedBox(height: 16),
            // LocationOnMap(),
            // const SizedBox(height: 16),
            // SupportedRegions(),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Constants.mainColor,
                    image: DecorationImage(
                      image: AssetImage('assets/car_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/alkhair_logo.png'),
                ),
                SizedBox(width: 16),
                Text(
                  'Mohammad Khair Alsarayji',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ],
              ),
                const SizedBox(height: 8),
                
          ],
        ),
          
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('Ads'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Constants.mainColor,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Profile Information'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Constants.mainColor,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ContactInformation extends StatefulWidget {
  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  var rate= 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Rate:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: (){
                setState(() {
                    rate++;
                });
                
                  
              },
              child: RatingBarIndicator(
                rating: rate,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
                 
              ),
            ),
          ],
        ),
      
        const SizedBox(height: 8),
        const Row(
          children: [
            Text(
              'Contact Information:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.email),
            SizedBox(width: 8),
            Text('mohammadkhairanasalsarayji@gmail.com'),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 8),
            Text('Damascus - Damascus'),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.phone),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('محمد خير السرايجي +963-9668876'),
                Text('محمد خير السرايجي +963-9336506'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// class LocationOnMap extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Location On Map:',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           height: 150,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.grey),
//           ),
//           child: Image.asset(
//             'assets/map_image.png',
//             fit: BoxFit.cover,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class SupportedRegions extends StatelessWidget {
//   final List<String> regions = [
//     'Al-Maliki',
//     'Kafr Sousa',
//     'Abu Rummaneh',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Supported regions:',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8.0,
//           runSpacing: 4.0,
//           children: regions.map((region) => Chip(label: Text(region))).toList(),
//         ),
//       ],
//     );
//   }
// }
