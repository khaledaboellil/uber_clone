import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/layout/cubit/layoutcubit.dart';
import 'package:uber_clone/layout/cubit/layoutstate.dart';


class LayoutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        LayoutCubit.get(context).getMyUserData();
        LayoutCubit.get(context).enableLoacation();
        return BlocConsumer<LayoutCubit,LayoutState>(
            listener:(context,state){},
            builder: (context,state){
              return Scaffold(
                body: LayoutCubit.get(context).screens[LayoutCubit.get(context).current_Index],
                bottomNavigationBar: BottomNavigationBar(
                    currentIndex: LayoutCubit.get(context).current_Index,
                    onTap: (index){
                      LayoutCubit.get(context).changeNavBar(index);
                    },
                    items: [
                      BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
                      BottomNavigationBarItem(icon: Icon(Icons.apps_outlined),label: 'Services'),
                      BottomNavigationBarItem(icon: Icon(Icons.energy_savings_leaf),label: 'Activity'),
                      BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Account'),
                    ]),
              );

            },
        );
      }
    );
  }
}
