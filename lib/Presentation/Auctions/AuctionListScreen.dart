import 'package:flutter/material.dart';

class AuctionListScreen extends StatelessWidget {
  final List<AuctionItem> auctionItems;

  AuctionListScreen({required this.auctionItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة المزادات'),
      ),
      body: ListView.builder(
        itemCount: auctionItems.length,
        itemBuilder: (context, index) {
          final item = auctionItems[index];
          return ListTile(
            title: Text(item.userName),
            subtitle: Text('السعر: ${item.price}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAuctionScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'إضافة مزاد',
      ),
    );
  }
}

class AuctionItem {
  final String userName;
  final double price;

  AuctionItem({required this.userName, required this.price});
}

class AddAuctionScreen extends StatefulWidget {
  @override
  _AddAuctionScreenState createState() => _AddAuctionScreenState();
}

class _AddAuctionScreenState extends State<AddAuctionScreen> {
  final _phoneController = TextEditingController();
  final _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final double minimumBid = 100.0; // الحد الأدنى للمزايدة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة مزاد جديد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'رقم الهاتف'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال رقم الهاتف';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'السعر'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال السعر';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price < minimumBid) {
                    return 'يجب أن يكون السعر أعلى من $minimumBid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // هنا يمكنك إضافة الكود لإرسال البيانات إلى قاعدة البيانات أو إجراء أي عملية أخرى.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم إضافة المزاد بنجاح')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('إضافة مزاد'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
