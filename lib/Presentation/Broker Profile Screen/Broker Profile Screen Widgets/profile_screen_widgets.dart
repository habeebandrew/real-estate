
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ContactInformation extends StatefulWidget {
  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  var rate = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Rate:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              RatingBar.builder(
                initialRating: rate,
                maxRating: 5,
                minRating: 0,
                allowHalfRating: false,
                onRatingUpdate: (rating){
                  setState(() {
                    rate=rating;
                  });
                },
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemSize: 20.0,
                direction: Axis.horizontal,
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
      ),
    );
  }
}
