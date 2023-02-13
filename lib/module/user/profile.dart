
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/module/screens/onboarding.dart';
import 'package:uber_clone/shared/companents/companents.dart';
import 'package:uber_clone/shared/companents/constans.dart';
import 'package:uber_clone/shared/networks/local/cache_helper.dart';

class ProfileScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Khaled Aboellil',style: Theme.of(context).textTheme.bodyText1,),
                  Spacer(),
                  CircleAvatar(
                    radius: 40,
                    //backgroundImage: NetworkImage('${model.profileImage}'),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: "${myUser!.image}",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ) ,
              TextButton(onPressed: (){
                CacheHelper.removeData(key: 'email');
                navigatePushAndDelete(context, OnBoarding());
              }, child: Text('Log Out'))
            ],
          ),
        ),
      ),
    );
  }
}
