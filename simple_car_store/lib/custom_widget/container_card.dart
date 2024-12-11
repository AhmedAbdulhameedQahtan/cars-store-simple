import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../view/details_view.dart';

class ContainerCarCard extends StatefulWidget {
  String? img;
  Map<String,dynamic>? carDetails;
  String? price;
  bool? isFavorite;


  ContainerCarCard({super.key, required this.img ,required this.carDetails, required this.price,required this.isFavorite});

  @override
  State<ContainerCarCard> createState() => _ContainerCarCardState();
}

class _ContainerCarCardState extends State<ContainerCarCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsView.details(img: widget.img, carDetails: widget.carDetails, price: widget.price,)));
      },
      child: Container(
          margin:const EdgeInsets.all(10),
          padding: context.locale.languageCode == 'en' ?const EdgeInsets.only(left: 5,top: 5):const EdgeInsets.only(right: 5,top: 5),
          decoration: BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular(15)),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),  // لون الظل
                spreadRadius: 0.2,                       // انتشار الظل
                blurRadius: 6,                         // مقدار الضبابية
                offset:const Offset(0, 0),                  // إزاحة الظل (x, y)
              ),
            ],
            image:  DecorationImage(
              image: AssetImage(widget.img!),
            ),
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: (){
                  setState(() {
                    widget.isFavorite =! widget.isFavorite!;
                  });

                },
                icon:const Icon(Icons.favorite ),
                color: widget.isFavorite! ? ColorsManager.error: ColorsManager.lightgray,

              ),

              const SizedBox(height: 120,),
              Text(widget.carDetails?["model"],style: Theme.of(context).textTheme.bodySmall,),
              Text("\$ ${widget.price!}",style: Theme.of(context).textTheme.bodySmall,),
            ],
          )
      ),
    );
  }
}

