

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Presentation/Home%20Screen/home_screen.dart';
import 'package:pro_2/Util/constants.dart';

import '../../Util/dimensions.dart';
class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1,milliseconds: 50),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/General/App_Icon.png",
            width: Dimensions.widthPercentage(context, 75),
            height: Dimensions.heightPercentage(context, 75),
          ),
          SizedBox(height: 20),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constants.mainColor,
                        fontSize: 30.h,
                      ),
                      children: [
                        WidgetSpan(
                          child: Transform.translate(
                            offset: Offset(0, -20 * _animation.value),
                            child: Text(
                              'C',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Constants.mainColor,
                                fontSize: 30.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextSpan(
                      text: 'apital',
                      style: TextStyle(
                        color: Constants.mainColor,
                        fontSize: 26.h,
                      ),
                    ),
                    WidgetSpan(
                      child: Transform.translate(
                        offset: Offset(0, -20 * _animation.value),
                        child: Text(
                          ' E',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Constants.mainColor,
                            fontSize: 30.h,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'states',
                      style: TextStyle(
                        color: Constants.mainColor,
                        fontSize: 26.h,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 40),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final progress = (_controller.value * 4).clamp(index.toDouble(), (index + 1).toDouble());
                  final isFilled = progress > index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: isFilled ? Constants.mainColor : Colors.grey,
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}