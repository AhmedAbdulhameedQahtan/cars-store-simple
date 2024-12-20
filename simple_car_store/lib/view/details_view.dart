import 'package:flutter/material.dart';
import 'package:simple_car_store/resources/assets_manager.dart';
import 'package:simple_car_store/resources/font_manager.dart';
import '../resources/color_manager.dart';
import 'wallet_view.dart';

class DetailsView extends StatefulWidget {
  String? img;
  Map<String,dynamic>? carDetails;
  String? price;

  DetailsView({super.key});

  DetailsView.details(
      {super.key, required this.img, required this.carDetails, required this.price});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.lightBlack,
        elevation: 0,
      ),
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
                children: [
          Container(
              height: size.height / 2.5,
              width: size.width,
              decoration: BoxDecoration(
                color: ColorsManager.lightBlack,
              ),
              child: Center(
                child: Image.asset(
                  widget.img!,
                  width: 350,
                  height: 350,
                ),
              )),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height - (size.height / 2.1),
              width: size.width,
              margin: const EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                borderRadius:const BorderRadius.only(topRight:  Radius.circular(30),topLeft:  Radius.circular(30)),
                color: ColorsManager.white,
              ),

              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // car name and review
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(widget.carDetails?["model"],
                          style:Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30)
                      // TextStyle(fontWeight: FontWeighManager.bold,fontSize: FontSize.s30),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: (){},
                                icon:const Icon(Icons.star ,color: Colors.yellow,)
                            ),
                             Text("(4.5)",style:Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                    ),
                  ),

                 // details text
                  Padding(
                      padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                    // child: Text("Jeep Rubicon Off-road Petrol V6 Jeep Rubicon Off-road Petrol V6"),
                    child: Text(""
                        "${widget.carDetails?["brand"]} "
                        "${widget.carDetails?["model"]} "
                        "${widget.carDetails?["type"]} "
                        "(${widget.carDetails?["fuelType"]}) ",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),

                  // Features container
                  Container(
                    width: size.width,
                    height: size.height/3.7,
                    // color: ColorsManager.lightgray200,
                    padding:const  EdgeInsets.only(top: 10,left: 15,right: 15),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("Features",style: Theme.of(context).textTheme.titleLarge),
                        Container(
                          padding: const EdgeInsets.all(3),
                          // color: ColorsManager.lightBlack,
                          width: size.width,
                          height: size.height/4.5,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorsManager.lightgray200,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),  // لون الظل
                                      spreadRadius: 0.6,                       // انتشار الظل
                                      blurRadius: 1,                         // مقدار الضبابية
                                      offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                                    ),
                                  ],
                                ),
                                width: size.width/4,
                                height: size.height/5.5,
                                padding: const EdgeInsets.only(left: 6),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                     Icon(Icons.airline_seat_recline_extra_sharp,color: ColorsManager.darkgray,),
                                     Text("Total Capacity",style: Theme.of(context).textTheme.bodyMedium,),
                                    Text("${widget.carDetails?["seatingCapacity"]} seat",style:const TextStyle(fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorsManager.lightgray200,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),  // لون الظل
                                      spreadRadius: 0.6,                       // انتشار الظل
                                      blurRadius: 1,                         // مقدار الضبابية
                                      offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                                    ),
                                  ],
                                ),
                                width: size.width/4,
                                height: size.height/5.5,
                                padding: const EdgeInsets.only(left: 6),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                     Icon(Icons.speed,color: ColorsManager.darkgray,),
                                     const Text("Highest speed"),
                                    Text("${widget.carDetails?["maxSpeed"]} KM/H",style:const TextStyle(fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorsManager.lightgray200,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),  // لون الظل
                                      spreadRadius: 0.6,                       // انتشار الظل
                                      blurRadius: 1,                         // مقدار الضبابية
                                      offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
                                    ),
                                  ],
                                ),
                                width: size.width/4,
                                height: size.height/5.5,
                                padding: const EdgeInsets.only(left: 6),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                     Icon(Icons.directions_car_filled,color: ColorsManager.darkgray,),
                                    const Text("Engine "),
                                    Text("${widget.carDetails?["engine"]}",style:const TextStyle(fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                  ),

                //   price and button container
                  Container(
                     // color: ColorsManager.primary,
                    width: size.width,
                    height: size.height/9,
                    padding:const  EdgeInsets.only(left: 0,right: 0),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // price text
                         Container(
                           padding:const  EdgeInsets.only(top:25),
                          child: const Column(
                            children: [
                              Text("price"),
                              Text("\$18,500",style: TextStyle(fontWeight: FontWeighManager.bold,fontSize: FontSize.s20)),
                            ],
                          ),
                        ),

                        // elevation button to buy
                        Container(
                          width: size.width /1.5,
                          padding:const  EdgeInsets.only(top:15),

                          // margin: const EdgeInsets.only(left: 20,right: 20),
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletView()));

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.primary,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10), // التحكم في المسافات الداخلية (حجم الزر)
                              shape: RoundedRectangleBorder( // شكل الزر (حواف مستديرة)
                                borderRadius: BorderRadius.circular(20), // تحديد نصف قطر الزوايا
                              ),
                            ),
                            child:   Text('Buy now',style: TextStyle(color:ColorsManager.white,fontWeight: FontWeighManager.bold),),

                          ),
                        ),

                      ],
                    ),
                  )

                ],
              ) ,

            ),
          ),

                ],
              ),
        ));
  }
}
