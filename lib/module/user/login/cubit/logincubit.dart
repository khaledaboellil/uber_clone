import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_clone/module/user/login/cubit/loginstate.dart';

import '../../../../models/usermodel.dart';
import '../../../../shared/companents/companents.dart';
import '../../../../shared/companents/constans.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context)=> BlocProvider.of(context) ;

  void userLogin(
      {
        required String email ,
        required String password,
      }
      ){
    emit(LoginLoadingState()) ;
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password).then(
            (value){
          print(value.user!.emailVerified) ;
          uId=value.user!.uid;
          emit(LoginSucessState());
        }).catchError((e){
      print(e.toString());
      emit(LoginErrorState(e.toString()));
    });
  }
  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changeVisibilty(){

    isPassword = ! isPassword ;
    suffix = isPassword ? Icons. visibility_off_outlined: Icons.visibility_outlined ;

    emit(LoginChangeVisbility());
  }
  Future signInWithFacebook(BuildContext context) async {
    emit(FacebookLoadingState());
    final LoginResult loginResult = await FacebookAuth.instance.login(
      //  loginBehavior: LoginBehavior.deviceAuth,
        permissions: ['email', 'public_profile', 'user_birthday']);
    print(loginResult.status);
    final OAuthCredential credential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    await FirebaseAuth.instance.signInWithCredential(credential).then((value){
      if(value.user!.uid!=null)
      uId = value.user!.uid;
    }).catchError((e)async{
      print(e.code);
      if (e.code == 'account-exists-with-different-credential'){
        String email = e.email;
        AuthCredential pendingCredential = e.credential;
        print('this is ==========${pendingCredential}');
        List<String> userSignInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        print(userSignInMethods.first);
        if (userSignInMethods.first == 'google.com') {

           }
      }
    });
    final userData = await FacebookAuth.instance.getUserData();

    print(userData['email']);
    print(userData['name']);
    print(userData['picture']["data"]['url']);

    setUser(sign:'facebook',name: userData['name'], email:userData['email'] , uId: uId, phone: '',image:userData['picture']["data"]['url'],isVerified: true );

  }
  Future signInWithGoogle(BuildContext context) async {
    emit(GoogleLoadingState());
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((value){
      if(value.user!.uid!=null)
      uId = value.user!.uid;
    }).catchError((e) async {
      print(e.code);
      if (e.code == 'account-exists-with-different-credential'){
        String email = e.email;
        AuthCredential pendingCredential = e.credential;
         List<String> userSignInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
         print(userSignInMethods.first);
      //   if (userSignInMethods.first == 'facebook.com') {
      //     // Create a new Facebook credential
      //     String accessToken = await triggerFacebookAuthentication();
      //     var facebookAuthCredential = FacebookAuthProvider.credential(accessToken);
      //     // Sign the user in with the credential
      //     UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      //     // Link the pending credential with the existing account
      //     await userCredential.user!.linkWithCredential(pendingCredential);
      //     // Success! Go back to your application flow
      //   }
      }
    });
    print(googleUser!.email);
    print(googleUser.displayName);
    print(googleUser.photoUrl);

    setUser(sign:'google',name: googleUser.displayName, email:googleUser.email , uId: uId, phone: '',image:googleUser.photoUrl,isVerified: true );

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