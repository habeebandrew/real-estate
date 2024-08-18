import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:pro_2/tests/ApiService.dart'; // تأكد من المسار الصحيح

class s_3dpic extends StatefulWidget {
  final int propertyId;

  s_3dpic({required this.propertyId});

  @override
  State<s_3dpic> createState() => _s_3dpicState();
}

class _s_3dpicState extends State<s_3dpic> {
  late Future<List<String?>> imagesFuture;

  @override
  void initState() {
    super.initState();
    imagesFuture = ApiService().fetch360Images(widget.propertyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عرض صورة 360 درجة+${widget.propertyId}'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<String?>>(
          future: imagesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('فشل في تحميل الصور: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('لا توجد صور 360 درجة.'));
            } else {
              final images = snapshot.data!;
              // فلترة الصور للتأكد من عدم وجود صور فارغة أو غير صالحة
              final filteredImages = images.where((img) => img != null && img!.isNotEmpty).toList();

              if (filteredImages.isEmpty) {
                return Center(child: Text('لا توجد صور 360 درجة صالحة.'));
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: filteredImages.length,
                itemBuilder: (context, index) {
                  final imageUrl = filteredImages[index]!;
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: PanoramaViewer(
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) {
                                    return child;
                                  } else {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(child: Text('خطأ في تحميل الصورة'));
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) {
                          return child;
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Icon(Icons.error, color: Colors.red));
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}