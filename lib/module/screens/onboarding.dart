import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber_clone/module/user/login/login.dart';
import 'package:uber_clone/shared/companents/companents.dart';

import '../../shared/companents/constans.dart';

class OnBoarding extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: onboardingColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: onboardingColor,
          statusBarIconBrightness: Brightness.light
        ),
      ),
      backgroundColor: onboardingColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Center(child: Text('Smart Driver',style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white
            ),))),
            Expanded(
                flex: 2,
                child: Image(image: AssetImage('assets/images/driving.png'))),
            Expanded(child: Center(child: Text('Move with safety',style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white
            ),))),
            GestureDetector(
              onTap: (){
                navigateTo(context, LoginScreen());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color:Colors.black,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                              Text('Get Started',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: Colors.white,
                                  fontSize: 25
                              ),),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_forward,color: Colors.white,size: 30,),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
