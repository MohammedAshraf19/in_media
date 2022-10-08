import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_media/shared/style/colors_manager.dart';
import 'package:in_media/shared/style/style_manager.dart';
import 'package:in_media/shared/style/values_manager.dart';

import 'fonts_manager.dart';

ThemeData getAppTheme(){
  return ThemeData(
    // main color
    scaffoldBackgroundColor: ColorManager.white,
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.lightPrimary,
      // card theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4,
      ),

      // appBar Theme
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: ColorManager.white
        ),
        color: ColorManager.white,
        elevation: AppSize.s3,
        shadowColor: ColorManager.lightPrimary,
        centerTitle: true,
        titleTextStyle: getRegularStyle(
            color: ColorManager.white,
            fontSize: FontSize.s16
        ),
        iconTheme: IconThemeData(
          color: ColorManager.white,
        ),

      ),
      // button theme
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        splashColor: ColorManager.lightPrimary,
        buttonColor: ColorManager.primary,
        disabledColor: ColorManager.grey1,
      ),

      // ElevatedButtonTheme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.white,fontSize:FontSize.s17),
          primary: ColorManager.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12)
          ),
        ),
      ),
      // text theme
      textTheme: TextTheme(

        displayLarge: getBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s30),
        displayMedium: getBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s22),
        headlineLarge: getSemiBoldStyle(color: ColorManager.darkPrimary,fontSize: FontSize.s16),
        titleMedium: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),
        bodyLarge: getRegularStyle(color: ColorManager.grey1),
        bodySmall: getRegularStyle(color: ColorManager.grey),
        titleLarge: getSemiBoldStyle(color: ColorManager.grey,fontSize: 20),

      ),
      //input decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14),
        labelStyle: getMediumStyle(color: ColorManager.grey,fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManager.error),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all( Radius.circular(AppSize.s8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
      )
  );
}

ThemeData darkAppTheme(){
  return ThemeData(
    // main color
    scaffoldBackgroundColor: ColorManager.black,
    backgroundColor: ColorManager.black,
      primaryColor: ColorManager.black,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.lightPrimary,
      // card theme
      cardTheme: CardTheme(
        color: ColorManager.black,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4,
      ),

      // appBar Theme
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: ColorManager.black
        ),
        color: ColorManager.black,
        elevation: AppSize.s3,
        shadowColor: ColorManager.lightPrimary,
        centerTitle: true,
        titleTextStyle: getRegularStyle(
            color: ColorManager.white,
            fontSize: FontSize.s16
        ),
        iconTheme: IconThemeData(
          color: ColorManager.darkGrey,
        ),

      ),
      // button theme
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        splashColor: ColorManager.lightPrimary,
        buttonColor: ColorManager.primary,
        disabledColor: ColorManager.grey1,
      ),

      // ElevatedButtonTheme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.black,fontSize:FontSize.s17),
          primary: ColorManager.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12)
          ),
        ),
      ),
      // text theme
      textTheme: TextTheme(

        displayLarge: getBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s30),
        displayMedium: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s22),
        headlineLarge: getSemiBoldStyle(color: ColorManager.darkPrimary,fontSize: FontSize.s16),
        titleMedium: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s14),
        bodyLarge: getRegularStyle(color: ColorManager.grey1),
        bodySmall: getRegularStyle(color: ColorManager.grey),
        titleLarge: getSemiBoldStyle(color: ColorManager.grey,fontSize: 20),

      ),
      //input decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14),
        labelStyle: getMediumStyle(color: ColorManager.grey,fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManager.error),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all( Radius.circular(AppSize.s8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
      )
  );
}