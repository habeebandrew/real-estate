import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;



// intl: ^0.17.0  # تأكد من إضافة هذه المكتبة

class theList extends StatefulWidget {
  @override
  _SaintsListState createState() => _SaintsListState();
}

class _SaintsListState extends State<theList> {
  List _s = [];

  @override
  void initState() {
    super.initState();
    _loadSaintsData();
  }

  Future<void> _loadSaintsData() async {
    String data = await rootBundle.loadString('*******.json');
    setState(() {
      _s = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Birthdays'),
      ),
      body: _s.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _s.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_s[index]['name']),
            subtitle: Text('Birthday: ${_s[index]['birthday']}'),
          );
        },
      ),
    );
  }
}
