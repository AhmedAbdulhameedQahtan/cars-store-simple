import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_car_store/controller/RegisterController.dart';
import 'package:simple_car_store/custom_widget/custom_text_form_field.dart';
import 'package:simple_car_store/resources/color_manager.dart';
import 'package:simple_car_store/view/login_view.dart';
import '../resources/assets_manager.dart';
import '../resources/font_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  RegisterController registerController = RegisterController();

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
                      value:registerController.checkBoxState,
                      checkColor: ColorsManager.white,
                      activeColor: ColorsManager.primary,
                      onChanged: (value) {
                        setState(() {
                          registerController.checkBoxState = value!;
                          print(
                              "checkBoxState======================$registerController.checkBoxState");
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
                        registerController.createAccount(context,
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                          _confirmController.text.trim(),);
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
