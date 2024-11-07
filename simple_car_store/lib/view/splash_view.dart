import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_car_store/resources/assets_manager.dart';
import 'package:simple_car_store/resources/font_manager.dart';
import 'package:simple_car_store/resources/values_manager.dart';
import 'package:simple_car_store/view/home_view.dart';
import 'package:simple_car_store/view/login_view.dart';
import '../model/firbase_auth.dart';
import '../resources/color_manager.dart';
import '../resources/constant_manager.dart';
import '../resources/routes_manager.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay(){
    _timer = Timer(const Duration(seconds: AppConstant.splashDuration), _goNext);
  }

  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // الانتقال إلى الشاشة الرئيسية إذا كان المستخدم مسجل الدخول
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const HomeView()),
      );
    } else {
      // الانتقال إلى شاشة تسجيل الدخول إذا لم يكن المستخدم مسجل الدخول
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  NetworkChecker()),
      );
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      // _startDelay();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: null,

      backgroundColor: ColorsManager.white,

      body:Container(

        padding: const EdgeInsets.all(AppPadding.p5),
        child: Column(
          children: [
            const SizedBox(height: AppSize.s40,),

            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(10),
              child: Text("Easy way to buy your dream car",
                style: TextStyle(
                    color: ColorsManager.primary,
                    fontSize: FontSize.s35,
                    fontWeight: FontWeighManager.bold,
                    fontFamily: 'orban'
                ),),
            ),

            const SizedBox(height: AppSize.s14,),


            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(10),
              child: Text("By using car ,you can move quickly from one place to another in your daily life",
                style: TextStyle(color: ColorsManager.lightgray,fontSize: FontSize.s14),
              ),
            ),

            const SizedBox(height: AppSize.s80,),

            Padding(padding:const EdgeInsets.only(left: 30),child: Image.asset(ImageAssets.splashImage),),
            const SizedBox(height: AppSize.s50,),
            Container(
              width: size.width ,
              margin: const EdgeInsets.only(left: 20,right: 20,top: 50),
              child: ElevatedButton(
                onPressed: (){
                  _checkLoginStatus();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10), // التحكم في المسافات الداخلية (حجم الزر)

                  shape: RoundedRectangleBorder( // شكل الزر (حواف مستديرة)
                    borderRadius: BorderRadius.circular(10), // تحديد نصف قطر الزوايا
                  ),
                ),
                child:   Text('Get Started',style: TextStyle(color:ColorsManager.white,fontWeight: FontWeighManager.bold),),

              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }
}
