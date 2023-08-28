import 'package:catrx/shared/components.dart';
import 'package:catrx/style/themes/themes_conestants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/onBoarding-models.dart';
import '../../shared/local/sheared_preferances.dart';
import '../login/login_screen.dart';


class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  List<BoardingModel> onBoardingPagesList = [
BoardingModel(
    boardingImage: 'assets/images/friends.jpg',
    boardingTitle: 'On Boarding Title 1',
    boardingBody: 'On Boarding Body 1'),
BoardingModel(
    boardingImage: 'assets/images/friends.jpg',
    boardingTitle: 'On Boarding Title 2',
    boardingBody: 'On Boarding Body 2'),
BoardingModel(
    boardingImage: 'assets/images/friends.jpg',
    boardingTitle: 'On Boarding Title 3',
    boardingBody: 'On Boarding Body 3'),
  ];
   PageController boardingController = PageController();
   bool isLast = false;

   void submit(BuildContext context){
     CacheHelper.saveData(key: "onBoarding", value: true).then((value)
     {
       Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(
               builder: (context) => LoginScreen()
           ),
               (route) => false
       );

     });
   }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:  [
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: TextButton(
                      onPressed: (){
                        submit(context);
                      },
                      child:  Text('Skip',style: TextStyle(color: defaultColor,fontSize: 23),)),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                onPageChanged: (index){
                  if(index == onBoardingPagesList.length - 1 )
                  {
                    isLast = true;
                  }
                  else
                  {
                    isLast = false;
                  }
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder:(context , index)=> boardingUnit(onBoardingPagesList[index]),
                itemCount: onBoardingPagesList.length,
              ),
            ),
            const SizedBox(height: 20,),
            SmoothPageIndicator(
              controller: boardingController,
              count: onBoardingPagesList.length,
              effect:  ExpandingDotsEffect(
                activeDotColor: defaultColor,
                dotColor: Colors.grey,
                dotHeight: 10,
                dotWidth: 28,
                spacing: 10,
              ),
            ),
            const SizedBox(height: 30,),

            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  if(isLast)
                  {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()
                        ),
                            (route){
                          return false;
                        }
                    );
                  }
                  else
                  {
                    boardingController.nextPage(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }
                },
                child: Text("Next",style: TextStyle(fontSize: 20),),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  backgroundColor: defaultColor,

                ),

              ),
            ),
            const SizedBox(height: 70,),

            /*FloatingActionButton(
              onPressed: (){
                if(isLast)
                {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()
                      ),
                          (route){
                        return false;
                      }
                  );
                }
                else
                {
                  boardingController.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.fastLinearToSlowEaseIn);
                }
              },
              backgroundColor: Colors.amber,
              child: const Icon(Icons.arrow_forward_ios_outlined),
            ),*/

          ],
        ),
      ),
    );
  }
}





