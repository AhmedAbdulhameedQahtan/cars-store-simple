import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../resources/assets_manager.dart';
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
    Navigator.pushReplacementNamed(context, Routes.noBoardingRoute);
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
      appBar: AppBar(elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorsManager.primary,
            statusBarBrightness: Brightness.light),),

      backgroundColor: ColorsManager.primary,

      body:const Center(child: Image(image: AssetImage('assets/images/splash.jpg'),
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
