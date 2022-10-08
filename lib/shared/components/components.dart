
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/colors_manager.dart';
import '../style/fonts_manager.dart';
import '../style/style_manager.dart';

Widget textFormFiled({
  required textController,
  required String hintText,
  required Icon perfixIcon,
   IconButton? suffixIcon,
  required ValidationText,
  required TextInputType type,
  bool secure = false,
}){
  return  TextFormField(
    controller: textController,
    validator: (String? value){
      if(value!.isEmpty)
        return '$ValidationText Must Not Be Null';
      else
        return null;
    },
    obscureText: secure,
    keyboardType: type,
    decoration: InputDecoration(
      prefixIcon: perfixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle:getSemiBoldStyle(color: ColorManager.grey.withOpacity(0.3),fontSize: FontSize.s16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      filled: true,
      fillColor: ColorManager.lightGrey.withOpacity(0.1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    ),
  );
}

Widget textButton({
  required String text,
  required Color textColor,
  required Color buttonColor,
  required Color buttonShadow,
  required Function onPressed,
}){
  return InkWell(
    onTap: onPressed(),
    child: Container(
      height: 40,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: buttonShadow.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child:   Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color:textColor,
          ),
        ),
      ),
    ),
  );
}

void showToast({required String txt, required ToastState state}) {
  Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, ERROR }
late Color color;
Color chooseToastColor(ToastState state) {
  switch (state) {
    case ToastState.SUCCESS:
      color = ColorManager.lightPrimary;
      break;
    case ToastState.ERROR:
      color = ColorManager.error;
      break;
  }
  return color;
}

Widget circularIndicator({
  required Color color,
}){
  return CircularProgressIndicator(
    backgroundColor: color,
    color: ColorManager.white,
    strokeWidth: 2,

  );
}
