import 'package:flutter/material.dart';
import '../resources/color_manager.dart';


class ContainerCarCard extends StatelessWidget {

  String? img;
  String? name;
  double? price;

  ContainerCarCard({super.key, required this.img ,required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:const EdgeInsets.all(10),
        padding:const EdgeInsets.only(left: 5,top: 5),
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
          image:  DecorationImage(
            image: AssetImage(img!),
            // fit: BoxFit.cover
          ),
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: (){

                },
                icon:Icon(Icons.favorite_border ),
                color: ColorsManager.lightgray,
            ),
            const SizedBox(height: 115,),
            Text(name!),
            Text("${price!}"),
          ],
        )
    );
  }
}
