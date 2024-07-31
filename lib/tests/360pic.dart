import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class s_3dpic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عرض صورة 360 درجة'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PanoramaViewer(
            child: Image.asset('assets/images/360/shot-panoramic-composition-bedroom.jpg'),
          ),
        ),
      ),
    );
  }
}