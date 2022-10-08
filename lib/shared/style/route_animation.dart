
import 'package:flutter/material.dart';

class SlidAnimation extends PageRouteBuilder{
  final page;
  final Alignment alignment;
  SlidAnimation({required this.page,required this.alignment}) : super(
      pageBuilder: (context,animation,animationTwo)=>page,
      transitionsBuilder: (context,animation,animationTwo,child){
        var begin = 1000.0;
        var end = 1.0;
        var tween = Tween(begin: begin,end: end);
        var curve =CurvedAnimation(
            parent: animation,
            curve: Curves. fastLinearToSlowEaseIn
        );
        return Align(
          alignment: alignment,
          child: SizeTransition(
            sizeFactor:animation,child: RotationTransition(
            turns: tween.animate(curve),
            child: child,
          ),),
        );

      }
  );
}