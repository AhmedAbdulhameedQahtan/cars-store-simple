import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../view/home_view.dart';


class LoginController{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool checkBoxState = true;
  bool obscureText = true;
  String? myToken = "";

  // الحصول على التوكن
  _getToken() async {
    myToken = await _fcm.getToken();
    print("my_token =============$myToken");
  }

  getMyToken(){
    return _getToken();
  }

  // تحقق من صحة تنسيق البريد الإلكتروني
  bool isEmailValid(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  void onAuthError(BuildContext context,String errorCode, String? message) {
    // عرض حوار الخطأ
    String? title;
    String? desc;

    if (errorCode == 'user-not-found') {
      title = 'User Not Found';
      desc = 'No user found for that email.';
    } else if (errorCode == 'wrong-password') {
      title = 'Wrong Password';
      desc = 'The password is incorrect.';
    } else if (errorCode == 'invalid-credential'){
      title = 'error'.tr();
      desc = 'invalid_credential'.tr();
    }
    print("=====title======$title====================");
    print("==desc=========$desc====================");

    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      descTextStyle: Theme.of(context).textTheme.bodySmall,
      btnOkOnPress: () {},
    ).show();
  }

  void onGeneralError(BuildContext context,String errorMessage) {
    // عرض حوار لأي خطأ عام
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'error'.tr(),
      desc: errorMessage,
      descTextStyle: Theme.of(context).textTheme.bodySmall,
      btnOkOnPress: () {},
    ).show();
  }

  Future<void> signIn(BuildContext context, email,password) async {

    if (!isEmailValid(email)) {
      // عرض تنبيه بوجود خطأ في تنسيق البريد الإلكتروني
      onGeneralError(context,'error_real_email'.tr());
      return;
    }else{

      try {
        var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        // الانتقال إلى الصفحة التالية بعد تسجيل الدخول بنجاح

        if ((result != null) ) {
          _db.collection('users').doc(result.user!.uid,).update({'token':myToken,});
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomeView()),);
        }
      } on FirebaseAuthException catch (e) {
        onAuthError(context,e.code,e.message);
      }catch (e) {
        // عرض رسالة منبثقة عند حدوث خطأ أثناء تسجيل الدخول
        onGeneralError(context,e.toString());
        print("حدث خطأ أثناء تسجيل الدخول: $e");
      }
    }
  }


  // Future<void> _login(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isLoggedIn', true); // حفظ حالة تسجيل الدخول
  // }


}