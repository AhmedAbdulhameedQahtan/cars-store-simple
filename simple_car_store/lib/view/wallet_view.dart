import 'package:flutter/material.dart';
import 'package:simple_car_store/resources/color_manager.dart';
import 'package:simple_car_store/resources/font_manager.dart';

class WalletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Wallet',
          style: TextStyle(color: ColorsManager.black,fontWeight: FontWeight.bold,fontSize: FontSize.s22),),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: Column(
        children: [

          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text("Avilable palance",
                    style: TextStyle(color: ColorsManager.lightgray,fontWeight: FontWeight.bold,),
            ),
          ),

          Padding(
            padding:const EdgeInsets.all(0),
            child: Text("\$70,420",
              style: TextStyle(color: ColorsManager.black,fontWeight: FontWeight.bold,fontSize: FontSize.s35),
            ),
          ),

          Padding(
            padding:const EdgeInsets.all(30),
            child: Container(
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: const Padding(
                padding:  EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'VISA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        Icon(
                          Icons.credit_card,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Card Number
                    Text(
                      '**** **** **** 1234',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Cardholder Name and Expiry Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cardholder',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Ahmed Qahtan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expiry',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '12/25',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          ],
      )
    );
  }
}

void main() => runApp(MaterialApp(home: WalletView()));

