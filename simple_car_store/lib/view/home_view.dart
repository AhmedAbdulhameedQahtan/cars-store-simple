import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_car_store/resources/assets_manager.dart';
import 'package:simple_car_store/resources/color_manager.dart';
import 'package:simple_car_store/view/splash_view.dart';
import '../custom_widget/container_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // حذف حالة تسجيل الدخول
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            filled: true,
            hintText: "Search ..",
          ),
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
                  return ContainerCarCard(
                    img: ImageAssets.carimage[index],
                    name: 'Land Rover',
                    price: 2000.0,
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
