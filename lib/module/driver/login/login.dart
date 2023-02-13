import 'package:auth_buttons/auth_buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uber_clone/layout/layout.dart';
import 'package:uber_clone/module/driver/login/cubit/logincubit.dart';
import 'package:uber_clone/module/driver/login/cubit/loginstate.dart';
import 'package:uber_clone/module/driver/register/registerscreen.dart';

import 'package:uber_clone/shared/companents/companents.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:uber_clone/shared/companents/constans.dart';
import 'package:uber_clone/shared/networks/local/cache_helper.dart';

class LoginDriverScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>LoginDriverCubit(),
    child: BlocConsumer<LoginDriverCubit,LoginDriverState>(
      listener:(context,state){
        if(state is LoginDriverErrorState)
          {
            toastShow(msg: state.error, state: toastStatus.ERROR);
          }
        if(state is LoginDriverSucessState||state is GoogleSuccessState)
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
                                suffix: LoginDriverCubit.get(context).suffix,
                                visblepass: ()=>LoginDriverCubit.get(context).changeVisibilty(),
                                isPassword: LoginDriverCubit.get(context).isPassword
                            ),
                            SizedBox(height: 15,),
                            ConditionalBuilder(condition: state is !LoginDriverLoadingState,
                                builder:(context)=>defaultButton(function: (){
                                    if(formkey.currentState!.validate()) {
                                      LoginDriverCubit.get(context).userLoginDriver(
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
                                Text('Forgotten your LoginDriver details?',style: Theme.of(context).textTheme.caption,),
                                TextButton(onPressed: (){}, child:Text('Get help with logging in .',style: Theme.of(context).textTheme.caption!.copyWith(
                                  color: Colors.indigoAccent
                                ),),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    navigateTo(context, RegisterDriverScreen());
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




