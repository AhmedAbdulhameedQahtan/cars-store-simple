import 'package:flutter/material.dart';
import 'package:simple_car_store/resources/styles_manager.dart';
import 'package:simple_car_store/resources/values_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';



ThemeData getApplicationTheme(){
  return ThemeData(
    //main colors theme
    primaryColor: ColorsManager.primary,
    disabledColor: ColorsManager.gray,
    splashColor: ColorsManager.lightprimary,

    //cardview theme
    cardTheme: CardTheme(
      color: ColorsManager.white,
      shadowColor: ColorsManager.gray,
      elevation: AppSize.s4,),
      
    //AppBar theme
    appBarTheme: AppBarTheme(
      color: ColorsManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorsManager.lightprimary,
      centerTitle: true,
      titleTextStyle: getRegularStyle(fontSize: FontSize.s16, color: ColorsManager.white)),
    
    
    //button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorsManager.lightgray,
      buttonColor: ColorsManager.primary,
      splashColor: ColorsManager.lightprimary,),
    
    //elevated theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorsManager.white,fontSize: FontSize.s18),
        // primary: ColorsManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),),),),
    
    //Text theme
    textTheme: TextTheme(
      displayLarge: getLightStyle(color: ColorsManager.darkgray,fontSize: FontSize.s16),
      headlineLarge: getSimpoldStyle(color: ColorsManager.darkgray, fontSize: FontSize.s16,),
      headlineMedium: getRegularStyle(color: ColorsManager.darkgray, fontSize: FontSize.s14,),
      titleMedium: getMedumStyle(color: ColorsManager.primary,fontSize: FontSize.s16),
      bodyLarge: getRegularStyle(color: ColorsManager.lightgray),
      bodySmall: getRegularStyle(color: ColorsManager.gray),),
    
    
    //inputDecoration theme
    inputDecorationTheme: InputDecorationTheme(
      //content padding
      contentPadding:const EdgeInsets.all(AppPadding.p8),

      //hint style
      hintStyle: getRegularStyle(color: ColorsManager.gray,fontSize: FontSize.s14),

      //label style
      labelStyle: getRegularStyle(color: ColorsManager.gray,fontSize: FontSize.s14),

      //error style
      errorStyle: getRegularStyle(color: ColorsManager.error),

      //enable border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.primary,width: AppSize.s1_5),
        borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8)),),

      //focused border style
      focusedBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.gray,width: AppSize.s1_5),
        borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8)),),

      //error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.error,width: AppSize.s1_5),
        borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8)),),

      //focused error border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.primary,width:AppSize.s1_5),
        borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8)),),
    ),

  );
}