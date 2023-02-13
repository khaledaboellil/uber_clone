import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_clone/layout/cubit/layoutcubit.dart';
import 'package:uber_clone/layout/cubit/layoutstate.dart';
class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
        listener:(context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('SmartDriver',style:Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontFamily: "Billabong"
              ),
              ),
              centerTitle: true,
            ),
            body: Stack(
              alignment: Alignment.topRight,
              children: [

                GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  initialCameraPosition: LayoutCubit.get(context).cameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    LayoutCubit.get(context).controller.complete(controller);

                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: (){
                      LayoutCubit.get(context).determinePosition();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.location_searching),
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
    );
  }
}