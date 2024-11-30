import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:simple_car_store/custom_widget/custom_text_form_field.dart';
import 'package:simple_car_store/resources/color_manager.dart';
import 'package:simple_car_store/view/login_view.dart';
import '../resources/assets_manager.dart';
import '../resources/font_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool obscurePasswordText = true;
  bool obscureConfirmText = true;
  bool checkBoxState = false;
  String? myToken = "";

  getToken() async {
    myToken = await _fcm.getToken();
    print("mytoken =============$myToken");
  }

  bool isEmailValid(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  Future<void> createAccount() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmController.text.trim();

    if (!isEmailValid(email)) {
      // عرض تنبيه بوجود خطأ في تنسيق البريد الإلكتروني
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("False Emeil",
                style: TextStyle(
                  color: ColorsManager.error,
                  fontWeight: FontWeighManager.bold,
                )),
            content: Text("write real email",
                style: TextStyle(
                  color: ColorsManager.black,
                  fontWeight: FontWeighManager.bold,
                )),
            actions: [
              TextButton(
                child: Text("ok",
                    style: TextStyle(
                      color: ColorsManager.primary,
                      fontWeight: FontWeighManager.bold,
                    )),
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق التنبيه
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      if ((confirmPassword == password) && (checkBoxState == true)) {
        var result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if(result!=null){
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error confirm password",
                  style: TextStyle(
                    color: ColorsManager.error,
                    fontWeight: FontWeighManager.bold,
                  )),
              content: Text("check the password and confirm password",
                  style: TextStyle(
                    color: ColorsManager.black,
                    fontWeight: FontWeighManager.bold,
                  )),
              actions: [
                TextButton(
                  child: Text("ok",
                      style: TextStyle(
                        color: ColorsManager.primary,
                        fontWeight: FontWeighManager.bold,
                      )),
                  onPressed: () {
                    Navigator.of(context).pop(); // إغلاق التنبيه
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // عرض رسالة منبثقة عند حدوث خطأ أثناء انشاء الحساب
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error create an account",
                style: TextStyle(
                  color: ColorsManager.error,
                  fontWeight: FontWeighManager.bold,
                )),
            content: Text("false email or password",
                style: TextStyle(
                  color: ColorsManager.black,
                  fontWeight: FontWeighManager.bold,
                )),
            actions: [
              TextButton(
                child: Text("ok",
                    style: TextStyle(
                      color: ColorsManager.primary,
                      fontWeight: FontWeighManager.bold,
                    )),
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق التنبيه
                },
              ),
            ],
          );
        },
      );

      print("حدث خطأ أثناء انشاء الحساب: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
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
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'H e llo',
                        style: TextStyle(
                            fontFamily: 'orban',
                            fontSize: FontSize.s40,
                            fontWeight: FontWeighManager.bold,
                            color: ColorsManager.primary),
                      ),
                      Text(
                        't h e r e !',
                        style: TextStyle(
                            fontFamily: 'orban',
                            fontSize: FontSize.s25,
                            fontWeight: FontWeighManager.bold,
                            color: ColorsManager.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Create an account to access your purchase history and get real-time updates on your car orders',
                        style: TextStyle(color: ColorsManager.lightgray),
                      ),
                    ],
                  )),

              const SizedBox(
                height: 40,
              ),

              // text form field email
              CustomTextFormField(
                textController: _emailController,
                textInputType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: "Email",
              ),

              const SizedBox(
                height: 30,
              ),

              // text form field password
              CustomTextFormField(
                textController: _passwordController,
                textInputType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.lock),
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(
                height: 30,
              ),

              // text form field confirm password
              CustomTextFormField(
                textController: _confirmController,
                textInputType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.lock),
                hintText: "confirm Password",
                obscureText: true,
              ),

              const SizedBox(
                height: 5,
              ),

              // check box of privacy page
              Container(
                padding: EdgeInsets.all(5),
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
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Agree to our Terms of Services and Privacy Policy',
                          style: TextStyle(
                            color: ColorsManager.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              // signup button
              Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        createAccount();
                      });
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
                    'signup',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // google button
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
                height: 20,
              ),

              // text to sign in page
              Container(
                margin: const EdgeInsets.only(left: 100),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        'Already have account',
                        style: TextStyle(color: ColorsManager.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        },
                        child: Text(
                          'login',
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
