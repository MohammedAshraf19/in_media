import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_media/layout/socia_layout.dart';
import 'package:in_media/modules/on_boarding_screen/on_boarding_screen.dart';
import 'package:in_media/shared/components/constants.dart';
import 'package:in_media/shared/style/colors_manager.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  var _timer;
  _startDelay(){

    _timer = Timer(
        const Duration(seconds: 8),
        _goNext
    );
  }
  _goNext(){
    if(uId == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const OnBoardingScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SocialLayout()));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.primary,
          statusBarBrightness: Brightness.dark
        ),
      ),
      backgroundColor: ColorManager.primary,
      body: Center(
          child: Lottie.asset('assets/animations/splash_logo.json')
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel;
    super.dispose();
  }
}
