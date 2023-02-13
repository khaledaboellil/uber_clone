import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/models/usermodel.dart';
import 'package:uber_clone/module/user/activity.dart';
import 'package:uber_clone/module/user/profile.dart';
import 'package:uber_clone/shared/companents/constans.dart';
import '../../module/user/Home.dart';
import '../../module/user/services.dart';
import 'layoutstate.dart';
import 'package:app_settings/app_settings.dart';
class LayoutCubit extends Cubit<LayoutState>{
  LayoutCubit() : super(LayoutInitialState());
  static LayoutCubit get(context)=> BlocProvider.of(context) ;
  List<Widget>screens=[HomeScreen(),ServicesScreen(),ActivityScreen(),ProfileScreen()];
  int current_Index=0 ;
  void changeNavBar(index){

    current_Index =index ;
    emit(ChangeNavBarState());
  }

  void getMyUserData()
  {
    emit(GetUserLoadingStates()) ;
    FirebaseFirestore.instance.collection('users').doc(savedEmail).snapshots().listen((value) {
      if(value.data()!= null)
        myUser = UserModel.fromjson(value.data()) ;
      print(myUser!.email) ;
      emit(GetUserSucessfullStates());
    }) ;
  }

  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  CameraPosition cameraPosition = CameraPosition(target: LatLng(37.43296265331129, -122.08832357078792));

   determinePosition() async {

    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position currentPosition = await Geolocator.getCurrentPosition();
    LatLng latLngPosition =LatLng(currentPosition.latitude,currentPosition.longitude);
    CameraPosition camera = CameraPosition(target: latLngPosition,zoom: 20);
    final GoogleMapController control = await controller.future;
    control.animateCamera(CameraUpdate.newCameraPosition(camera));
    emit(GetCurrentLocationStates());
  }

  enableLoacation() async{
    //AppSettings.openLocationSettings();
  }
}