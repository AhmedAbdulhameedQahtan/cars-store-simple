import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
  bool checkBoxState = false;
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
      title = 'Invalid Credential';
      desc = 'The email or password is incorrect. Please try again.';
    }
    print("=====title======$title====================");
    print("==desc=========$desc====================");

    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
    ).show();
  }

  void onGeneralError(String errorMessage) {
    // عرض حوار لأي خطأ عام
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: errorMessage,
      btnOkOnPress: () {},
    ).show();
  }


  Future<void> signIn( email,password) async {

    if (!isEmailValid(email)) {
      // عرض تنبيه بوجود خطأ في تنسيق البريد الإلكتروني
      AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'False Email',
          desc: 'Write correct email',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
    ).show();
      return;
    }else{

    try {
      var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // الانتقال إلى الصفحة التالية بعد تسجيل الدخول بنجاح

      if ((result != null) ) {
        if (checkBoxState != true) {
          // حفظ الحاله
          _auth.signOut();
          print("===================state log oyt ===============");
        }
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
        color: ColorsManager.lightBlack,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // text in the head of page
              Container(
                  width: size.width,
                  height: size.height / 4,
                  padding: const EdgeInsets.only(
                      left: AppSize.s20, top: AppSize.s15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'welcome',
                        style: TextStyle(
                            fontFamily: 'orban',
                            fontSize: FontSize.s40,
                            fontWeight: FontWeighManager.bold,
                            color: ColorsManager.primary),
                      ),
                      Text(
                        'Bac k !',
                        style: TextStyle(
                            fontFamily: 'orban',
                            fontSize: FontSize.s25,
                            fontWeight: FontWeighManager.bold,
                            color: ColorsManager.white),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        'Sign in to access your purchase history and get real-time updates on your car orders',
                        style: TextStyle(color: ColorsManager.lightgray),
                      ),
                    ],
                  )),

              const SizedBox(height: AppSize.s50,),

              // text form feald email
              CustomTextFormField(
                textController: _emailController,
                textInputType: TextInputType.emailAddress,
                prefixIcon:const  Icon(Icons.email_outlined),
                hintText: "Email",
              ),
              
              const SizedBox(
                height: AppSize.s30,
              ),

              // text form feald password
              CustomTextFormField(
                textController: _passwordController,
                textInputType: TextInputType.visiblePassword,
                prefixIcon:const  Icon(Icons.lock),
                hintText: "Password",
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
                              'Remember me ',
                              style: TextStyle(color: ColorsManager.white),
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
                          'Forgot password',
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
                  child: const Text(
                    'login',
                    style: TextStyle(color: Colors.white),
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
                      const Text(
                        'Continue with google',
                        style: TextStyle(
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
                margin: const EdgeInsets.only(left: 70),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        'Dont have account?',
                        style: TextStyle(color: ColorsManager.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterView()));
                        },
                        child: Text(
                          'Create an Account',
                          style: TextStyle(color: ColorsManager.primary),
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
