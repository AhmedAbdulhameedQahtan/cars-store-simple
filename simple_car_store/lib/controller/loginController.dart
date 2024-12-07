// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../resources/color_manager.dart';
// import '../resources/font_manager.dart';
//
//
// class LoginController{
//
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String errorMessage = "";
//   bool checkBoxState = false;
//   bool obscureText = true;
//
//   Future<void> _login(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true); // حفظ حالة تسجيل الدخول
//   }
//
//   // تحقق من صحة تنسيق البريد الإلكتروني
//   bool isEmailValid(String email) {
//     String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
//     RegExp regExp = RegExp(emailPattern);
//     return regExp.hasMatch(email);
//   }
//
//   Future<void> signIn() async {
//
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//
//     if (!isEmailValid(email)) {
//
//       // عرض تنبيه بوجود خطأ في تنسيق البريد الإلكتروني
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("False Emeil",
//                 style: TextStyle(
//                   color: ColorsManager.error,
//                   fontWeight: FontWeighManager.bold,
//                 )),
//             content: Text("write real email",
//                 style: TextStyle(
//                   color: ColorsManager.black,
//                   fontWeight: FontWeighManager.bold,
//                 )),
//             actions: [
//               TextButton(
//                 child: Text("ok",
//                     style: TextStyle(
//                       color: ColorsManager.primary,
//                       fontWeight: FontWeighManager.bold,
//                     )),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // إغلاق التنبيه
//                 },
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }
//
//     try {
//       var result = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       // الانتقال إلى الصفحة التالية بعد تسجيل الدخول بنجاح
//
//       if (result != null) {
//         if (checkBoxState) {
//           _login(context);
//         }
//         Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomeView()),);
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة.";
//       });
//
//       // عرض رسالة منبثقة عند حدوث خطأ أثناء تسجيل الدخول
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Error login",
//                 style: TextStyle(
//                   color: ColorsManager.error,
//                   fontWeight: FontWeighManager.bold,
//                 )),
//             content: Text("false email or password",
//                 style: TextStyle(
//                   color: ColorsManager.black,
//                   fontWeight: FontWeighManager.bold,
//                 )),
//             actions: [
//               TextButton(
//                 child: Text("ok",
//                     style: TextStyle(
//                       color: ColorsManager.primary,
//                       fontWeight: FontWeighManager.bold,
//                     )),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // إغلاق التنبيه
//                 },
//               ),
//             ],
//           );
//         },
//       );
//
//       print("حدث خطأ أثناء تسجيل الدخول: $e");
//     }
//   }
//
//
// }