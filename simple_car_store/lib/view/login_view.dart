import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:simple_car_store/custom_widget/container_card.dart';
import 'package:simple_car_store/custom_widget/custom_text_form_field.dart';
import 'package:simple_car_store/resources/color_manager.dart';
import 'package:simple_car_store/resources/font_manager.dart';
import 'package:simple_car_store/view/home_view.dart';
import 'package:simple_car_store/view/register_view.dart';
import '../resources/assets_manager.dart';
import '../resources/values_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';



class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  
  final _formKey = GlobalKey<FormState>();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMessage = "";
  bool checkBoxState = true;
  bool obscureText = true;
  String? myToken = "";

  // Future<void> _login(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isLoggedIn', true); // حفظ حالة تسجيل الدخول
  // }

  // تحقق من صحة تنسيق البريد الإلكتروني
  bool isEmailValid(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  getToken() async {
    myToken = await _fcm.getToken();
    print("mytoken =============$myToken");
  }

  void onAuthError(String errorCode, String? message) {
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

  void onGeneralError(String errorMessage) {
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


  Future<void> signIn( email,password) async {

    if (!isEmailValid(email)) {
      // عرض تنبيه بوجود خطأ في تنسيق البريد الإلكتروني
      AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'error'.tr(),
          desc: 'error_real_email'.tr(),
        descTextStyle: Theme.of(context).textTheme.bodySmall,
        btnOkOnPress: () {},
    ).show();
      return;
    }else{

    try {
      var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // الانتقال إلى الصفحة التالية بعد تسجيل الدخول بنجاح

      if ((result != null) ) {
        // if (checkBoxState != true) {
        //   // حفظ الحاله
        //   _auth.signOut();
        //   // print("===================state log oyt ===============");
        // }
          _db.collection('users').doc(result.user!.uid,).update({'token':myToken,});
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomeView()),);
      }
    } on FirebaseAuthException catch (e) {
      onAuthError(e.code,e.message);
    }catch (e) {

      // عرض رسالة منبثقة عند حدوث خطأ أثناء تسجيل الدخول
      onGeneralError(e.toString());

      print("حدث خطأ أثناء تسجيل الدخول: $e");
    }
    }
    }



  @override
  void initState() {
    // TODO: implement initState
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color:Theme.of(context).colorScheme.surface,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // text in the head of page
              Container(
                  width: size.width,
                  height: size.height / 4,
                  padding:context.locale.languageCode == 'en' ? const EdgeInsets.only(left: AppSize.s20, top: AppSize.s15)
                  :const EdgeInsets.only(right: AppSize.s20, top: AppSize.s15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'login_head'.tr(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontFamily: 'orban', fontSize: FontSize.s40,),
                      ),
                      Text(
                        'register_title'.tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontFamily: 'orban', fontSize: FontSize.s25,),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        'login_text'.tr(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  )),

              const SizedBox(height: AppSize.s50,),

              // text form feald email
              CustomTextFormField(
                textController: _emailController,
                textInputType: TextInputType.emailAddress,
                prefixIcon:const  Icon(Icons.email_outlined),
                hintText: 'email'.tr(),
              ),
              
              const SizedBox(
                height: AppSize.s30,
              ),

              // text form feald password
              CustomTextFormField(
                textController: _passwordController,
                textInputType: TextInputType.visiblePassword,
                prefixIcon:const  Icon(Icons.lock),
                hintText: 'password'.tr(),
                obscureText: true,
              ),


              const SizedBox(height: AppSize.s4),

              //check box and forget password
              Container(
                  padding: const EdgeInsets.all(AppSize.s4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Checkbox(
                              value: checkBoxState,
                              checkColor: ColorsManager.white,
                              activeColor: ColorsManager.primary,
                              onChanged: (value) {
                                setState(() {
                                  checkBoxState = value!;
                                  print(
                                      "checkBoxState======================$checkBoxState");
                                });
                              },
                            ),
                            Text(
                              'remember_me'.tr(),
                              style:Theme.of(context).textTheme.headlineLarge,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        },
                        child: Text(
                          'forgot_password'.tr(),
                          style: TextStyle(color: ColorsManager.primary),
                        ),
                      ),
                    ],
                  )),

              const SizedBox(
                height: 25,
              ),

              //log in button
              Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // setState(() {
                        signIn(_emailController.text.trim(),_passwordController.text.trim());
                      // });
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeView()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primary,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    // التحكم في المسافات الداخلية (حجم الزر)

                    shape: RoundedRectangleBorder(
                      // شكل الزر (حواف مستديرة)
                      borderRadius:
                          BorderRadius.circular(10), // تحديد نصف قطر الزوايا
                    ),
                  ),
                  child:  Text(
                    'login'.tr(),
                    style:const TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(
                height: 55,
              ),

              Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                    // التحكم في المسافات الداخلية (حجم الزر)
                    side: const BorderSide(width: 2.0, color: Colors.grey),
                    // Border settings
                    shape: RoundedRectangleBorder(
                      //// شكل الزر (حواف مستديرة)
                      borderRadius:
                          BorderRadius.circular(30), // تحديد نصف قطر الزوايا
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        ImageAssets.googleIcon,
                        width: 50,
                        height: 50,
                      ),
                       Text(
                        'google_sign_in'.tr(),
                        style:const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              Container(
                margin:context.locale.languageCode == 'en' ? const EdgeInsets.only(left: 55):const EdgeInsets.only(right: 100),
                child: Center(
                  child: Row(
                    children: [
                      Text('dont_have_account'.tr(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterView()));
                        },
                        child: Text(
                          'create_account'.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
