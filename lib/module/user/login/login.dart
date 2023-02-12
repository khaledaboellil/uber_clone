import 'package:auth_buttons/auth_buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_clone/layout/layout.dart';
import 'package:uber_clone/module/user/login/cubit/logincubit.dart';
import 'package:uber_clone/module/user/login/cubit/loginstate.dart';
import 'package:uber_clone/module/user/register/registerscreen.dart';
import 'package:uber_clone/shared/companents/companents.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:uber_clone/shared/companents/constans.dart';
import 'package:uber_clone/shared/networks/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>LoginCubit(),
    child: BlocConsumer<LoginCubit,LoginState>(
      listener:(context,state){
        if(state is LoginErrorState)
          {
            toastShow(msg: state.error, state: toastStatus.ERROR);
          }
        if(state is LoginSucessState||state is GoogleSuccessState)
        {
          CacheHelper.saveData(key: 'email', value: savedEmail);
          navigatePushAndDelete(context, LayoutScreen());
        }
      }
      ,builder: (context,state){
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Smart Driver",style:Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontFamily: 'Billabong',
                              fontSize: 55
                            ),),
                            SizedBox(height: 20,),
                            defaultTextForm(
                                validate: (value) {
                                  if(value!.isEmpty)
                                    return 'please enter your email';
                                } ,
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                label: 'Email',
                                prefix: Icons.email),
                            SizedBox(height: 15,),
                            defaultTextForm(
                                validate: (value) {
                                  if(value!.isEmpty)
                                    return 'please enter your password';
                                } ,
                                controller: passwordController,
                                type: TextInputType.name,
                                label: 'Password',
                                prefix: Icons.lock,
                                suffix: LoginCubit.get(context).suffix,
                                visblepass: ()=>LoginCubit.get(context).changeVisibilty(),
                                isPassword: LoginCubit.get(context).isPassword
                            ),
                            SizedBox(height: 15,),
                            ConditionalBuilder(condition: state is !LoginLoadingState,
                                builder:(context)=>defaultButton(function: (){
                                    if(formkey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password:passwordController.text);
                                    }
                                },
                                    text: 'Log In',
                                    radius: 5
                                ), fallback: (context)=>Center(child: CircularProgressIndicator(),)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Forgotten your Login details?',style: Theme.of(context).textTheme.caption,),
                                TextButton(onPressed: (){}, child:Text('Get help with logging in .',style: Theme.of(context).textTheme.caption!.copyWith(
                                  color: Colors.indigoAccent
                                ),),)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Container(
                                width:double.infinity ,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text('OR'),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            ConditionalBuilder(condition:state is !FacebookLoadingState,
                                builder: (context)=> FacebookAuthButton(
                                  onPressed: () {
                                    LoginCubit.get(context).signInWithFacebook(context);
                                  },
                                  style: AuthButtonStyle(
                                      iconColor: Colors.white,
                                      textStyle: TextStyle(color: Colors.white,
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.bold
                                      ),
                                      buttonColor: Colors.blue,
                                      width: double.infinity ,
                                      iconType: AuthIconType.outlined
                                  ),
                                ),
                                fallback: (context)=>Center(child: CircularProgressIndicator(),)
                            ),
                            ConditionalBuilder(condition:state is !GoogleLoadingState,
                                builder: (context)=>GoogleAuthButton(
                                  onPressed: () {
                                    LoginCubit.get(context).signInWithGoogle(context);
                                  },
                                  style: AuthButtonStyle(
                                      textStyle: TextStyle(color: Colors.white,
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.bold
                                      ),
                                      buttonColor: Colors.blue,
                                      width: double.infinity ,
                                      iconType: AuthIconType.outlined
                                  ),
                                ),
                                fallback: (context)=>Center(child: CircularProgressIndicator(),)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    navigateTo(context, RegisterScreen());
                  },
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',style: Theme.of(context).textTheme.caption,),
                            Text('Sign up',style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.indigoAccent
                            ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
    ) ,
    );
  }

}




