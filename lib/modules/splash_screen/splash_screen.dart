import 'package:catrx/shared/constant.dart';
import 'package:catrx/style/themes/themes_conestants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    navigateToOpeningScreen();
  }

  void navigateToOpeningScreen() async{
    await Future.delayed(const Duration(seconds: 3),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (BuildContext context) => openingScreen)
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: defaultColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag,color: Colors.white,size: 150,),
            SizedBox(height: 20,),
            Text("Welcome to CARTX",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
