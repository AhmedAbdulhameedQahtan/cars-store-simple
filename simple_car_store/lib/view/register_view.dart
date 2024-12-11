import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool obscurePasswordText = true;
  bool obscureConfirmText = true;
  bool checkBoxState = false;
  String? myToken = "";

  // getToken() async {
  //   myToken = await _fcm.getToken();
  //   print("mytoken =============$myToken");
  // }

  bool isEmailValid(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  void onGeneralError(String errorMessage) {
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

  Future<void> createAccount() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmController.text.trim();

    if (!isEmailValid(email)) {
      // عرض تنبيه بوجود خطأ في تنسيق البريد الإلكتروني
      onGeneralError('error_real_email'.tr());
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
        onGeneralError('check_password'.tr());
      }
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onGeneralError('weak_password'.tr());
        print('');
      } else if (e.code == 'email-already-in-use') {
        onGeneralError('email-already-in-use'.tr());
        print('The account already exists for that email.');
      }
    }
    catch (e) {
      // عرض رسالة منبثقة عند حدوث خطأ أثناء انشاء الحساب
      onGeneralError(e.toString());
      print("حدث خطأ أثناء انشاء الحساب: $e");
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
        color: Theme.of(context).colorScheme.surface,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // text in the head of page
              Container(
                  width: size.width,
                  height: size.height / 4,
                  padding:context.locale.languageCode == 'en' ? const EdgeInsets.only(left: 15, top: 15):const EdgeInsets.only(right: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'register_head'.tr(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontFamily: 'orban', fontSize: FontSize.s40,),

                      ),
                      Text(
                        'register_title'.tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontFamily: 'orban', fontSize: FontSize.s25,),

                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'register_text'.tr(),
                        style:  Theme.of(context).textTheme.headlineLarge,
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
                hintText: 'email'.tr(),
              ),

              const SizedBox(
                height: 30,
              ),

              // text form field password
              CustomTextFormField(
                textController: _passwordController,
                textInputType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.lock),
                hintText: 'password'.tr(),
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
                hintText: 'confirm_password'.tr(),
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
                          'privacy_policy'.tr(),
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
                  child:  Text(
                    'sign_up'.tr(),
                    style:const TextStyle(color: Colors.white),
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
                height: 20,
              ),

              // text to sign in page
              Container(
                margin:context.locale.languageCode == 'en' ? const EdgeInsets.only(left: 90):const EdgeInsets.only(right: 100),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        'have_account'.tr(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        },
                        child: Text(
                          'login'.tr(),
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
