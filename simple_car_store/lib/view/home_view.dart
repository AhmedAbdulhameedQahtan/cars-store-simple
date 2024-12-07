import 'package:awesome_dialog/awesome_dialog.dart';
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
      // AwesomeDialog(
      //   context: context,
      //   dialogType: DialogType.error,
      //   animType: AnimType.rightSlide,
      //   title: message.notification?.title,
      //   desc: message.notification?.body,
      //   btnOkOnPress: () {},
      // ).show();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: CustomTextFormField(
            textController: _searchController,
            textInputType: TextInputType.text,
          prefixIcon: const Icon(Icons.search),
          hintText: "Search ..",
        ),

        actions: [
          Padding(
            padding:const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: (){

                   _logout(context);
                  },
                icon: const Icon(Icons.logout,size: 25,),
                color: ColorsManager.white, // لون الأيقونة
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        height: size.height,
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              width: size.width,
              height: 30,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Car',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text('Show more',
                      style: TextStyle(
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
                  color: Colors.grey[50],
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
