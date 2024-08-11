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
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    imagesFuture = ApiService().fetch360Images(widget.propertyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عرض صورة 360 درجة'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<String?>>(
          future: imagesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('خطأ في تحميل الصور'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('لا توجد صور 360 درجة'));
            } else {
              final images = snapshot.data!;
              final filteredImages = images.where((img) => img != null && img.isNotEmpty).toList();
              return Stack(
                children: [
                  Positioned.fill(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: filteredImages.length,
                      itemBuilder: (context, index) {
                        final imageUrl = filteredImages[index];
                        return PanoramaViewer(
                          child: Image.network(
                            imageUrl!,
                            fit: BoxFit.cover, // هذا يضمن أن الصورة تغطي المساحة بشكل مناسب
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
