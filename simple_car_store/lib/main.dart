import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:simple_car_store/resources/routes_manager.dart';
import 'package:simple_car_store/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // هذه الدالة تعالج الرسائل عندما يكون التطبيق في الخلفية
  print("Handling a background message: ${message.messageId}");
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // استدعاء Firebase.initializeApp
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations', // مسار ملفات الترجمة
      fallbackLocale: const Locale('en'), // اللغة الافتراضية
      child:  MyApp(),
    ),
  );
  // runApp(MyApp());
}




class MyApp extends StatefulWidget {

  // static void setLocale(BuildContext context, Locale newLocale) {
  //   _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
  //   state?.changeLocale(newLocale);
  // }
  MyApp._internal();
  static final MyApp _instance = MyApp._internal();
  factory MyApp()=>_instance;
  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  // Locale _locale = const Locale('en');
  //
  // void changeLocale(Locale locale) {
  //   setState(() {
  //     _locale = locale;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      // locale: _locale,
      // supportedLocales: const [
      //   Locale('en', ''),
      //   Locale('ar', ''),
      // ],
      // localizationsDelegates: const [
      //   AppLocalizationsDelegate(),
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // debugShowCheckedModeBanner: false,
      // onGenerateRoute: RoutGenerator.getRoute,
      // initialRoute: Routes.splashRoute,
      // theme: getApplicationTheme(),
      // home: HomePage(),
    );
    // return  MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   onGenerateRoute: RoutGenerator.getRoute,
    //   initialRoute: Routes.splashRoute,
    //   theme: getApplicationTheme(),
    // );
  }
}

