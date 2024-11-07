import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_car_store/resources/assets_manager.dart';
import 'package:simple_car_store/resources/color_manager.dart';
import 'package:simple_car_store/view/splash_view.dart';

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
            decoration:  const InputDecoration(
              // border:OutlineInputBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(40)),
              //     borderSide:BorderSide.none
              // ) ,
              prefixIcon: Icon(Icons.search,color: Colors.grey,),
              filled: true,
              // fillColor: Colors.grey[200],
              hintText: "Search ..",
              // hintStyle: const TextStyle(color: Colors.grey,)
            ),
          ),
          actions: [
            Container(
              margin:const EdgeInsets.only(right: 10),
              decoration:  BoxDecoration(
                color: ColorsManager.white, // خلفية الزر
                shape: BoxShape.circle, // شكل دائري للزر
              ),
              child: IconButton(
                onPressed: () {
                  _logout(context);
                },
                icon: const Icon(Icons.logout),
                color: ColorsManager.primary, // لون الأيقونة
              ),
            )


          ],
        ),
        body:Container(
        margin: EdgeInsets.only(top: 10),
        height: size.height,
        color: Colors.white,
        child: ListView(
          children: [
            // Container(
            //   padding: const EdgeInsets.only(left: 5,right: 5),
            //   width: size.width,
            //   height: size.height/9.5,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         width: size.width/2,
            //         height: size.height,
            //         child: Row(
            //           children: [
            //             Container(
            //               margin: const EdgeInsets.only(left: 10,right: 10),
            //               width: 60,
            //               height: 60,
            //               decoration:const BoxDecoration(
            //                   shape: BoxShape.circle,
            //                   // color: Colors.grey,
            //                   image: DecorationImage(image: AssetImage(ImageAssets.person),
            //                     fit: BoxFit.cover,
            //                   )
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.only(top: 22,left: 5),
            //               child:const Column(
            //                 children: [
            //                   Text('Ahmed Qahtan',
            //                     style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12),),
            //                   Text('@qahtan.dev',
            //                     style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12),),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       IconButton(
            //           onPressed: (){},
            //           icon:const Icon(Icons.notifications_none)),
            //     ],
            //   ),
            // ),
            //
            // const SizedBox(height: 10,),
            //
            // // search container
            // Container(
            //   padding: const EdgeInsets.only(left: 5,right: 12),
            //   width: size.width,
            //   height: size.height/9.5,
            //   // decoration:const BoxDecoration(
            //   //   color: Colors.yellow,
            //   //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
            //   // ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.only(left: 10),
            //         // padding: const EdgeInsets.only(left: 5,right: 15),
            //         width: size.width/1.3,
            //         // height: 50,
            //         // decoration: BoxDecoration(
            //         //   color: Colors.grey[100],
            //         //   borderRadius: const BorderRadius.all(Radius.circular(40)),
            //         // ),
            //         child: TextFormField(
            //           decoration:  const InputDecoration(
            //             border:OutlineInputBorder(
            //                 borderRadius: BorderRadius.all(Radius.circular(40)),
            //                 borderSide:BorderSide.none
            //             ) ,
            //             prefixIcon: Icon(Icons.search,color: Colors.grey,),
            //             filled: true,
            //             // fillColor: Colors.grey[200],
            //             hintText: "Search jobs..",
            //             // hintStyle: const TextStyle(color: Colors.grey,)
            //           ),
            //         ),
            //       ),
            //       Container(
            //         decoration:  BoxDecoration(
            //           color: ColorsManager.primary, // خلفية الزر
            //           shape: BoxShape.circle, // شكل دائري للزر
            //         ),
            //         child: IconButton(
            //           onPressed: () {},
            //           icon: const Icon(Icons.menu),
            //           color: Colors.white, // لون الأيقونة
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // recent show more container
            Container(
              width: size.width,
              height: 30,
              padding:const EdgeInsets.only(left: 10,right: 10),
              child:const  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Resent',style: TextStyle(fontWeight: FontWeight.w700),),
                  Text('Show more',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.grey))
                ],
              ),
            ),

            // menu container
            Container(
              height: size.height/1.2,
              width: size.width,
              margin:const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius:const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
              ),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 250.0),
                children: [
                  // cards container
                  Container(
                      margin:const EdgeInsets.all(10),
                      padding:const EdgeInsets.all(15),
                      // width: size.width/2,
                      // height: size.height/3,
                      decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),  // لون الظل
                            spreadRadius: 0.2,                       // انتشار الظل
                            blurRadius: 6,                         // مقدار الضبابية
                            offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(ImageAssets.splashImagelog),
                          // fit: BoxFit.cover
                        ),
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.favorite_border ,color: ColorsManager.lightgray,),
                          SizedBox(height: 130,),
                          Text("djdjdjjdjdjdjdj"),
                          Text("price 2000"),
                        ],
                      )
                  ),
                  Container(
                      margin:const EdgeInsets.all(10),
                      padding:const EdgeInsets.all(15),
                      // width: size.width/2,
                      // height: size.height/3,
                      decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),  // لون الظل
                            spreadRadius: 0.2,                       // انتشار الظل
                            blurRadius: 6,                         // مقدار الضبابية
                            offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(ImageAssets.splashImage),
                          // fit: BoxFit.cover
                        ),
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.favorite_border ,color: ColorsManager.lightgray,),
                          SizedBox(height: 130,),
                          Text("djdjdjjdjdjdjdj"),
                          Text("price 2000"),
                        ],
                      )
                  ),
                  Container(
                      margin:const EdgeInsets.all(10),
                      padding:const EdgeInsets.all(15),
                      // width: size.width/2,
                      // height: size.height/3,
                      decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),  // لون الظل
                            spreadRadius: 0.2,                       // انتشار الظل
                            blurRadius: 6,                         // مقدار الضبابية
                            offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(ImageAssets.splashImagelog),
                          // fit: BoxFit.cover
                        ),
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.favorite_border ,color: ColorsManager.lightgray,),
                          SizedBox(height: 130,),
                          Text("djdjdjjdjdjdjdj"),
                          Text("price 2000"),
                        ],
                      )
                  ),
                  Container(
                      margin:const EdgeInsets.all(10),
                      padding:const EdgeInsets.all(15),
                      // width: size.width/2,
                      // height: size.height/3,
                      decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),  // لون الظل
                            spreadRadius: 0.2,                       // انتشار الظل
                            blurRadius: 6,                         // مقدار الضبابية
                            offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(ImageAssets.splashImagelog),
                          // fit: BoxFit.cover
                        ),
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.favorite_border ,color: ColorsManager.lightgray,),
                          SizedBox(height: 130,),
                          Text("djdjdjjdjdjdjdj"),
                          Text("price 2000"),
                        ],
                      )
                  ),
                  Container(
                      margin:const EdgeInsets.all(10),
                      padding:const EdgeInsets.all(15),
                      // width: size.width/2,
                      // height: size.height/3,
                      decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),  // لون الظل
                            spreadRadius: 0.2,                       // انتشار الظل
                            blurRadius: 6,                         // مقدار الضبابية
                            offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(ImageAssets.splashImagelog),
                          // fit: BoxFit.cover
                        ),
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.favorite_border ,color: ColorsManager.lightgray,),
                          SizedBox(height: 130,),
                          Text("djdjdjjdjdjdjdj"),
                          Text("price 2000"),
                        ],
                      )
                  ),
                  Container(
                      margin:const EdgeInsets.all(10),
                      padding:const EdgeInsets.all(15),
                      // width: size.width/2,
                      // height: size.height/3,
                      decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),  // لون الظل
                            spreadRadius: 0.2,                       // انتشار الظل
                            blurRadius: 6,                         // مقدار الضبابية
                            offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(ImageAssets.splashImagelog),
                          // fit: BoxFit.cover
                        ),
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.favorite_border ,color: ColorsManager.lightgray,),
                          SizedBox(height: 130,),
                          Text("djdjdjjdjdjdjdj"),
                          Text("price 2000"),
                        ],
                      )
                  ),
                  Container(
                      margin:const EdgeInsets.all(10),
                      padding:const EdgeInsets.all(15),
                      // width: size.width/2,
                      // height: size.height/3,
                      decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),  // لون الظل
                            spreadRadius: 0.2,                       // انتشار الظل
                            blurRadius: 6,                         // مقدار الضبابية
                            offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(ImageAssets.splashImagelog),
                          // fit: BoxFit.cover
                        ),
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.favorite_border ,color: ColorsManager.lightgray,),
                          SizedBox(height: 130,),
                          Text("djdjdjjdjdjdjdj"),
                          Text("price 2000"),
                        ],
                      )
                  ),
                  Container(
                      margin:const EdgeInsets.all(10),
                      padding:const EdgeInsets.all(15),
                      // width: size.width/2,
                      // height: size.height/3,
                      decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),  // لون الظل
                            spreadRadius: 0.2,                       // انتشار الظل
                            blurRadius: 6,                         // مقدار الضبابية
                            offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(ImageAssets.splashImagelog),
                          // fit: BoxFit.cover
                        ),
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.favorite_border ,color: ColorsManager.lightgray,),
                          SizedBox(height: 130,),
                          Text("djdjdjjdjdjdjdj"),
                          Text("price 2000"),
                        ],
                      )
                  ),

                  // Container(
                  //     margin:const EdgeInsets.all(10),
                  //     padding: EdgeInsets.all(15),
                  //     width: size.width,
                  //     height: size.height/3,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //       color: Colors.white,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.5),  // لون الظل
                  //           spreadRadius: 0.2,                       // انتشار الظل
                  //           blurRadius: 6,                         // مقدار الضبابية
                  //           offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                  //         ),
                  //       ],
                  //     ),
                  //     child:Column(
                  //       children: [
                  //         // image and icon container
                  //         Container(
                  //           height:80,
                  //           child:  Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Container(
                  //                 width: size.width/2,
                  //                 height: size.height,
                  //                 child: Row(
                  //                   children: [
                  //                     Container(
                  //                       margin: const EdgeInsets.only(left: 10),
                  //                       width: 60,
                  //                       height: 60,
                  //                       decoration: const BoxDecoration(
                  //                           shape: BoxShape.circle,
                  //                           // color: Colors.grey,
                  //                           image: DecorationImage(image: AssetImage('assets/ahmed.png'),
                  //                             fit: BoxFit.cover,
                  //                           )
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       margin: const EdgeInsets.only(top: 18,left: 5),
                  //                       child:const Column(
                  //                         children: [
                  //                           Text('Ahmed Qahtan',
                  //                             style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15),),
                  //                           Text('Flutter Developer',
                  //                             style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12),),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               IconButton(
                  //                   onPressed: (){},
                  //                   color: Colors.grey,
                  //                   icon:const Icon(Icons.add_circle)),
                  //             ],
                  //           ),
                  //         ),
                  //         const SizedBox(height: 5,),
                  //
                  //         Container(
                  //           // color: Colors.red,
                  //           child:const Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text('create flutter application', style: TextStyle(fontWeight: FontWeight.w700),),
                  //               Text('posted 1 hour ago',
                  //                 style: TextStyle(fontSize: 10,fontWeight: FontWeight.w700,color: Colors.grey),),
                  //             ],
                  //           ),
                  //         ),
                  //
                  //         // review container
                  //         SizedBox(
                  //           child: Row(
                  //             children: [
                  //               IconButton(
                  //                 onPressed:(){},
                  //                 icon:const Icon(Icons.star),color: Colors.yellow,),
                  //               const Text('4.5 review', style: TextStyle(fontWeight: FontWeight.w700),),
                  //             ],
                  //           ),
                  //         ),
                  //
                  //         const SizedBox(height: 40,),
                  //         Container(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               const SizedBox(
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text('500 RS' ,style:TextStyle(fontWeight: FontWeight.w700)),
                  //                     Text('to one project',style:TextStyle(color: Colors.grey)),
                  //                   ],
                  //                 ),
                  //               ),
                  //               ElevatedButton(
                  //                 onPressed: (){},
                  //                 child: Text('Show details',style:TextStyle(color: Colors.white)),
                  //                 style: ElevatedButton.styleFrom(
                  //                   backgroundColor: Colors.blue[300],
                  //                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // التحكم في المسافات الداخلية (حجم الزر)
                  //
                  //                   shape: RoundedRectangleBorder( // شكل الزر (حواف مستديرة)
                  //                     borderRadius: BorderRadius.circular(30), // تحديد نصف قطر الزوايا
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         )
                  //
                  //       ],
                  //     )
                  // ),
                  // Container(
                  //     margin:const EdgeInsets.all(10),
                  //     padding: EdgeInsets.all(15),
                  //     width: size.width,
                  //     height: size.height/3,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //       color: Colors.white,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.5),  // لون الظل
                  //           spreadRadius: 0.2,                       // انتشار الظل
                  //           blurRadius: 6,                         // مقدار الضبابية
                  //           offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                  //         ),
                  //       ],
                  //     ),
                  //     child:Column(
                  //       children: [
                  //         // image and icon container
                  //         Container(
                  //           height:80,
                  //           child:  Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Container(
                  //                 width: size.width/2,
                  //                 height: size.height,
                  //                 child: Row(
                  //                   children: [
                  //                     Container(
                  //                       margin: const EdgeInsets.only(left: 10),
                  //                       width: 60,
                  //                       height: 60,
                  //                       decoration: const BoxDecoration(
                  //                           shape: BoxShape.circle,
                  //                           // color: Colors.grey,
                  //                           image: DecorationImage(image: AssetImage('assets/ahmed.png'),
                  //                             fit: BoxFit.cover,
                  //                           )
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       margin: const EdgeInsets.only(top: 18,left: 5),
                  //                       child:const Column(
                  //                         children: [
                  //                           Text('Ahmed Qahtan',
                  //                             style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15),),
                  //                           Text('Flutter Developer',
                  //                             style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12),),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               IconButton(
                  //                   onPressed: (){},
                  //                   color: Colors.grey,
                  //                   icon:const Icon(Icons.add_circle)),
                  //             ],
                  //           ),
                  //         ),
                  //         const SizedBox(height: 5,),
                  //
                  //         Container(
                  //           // color: Colors.red,
                  //           child:const Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text('create flutter application', style: TextStyle(fontWeight: FontWeight.w700),),
                  //               Text('posted 1 hour ago',
                  //                 style: TextStyle(fontSize: 10,fontWeight: FontWeight.w700,color: Colors.grey),),
                  //             ],
                  //           ),
                  //         ),
                  //
                  //         // review container
                  //         SizedBox(
                  //           child: Row(
                  //             children: [
                  //               IconButton(
                  //                 onPressed:(){},
                  //                 icon:const Icon(Icons.star),color: Colors.yellow,),
                  //               const Text('4.5 review', style: TextStyle(fontWeight: FontWeight.w700),),
                  //             ],
                  //           ),
                  //         ),
                  //
                  //         const SizedBox(height: 40,),
                  //         Container(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               const SizedBox(
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text('500 RS' ,style:TextStyle(fontWeight: FontWeight.w700)),
                  //                     Text('to one project',style:TextStyle(color: Colors.grey)),
                  //                   ],
                  //                 ),
                  //               ),
                  //               ElevatedButton(
                  //                 onPressed: (){},
                  //                 child: Text('Show details',style:TextStyle(color: Colors.white)),
                  //                 style: ElevatedButton.styleFrom(
                  //                   backgroundColor: Colors.blue[300],
                  //                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // التحكم في المسافات الداخلية (حجم الزر)
                  //
                  //                   shape: RoundedRectangleBorder( // شكل الزر (حواف مستديرة)
                  //                     borderRadius: BorderRadius.circular(30), // تحديد نصف قطر الزوايا
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         )
                  //
                  //       ],
                  //     )
                  // ),
                  // Container(
                  //     margin:const EdgeInsets.all(10),
                  //     padding: EdgeInsets.all(15),
                  //     width: size.width,
                  //     height: size.height/3,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //       color: Colors.white,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.5),  // لون الظل
                  //           spreadRadius: 0.2,                       // انتشار الظل
                  //           blurRadius: 6,                         // مقدار الضبابية
                  //           offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                  //         ),
                  //       ],
                  //     ),
                  //     child:Column(
                  //       children: [
                  //         // image and icon container
                  //         Container(
                  //           height:80,
                  //           child:  Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Container(
                  //                 width: size.width/2,
                  //                 height: size.height,
                  //                 child: Row(
                  //                   children: [
                  //                     Container(
                  //                       margin: const EdgeInsets.only(left: 10),
                  //                       width: 60,
                  //                       height: 60,
                  //                       decoration: const BoxDecoration(
                  //                           shape: BoxShape.circle,
                  //                           // color: Colors.grey,
                  //                           image: DecorationImage(image: AssetImage('assets/ahmed.png'),
                  //                             fit: BoxFit.cover,
                  //                           )
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       margin: const EdgeInsets.only(top: 18,left: 5),
                  //                       child:const Column(
                  //                         children: [
                  //                           Text('Ahmed Qahtan',
                  //                             style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15),),
                  //                           Text('Flutter Developer',
                  //                             style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12),),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               IconButton(
                  //                   onPressed: (){},
                  //                   color: Colors.grey,
                  //                   icon:const Icon(Icons.add_circle)),
                  //             ],
                  //           ),
                  //         ),
                  //         const SizedBox(height: 5,),
                  //
                  //         Container(
                  //           // color: Colors.red,
                  //           child:const Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text('create flutter application', style: TextStyle(fontWeight: FontWeight.w700),),
                  //               Text('posted 1 hour ago',
                  //                 style: TextStyle(fontSize: 10,fontWeight: FontWeight.w700,color: Colors.grey),),
                  //             ],
                  //           ),
                  //         ),
                  //
                  //         // review container
                  //         SizedBox(
                  //           child: Row(
                  //             children: [
                  //               IconButton(
                  //                 onPressed:(){},
                  //                 icon:const Icon(Icons.star),color: Colors.yellow,),
                  //               const Text('4.5 review', style: TextStyle(fontWeight: FontWeight.w700),),
                  //             ],
                  //           ),
                  //         ),
                  //
                  //         const SizedBox(height: 40,),
                  //         Container(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               const SizedBox(
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text('500 RS' ,style:TextStyle(fontWeight: FontWeight.w700)),
                  //                     Text('to one project',style:TextStyle(color: Colors.grey)),
                  //                   ],
                  //                 ),
                  //               ),
                  //               ElevatedButton(
                  //                 onPressed: (){},
                  //                 child: Text('Show details',style:TextStyle(color: Colors.white)),
                  //                 style: ElevatedButton.styleFrom(
                  //                   backgroundColor: Colors.blue[300],
                  //                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // التحكم في المسافات الداخلية (حجم الزر)
                  //
                  //                   shape: RoundedRectangleBorder( // شكل الزر (حواف مستديرة)
                  //                     borderRadius: BorderRadius.circular(30), // تحديد نصف قطر الزوايا
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         )
                  //
                  //       ],
                  //     )
                  // ),
                  // Container(
                  //     margin:const EdgeInsets.all(10),
                  //     padding: EdgeInsets.all(15),
                  //     width: size.width,
                  //     height: size.height/3,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //       color: Colors.white,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.5),  // لون الظل
                  //           spreadRadius: 0.2,                       // انتشار الظل
                  //           blurRadius: 6,                         // مقدار الضبابية
                  //           offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                  //         ),
                  //       ],
                  //     ),
                  //     child:Column(
                  //       children: [
                  //         // image and icon container
                  //         Container(
                  //           height:80,
                  //           child:  Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Container(
                  //                 width: size.width/2,
                  //                 height: size.height,
                  //                 child: Row(
                  //                   children: [
                  //                     Container(
                  //                       margin: const EdgeInsets.only(left: 10),
                  //                       width: 60,
                  //                       height: 60,
                  //                       decoration: const BoxDecoration(
                  //                           shape: BoxShape.circle,
                  //                           // color: Colors.grey,
                  //                           image: DecorationImage(image: AssetImage('assets/ahmed.png'),
                  //                             fit: BoxFit.cover,
                  //                           )
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       margin: const EdgeInsets.only(top: 18,left: 5),
                  //                       child:const Column(
                  //                         children: [
                  //                           Text('Ahmed Qahtan',
                  //                             style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15),),
                  //                           Text('Flutter Developer',
                  //                             style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12),),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               IconButton(
                  //                   onPressed: (){},
                  //                   color: Colors.grey,
                  //                   icon:const Icon(Icons.add_circle)),
                  //             ],
                  //           ),
                  //         ),
                  //         const SizedBox(height: 5,),
                  //
                  //         Container(
                  //           // color: Colors.red,
                  //           child:const Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text('create flutter application', style: TextStyle(fontWeight: FontWeight.w700),),
                  //               Text('posted 1 hour ago',
                  //                 style: TextStyle(fontSize: 10,fontWeight: FontWeight.w700,color: Colors.grey),),
                  //             ],
                  //           ),
                  //         ),
                  //
                  //         // review container
                  //         SizedBox(
                  //           child: Row(
                  //             children: [
                  //               IconButton(
                  //                 onPressed:(){},
                  //                 icon:const Icon(Icons.star),color: Colors.yellow,),
                  //               const Text('4.5 review', style: TextStyle(fontWeight: FontWeight.w700),),
                  //             ],
                  //           ),
                  //         ),
                  //
                  //         const SizedBox(height: 40,),
                  //         Container(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               const SizedBox(
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text('500 RS' ,style:TextStyle(fontWeight: FontWeight.w700)),
                  //                     Text('to one project',style:TextStyle(color: Colors.grey)),
                  //                   ],
                  //                 ),
                  //               ),
                  //               ElevatedButton(
                  //                 onPressed: (){},
                  //                 child: Text('Show details',style:TextStyle(color: Colors.white)),
                  //                 style: ElevatedButton.styleFrom(
                  //                   backgroundColor: Colors.blue[300],
                  //                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // التحكم في المسافات الداخلية (حجم الزر)
                  //
                  //                   shape: RoundedRectangleBorder( // شكل الزر (حواف مستديرة)
                  //                     borderRadius: BorderRadius.circular(30), // تحديد نصف قطر الزوايا
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         )
                  //
                  //       ],
                  //     )
                  // ),

                ],
              ),
            )
          ],
        ),
    ),
    );
  }
}
