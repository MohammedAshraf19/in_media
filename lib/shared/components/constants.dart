import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_media/modules/login_screen/login_screen.dart';

import '../network/local/cache_helper.dart';
import '../style/route_animation.dart';

String? uId ='';
class AppConstant{
  static const rightAlignment = Alignment.centerRight;
  static const leftAlignment = Alignment.centerLeft;
  static const topAlignment = Alignment.topCenter;

}
void SignOut(context){
  CacheHelper.removeData(key: 'uId').then((value) {
    if(value){
      Navigator.pushReplacement(context, SlidAnimation(
          page:  LoginScreen(), alignment: AppConstant.topAlignment),);
    }
  });
}

