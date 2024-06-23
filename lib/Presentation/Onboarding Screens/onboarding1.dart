import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Onboarding Screens/onBoarding%20Widgets/onboadring_widgets.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {

  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Onboarding> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildpage(
                subtitle:
                    "سواء كنت مستثمرًا يبحث عن فرص استثمارية أو شخصًا يرغب في تأجير عقاره، فإن تطبيقنا يوفر لك تجربة مريحة ومبسطة."
                    "\n"
                    'اكتشف عالم العقارات معنا واحصل على فرصة لتحقيق أحلامك السكنية!” 🏡',
                title: 'استثمر!!',
                urlImage: 'assets/images/Onboarding/Onboarding_1.png'),
            buildpage(
                subtitle:
                    'ابحث عن منازل أحلامك للبيع أو الإيجار، واستمتع بتصفح مجموعة واسعة من الشقق الفاخرة، الفلل الرائعة، والأراضي المثالية.',
                title: 'اختر منزل أحلامك!',
                urlImage: 'assets/images/Onboarding/Onboarding_2.png'),
            buildpage(
                subtitle: 'ستجد لدينا أحدث العروض وأفضل الصفقات.',
                title: 'Real Estate',
                urlImage: 'assets/images/Onboarding/onboarding_3.png'),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? ElevatedButton(
              // استخدام ElevatedButton لزيادة التباين وسهولة الاستخدام
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size.fromHeight(60),
              ),
              onPressed: ()  {
                CacheHelper.putData(key: "showHome",value:  true).then((onValue){
                  Navigator.pushNamed(context, NamedRoutes.logInScreen);
                });

              },
              child:  Text(
                'Get Started',
                style: TextStyle(fontSize: 28, color: Constants.mainColor),
              ),
            )
          : Container(
              color: Colors.white,
              child: Row(
                // Row لعرض أزرار التنقل والمؤشرات في أسفل الشاشة
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => controller.jumpToPage(2),
                    child:  Text(
                      'SKIP',
                      style: TextStyle(color: Constants.mainColor, fontSize: 20),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const WormEffect(
                      spacing: 16,
                      dotColor: Colors.black26,
                      activeDotColor: Color(0XffFCCE5E),
                    ),
                    onDotClicked: (index) => controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    child:  Text(
                      'NEXT',
                      style: TextStyle(color: Constants.mainColor, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}


