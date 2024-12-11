import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_car_store/controller/loginController.dart';
import 'package:simple_car_store/custom_widget/custom_text_form_field.dart';
import 'package:simple_car_store/resources/color_manager.dart';
import 'package:simple_car_store/resources/font_manager.dart';
import 'package:simple_car_store/view/register_view.dart';
import '../resources/assets_manager.dart';
import '../resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginController loginController = LoginController();

  @override
  void initState() {
    // TODO: implement initState
    loginController.getMyToken();
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
                              value:loginController.checkBoxState,
                              checkColor: ColorsManager.white,
                              activeColor: ColorsManager.primary,
                              onChanged: (value) {
                                setState(() {
                                  loginController.checkBoxState = value!;
                                  print(
                                      "checkBoxState======================$loginController.checkBoxState");
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
                        loginController.signIn(context,_emailController.text.trim(),_passwordController.text.trim());
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
