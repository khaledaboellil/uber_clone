import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/module/user/register/cubit/registerstate.dart';

import '../../../../models/usermodel.dart';
import '../../../../shared/companents/constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context)=> BlocProvider.of(context) ;

  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password).then((value){
      print('ana hna hna') ;
      print(value.user!.email);
      print(value.user!.uid);
      print(token);
      setUser(name: name, email: email, uId: value.user!.uid, phone: phone) ;
      emit(RegisterSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(RegisterErrorState(e.toString()));
    });

  }

  void setUser(
      {
        required String name,
        required String email,
        required String uId,
        required String phone,
        bool isVerified = false ,
        image = "https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg?w=900&t=st=1671115957~exp=1671116557~hmac=1a38dcd716c98e4b6ff58f20977f2f2f8a0c876be42d3743ea4f01a4100560e2" ,
        coverImage="https://img.freepik.com/free-photo/indian-meal-with-rice-sari_23-2148747624.jpg?w=900&t=st=1671116080~exp=1671116680~hmac=577a99bc76d5adbf4b4885c5a75e6467190bd0a5240640ce2169b6491be8c899",
        bio="Write your bio" ,

      }
      ){
    emit(RegisterLoadingState());
    UserModel model = UserModel(name, phone, email, uId,isVerified,image,coverImage,bio,token) ;
    FirebaseFirestore.instance.collection('users').doc(email).set(model.toMap()).then(
            (value){
          emit(RegisterSuccessState()) ;
        }).catchError((e){
      print(e.toString());
      emit(RegisterErrorState(e.toString())) ;
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changeVisibilty(){

    isPassword = ! isPassword ;
    suffix = isPassword ? Icons. visibility_off_outlined: Icons.visibility_outlined ;

    emit(RegisterChangeVisbility());
  }
}