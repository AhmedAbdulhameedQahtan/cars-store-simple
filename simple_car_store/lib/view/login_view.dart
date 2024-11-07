import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_car_store/resources/color_manager.dart';
import 'package:simple_car_store/resources/font_manager.dart';
import 'package:simple_car_store/view/home_view.dart';
import 'package:simple_car_store/view/register_view.dart';
import '../model/firbase_auth.dart';
import '../resources/assets_manager.dart';
import '../resources/values_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMessage = "";
  bool checkBoxState = false;

  Future<void> _login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true); // حفظ حالة تسجيل الدخول
  }

  // تحقق من صحة تنسيق البريد الإلكتروني
  bool isEmailValid(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  Future<void> signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

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
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // الانتقال إلى الصفحة التالية بعد تسجيل الدخول بنجاح
      print("تم تسجيل الدخول بنجاح$result!");

      if (result != null) {
        if (checkBoxState) {
          _login(context);
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      }
    } catch (e) {
      setState(() {
        errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة.";
      });

      // عرض رسالة منبثقة عند حدوث خطأ أثناء تسجيل الدخول
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error login",
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

      print("حدث خطأ أثناء تسجيل الدخول: $e");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
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

              const SizedBox(
                height: AppSize.s50,
              ),

              // text form feald email
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    filled: true,
                    hintText: "Email",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please fill the email input';
                    }
                  },
                ),
              ),

              const SizedBox(
                height: AppSize.s30,
              ),
              // text form feald password

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    iconColor: Colors.black54,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                    filled: true,
                    hintText: "Password",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please fill the password input';
                    }
                  },
                ),
              ),

              const SizedBox(
                height: AppSize.s4,
              ),

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
                      setState(() {
                        signIn();
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
                          Navigator.push(
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
