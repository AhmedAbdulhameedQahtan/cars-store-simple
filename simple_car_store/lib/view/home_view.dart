import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:simple_car_store/custom_widget/custom_text_form_field.dart';
import 'package:simple_car_store/resources/assets_manager.dart';
import 'package:simple_car_store/resources/color_manager.dart';
import 'package:simple_car_store/view/splash_view.dart';
import '../custom_widget/container_card.dart';
import '../model/cars_list_of_opject.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController _searchController = TextEditingController();


  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashView()),
    );
    // هذا الطريقه باستخدام ذاكره التخزين
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isLoggedIn', false); // حذف حالة تسجيل الدخول
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const SplashView()),
    // );

  }

  @override
  void initState() {
    // TODO: implement initState

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.noHeader,
          animType: AnimType.rightSlide,
          title: message.notification?.title,
          desc: message.notification?.body,
          btnOkOnPress: () {},
        ).show();

        print('Message also contained a notification: ${message.notification}');
      }
    });
    super.initState();
  }

  String? user = FirebaseAuth.instance.currentUser?.email;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName:  Text("أحمد قحطان",style: TextStyle(color: ColorsManager.white),),
                accountEmail:  Text(user!,style: TextStyle(color: ColorsManager.white),),
                currentAccountPicture: InkWell(
                  onTap: () {
                    // controller.pickImage(ImageSource.gallery);
                  },
                  // child: CircleAvatar(
                  //   radius: 45,
                  //   backgroundColor: Colors.transparent,
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       image: controller.image != null
                  //           ? DecorationImage(
                  //         fit: BoxFit.cover,
                  //         image: FileImage(
                  //             controller.image!),
                  //       )
                  //           : const DecorationImage(
                  //         fit: BoxFit.cover,
                  //         image: AssetImage("assets/image/user.png"),
                  //       ),
                  //       borderRadius:
                  //       const BorderRadius.all(Radius.circular(90.0)),
                  //       border: Border.all(
                  //         color: Colors.black12,
                  //         width: 1,
                  //       ),
                  //     ),
                  //     width: size.width * 0.45,
                  //     height: size.height * 0.21,
                  //   ),
                  // ),
                ),

                decoration:  BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: const [
                   BoxShadow(
                      color: Colors.black26,
                      // spreadRadius: 3,
                      blurRadius: 8,
                      offset: Offset(0, 3), // يغير مكان الظل
                    ),
                  ],
                ),
              ),

              ListTile(
                leading: const Icon(Icons.language),
                title:  Text('change_language'.tr(),style: Theme.of(context).textTheme.titleSmall,),
                onTap: () {
                  context.locale.languageCode == 'en' ?
                  context.setLocale(const Locale('ar')) :
                  context.setLocale(const Locale('en'));
                },
              ),

              ListTile(
                leading: const Icon(Icons.star),
                title:  Text('favorite'.tr(),style: Theme.of(context).textTheme.titleSmall,),
                onTap: () {
                },
              ),

              ListTile(
                leading: const Icon(Icons.category),
                title:  Text('categories'.tr(),style: Theme.of(context).textTheme.titleSmall,),
                onTap: () {
                },
              ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.settings),
                title:  Text('setting'.tr(),style: Theme.of(context).textTheme.titleSmall,),
                onTap: () {
                },
              ),

              ListTile(
                leading: const Icon(Icons.question_mark),
                title:  Text('about_app'.tr(),style: Theme.of(context).textTheme.titleSmall,),
                onTap: () {
                },
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: Text('logout'.tr(),style: Theme.of(context).textTheme.titleSmall,),
                onTap: () {
                  _logout(context);
                },
              ),

            ],
          ),
        ),
        appBar: AppBar(
          title: CustomTextFormField(
              textController: _searchController,
              textInputType: TextInputType.text,
            prefixIcon: const Icon(Icons.search),
            hintText:'search'.tr(),

          ),

        ),
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          height: size.height,
          color: Theme.of(context).colorScheme.surface,
          child: ListView(
            children: [
              Container(
                width: size.width,
                height: 30,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('popular_car'.tr(),
                      style: Theme.of(context).textTheme.titleLarge
                      // const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text('show_more'.tr(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.grey))
                  ],
                ),
              ),

              // menu container
              Container(
                height: size.height / 1.2,
                width: size.width,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 250.0),
                  itemCount: ImageAssets.carimage.length,
                  itemBuilder: (BuildContext context, int index) {
                    final car = carDetails[index];
                    return ContainerCarCard(
                      isFavorite: false,
                      img: ImageAssets.carimage[index],
                      carDetails: car,
                      price: "18,500",
                    );
                  },
                ),
              )
            ],
          ),
        ),
    );
  }
}
