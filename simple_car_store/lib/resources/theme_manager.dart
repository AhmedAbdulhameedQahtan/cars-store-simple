import 'package:flutter/material.dart';
import 'package:simple_car_store/resources/styles_manager.dart';
import 'package:simple_car_store/resources/values_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorsManager.white,
    colorScheme: const ColorScheme.light().copyWith(
      surface: ColorsManager.white,
      onSurface: ColorsManager.white,

    ),

    //main colors theme
    primaryColor: ColorsManager.primary,
    disabledColor: ColorsManager.gray,
    splashColor: ColorsManager.lightprimary,

    //drawer theam
    drawerTheme: DrawerThemeData(
        backgroundColor:ColorsManager.white
    ),
    //cardview theme
    cardTheme: CardTheme(
      color: ColorsManager.white,
      shadowColor: ColorsManager.gray,
      elevation: AppSize.s4,
    ),

    //AppBar theme
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: ColorsManager.white),
        color: ColorsManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorsManager.lightprimary,
        centerTitle: true,
        titleTextStyle: getRegularStyle(
            fontSize: FontSize.s16, color: ColorsManager.white)),

    //button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorsManager.lightgray,
      buttonColor: ColorsManager.primary,
      splashColor: ColorsManager.lightprimary,
    ),

    //elevated theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            getRegularStyle(color: ColorsManager.white, fontSize: FontSize.s18),
        // primary: ColorsManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    //Text theme
    textTheme: TextTheme(
      displayLarge: getBoldStyle(color: ColorsManager.darkgray, fontSize: FontSize.s16),
      displayMedium: getLightStyle(color: ColorsManager.darkgray, fontSize: FontSize.s16),
      displaySmall: getLightStyle(color: ColorsManager.darkgray, fontSize: FontSize.s16),

      headlineLarge: getSimpoldStyle(color: ColorsManager.darkgray, fontSize: FontSize.s16,),

      headlineMedium: getRegularStyle(color: ColorsManager.darkgray, fontSize: FontSize.s14,),

      titleLarge: getRegularStyle(color: ColorsManager.primary),
      titleMedium: getMedumStyle(color: ColorsManager.primary, fontSize: FontSize.s16),
      titleSmall: getRegularStyle(color: ColorsManager.darkgray),

      bodyLarge: getRegularStyle(color: ColorsManager.lightgray),
      bodyMedium: getRegularStyle(color: ColorsManager.darkgray),
      bodySmall: getRegularStyle(color: ColorsManager.darkgray),
    ),


    //inputDecoration theme
    inputDecorationTheme: InputDecorationTheme(
      //content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),

      //hint style
      hintStyle:
          getRegularStyle(color: ColorsManager.gray, fontSize: FontSize.s14),

      //label style
      labelStyle:
          getRegularStyle(color: ColorsManager.gray, fontSize: FontSize.s14),

      fillColor: ColorsManager.lightgray200,
      //error style
      errorStyle: getRegularStyle(color: ColorsManager.error),

      //enable border style
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorsManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      //focused border style
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorsManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      //error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      //focused error border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorsManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),

      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          // اللون الرئيسي
          foregroundColor: WidgetStateProperty.all(ColorsManager.gray),


          // لون الخلفية
          // backgroundColor: ColorsManager.lightgray200,

          // حجم الأيقونة
          // iconSize: WidgetStateProperty.all(24.0),

          // الهوامش والمسافات
          // padding: MaterialStateProperty.all(
          //   const EdgeInsets.all(AppPadding.p8),
          // ),
          //
          // // شكل الحواف
          // shape: MaterialStateProperty.all(
          //   RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(AppSize.s8),
          //   ),
          // ),
          //
          // // تأثير النقر
          // overlayColor: MaterialStateProperty.resolveWith((states) {
          //   if (states.contains(MaterialState.pressed)) {
          //     return ColorsManager.lightprimary.withOpacity(0.2);
          //   }
          //   return null;
          // }),
        ),
      )



  );

  static final darkTheme = ThemeData(

    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsManager.lightBlack,

    colorScheme: const ColorScheme.dark().copyWith(
      surface: ColorsManager.lightBlack,
      onSurface: ColorsManager.gray,
    ),

    //main colors theme
    primaryColor: ColorsManager.primary,
    disabledColor: ColorsManager.gray,
    splashColor: ColorsManager.lightprimary,

    //drawer theam
    drawerTheme: DrawerThemeData(
        backgroundColor:ColorsManager.lightBlack
    ),
    //cardview theme
    cardTheme: CardTheme(
      color: ColorsManager.white,
      shadowColor: ColorsManager.gray,
      elevation: AppSize.s4,
    ),

    //AppBar theme
    appBarTheme: AppBarTheme(
        iconTheme:IconThemeData(color: ColorsManager.white),
        color: ColorsManager.primary,
        elevation: 0,
        shadowColor: ColorsManager.lightprimary,
        centerTitle: true,
        titleTextStyle: getRegularStyle(
            fontSize: FontSize.s16, color: ColorsManager.white)),

    //button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorsManager.lightgray,
      buttonColor: ColorsManager.primary,
      splashColor: ColorsManager.lightprimary,
    ),

    //elevated theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorsManager.white, fontSize: FontSize.s18),
        // primary: ColorsManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    //Text theme
    textTheme: TextTheme(
      displayLarge: getBoldStyle(color: ColorsManager.darkgray, fontSize: FontSize.s16),
      displayMedium: getLightStyle(color: ColorsManager.darkgray, fontSize: FontSize.s16),
      displaySmall: getLightStyle(color: ColorsManager.darkgray, fontSize: FontSize.s16),
      headlineLarge: getSimpoldStyle(color: ColorsManager.lightgray, fontSize: FontSize.s16,),
      headlineMedium: getRegularStyle(color: ColorsManager.darkgray, fontSize: FontSize.s14,),
      titleLarge: getRegularStyle(color: ColorsManager.primary),
      titleMedium: getMedumStyle(color: ColorsManager.primary, fontSize: FontSize.s16),
      titleSmall: getRegularStyle(color: ColorsManager.white),
      bodyLarge: getRegularStyle(color: ColorsManager.lightgray),
      bodyMedium: getRegularStyle(color: ColorsManager.darkgray),
      bodySmall: getRegularStyle(color: ColorsManager.white),
    ),

    //inputDecoration theme
    inputDecorationTheme: InputDecorationTheme(
      //content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),

      iconColor: ColorsManager.lightBlack,

      //hint style
      hintStyle:
          getRegularStyle(color: ColorsManager.gray, fontSize: FontSize.s14),

      //label style
      labelStyle:
          getRegularStyle(color: ColorsManager.gray, fontSize: FontSize.s14),

      fillColor: ColorsManager.lightgray200,
      //error style
      errorStyle: getSimpoldStyle(color: ColorsManager.error),

      //enable border style
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorsManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      //focused border style
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorsManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      //error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      //focused error border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorsManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),

       iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          // اللون الرئيسي
          foregroundColor: WidgetStateProperty.all(ColorsManager.gray),
        ),
      )


  );
}