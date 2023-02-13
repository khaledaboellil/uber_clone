import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/models/usermodel.dart';
import 'package:uber_clone/module/driver/login/cubit/loginstate.dart';

import '../../../../shared/companents/constans.dart';

class LoginDriverCubit extends Cubit<LoginDriverState>{
  LoginDriverCubit() : super(LoginDriverInitialState());
  static LoginDriverCubit get(context)=> BlocProvider.of(context) ;

  void userLoginDriver(
      {
        required String email ,
        required String password,
      }
      ){
    emit(LoginDriverLoadingState()) ;
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password).then(
            (value){
          print(value.user!.emailVerified) ;
          uId=value.user!.uid;
          emit(LoginDriverSucessState());
        }).catchError((e){
      print(e.toString());
      emit(LoginDriverErrorState(e.toString()));
    });
  }
  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changeVisibilty(){

    isPassword = ! isPassword ;
    suffix = isPassword ? Icons. visibility_off_outlined: Icons.visibility_outlined ;

    emit(LoginDriverChangeVisbility());
  }

  void setUser(
      {
        required String sign,
        required String ?name,
        required String email,
        required String uId,
        required String phone,
        bool isVerified = false ,
        image = "" ,
        coverImage="",
        bio="Write your bio" ,

      }
      ){

    UserModel model = UserModel(name!, phone, email, uId,isVerified,image,coverImage,bio,token) ;
    FirebaseFirestore.instance.collection('users').doc(email).set(model.toMap()).then(
            (value){
              savedEmail = email ;
          emit(GoogleSuccessState()) ;
        }).catchError((e){
      print(e.toString());
      emit(GoogleErrorState(e.toString())) ;
    });
  }
}