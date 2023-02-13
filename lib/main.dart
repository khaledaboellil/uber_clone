import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uber_clone/layout/cubit/layoutcubit.dart';
import 'package:uber_clone/layout/layout.dart';
import 'package:uber_clone/module/screens/onboarding.dart';
import 'package:uber_clone/module/updatescreen.dart';
import 'package:uber_clone/shared/companents/constans.dart';
import 'package:uber_clone/shared/networks/local/cache_helper.dart';
import 'package:uber_clone/shared/styles/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
Future<bool> remoteconfig()async{
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appVersion = packageInfo.version ;
  print("This is app version : ${appVersion}");
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 60),
      minimumFetchInterval: Duration(seconds: 1)));
  await remoteConfig.fetchAndActivate();
  String remoteConfigVersion =remoteConfig.getString('appVersion');
  print("This is remote app version : ${remoteConfigVersion}");
  if(remoteConfigVersion.compareTo(appVersion)==0)
    return true ;
  else
    return false ;
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  savedEmail = CacheHelper.loadStringData(key:'email') ??'' ;
  bool compare = true ;
  bool result = await InternetConnectionChecker().hasConnection;
  if(result==true)
    compare = await remoteconfig();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  token = await FirebaseMessaging.instance.getToken()??'';
  runApp(MyApp(compare));
}
class MyApp extends StatelessWidget {
  bool ?compare ;
  MyApp(this.compare);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>LayoutCubit(),
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lighttheme,
        home:compare==true? savedEmail==''?OnBoarding():LayoutScreen():UpdateScreen()

      ),
    );
  }
}



