
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/login_view.dart';
class RegisterController{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  bool obscurePasswordText = true;
  bool obscureConfirmText = true;
  bool checkBoxState = false;
  String? myToken = "";

  bool isEmailValid(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  void onGeneralError(BuildContext context,String errorMessage) {
    // عرض رسالة لأي خطأ عام
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'error_title'.tr(),
      desc: errorMessage,
      descTextStyle: Theme.of(context).textTheme.bodySmall,
      btnOkOnPress: () {},
    ).show();
  }

  Future<void> createAccount(BuildContext context,email,password,confirmPassword) async {


    if (!isEmailValid(email)) {
      // عرض تنبيه بوجود خطأ في تنسيق البريد الإلكتروني
      onGeneralError(context,'error_real_email'.tr());
      return;
    }

    try {
      if ((confirmPassword == password) && (checkBoxState == true)) {
        var result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // ارسال التحقق للبريد بالغه العربية
        await _auth.setLanguageCode("ar");
        await _auth.currentUser?.sendEmailVerification();


        if((result!=null)){
          _db.collection('users').doc(result.user!.uid,).set({
            'email':result.user!.email,
            'password':result.user!.uid,
            'token':myToken,
          });
        }
        // الانتقال إلى الصفحة التالية بعد انشاء الحساب بنجاح

        print("تم انشاء الحساب بنجاح$result!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      } else {
        // في حال لم يتطابق كلمة المرور مع تحقق كلمة المرور
        onGeneralError(context,'check_password'.tr());
      }
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onGeneralError(context,'weak_password'.tr());
        print('');
      } else if (e.code == 'email-already-in-use') {
        onGeneralError(context,'email-already-in-use'.tr());
        print('The account already exists for that email.');
      }
    }
    catch (e) {
      // عرض رسالة منبثقة عند حدوث خطأ أثناء انشاء الحساب
      onGeneralError(context,e.toString());
      print("حدث خطأ أثناء انشاء الحساب: $e");
    }
  }



}