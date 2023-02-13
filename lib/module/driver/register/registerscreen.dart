import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/module/driver/login/login.dart';
import 'package:uber_clone/module/driver/register/cubit/registercubit.dart';
import 'package:uber_clone/module/driver/register/cubit/registerstate.dart';

import 'package:uber_clone/shared/companents/companents.dart';

class RegisterDriverScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController() ;
  var passwordController = TextEditingController() ;
  var repasswordController = TextEditingController() ;
  var phoneController=TextEditingController();
  var nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>RegisterDriverCubit(),
      child: BlocConsumer<RegisterDriverCubit,RegisterDriverState>(
       listener: (context,state){
         if(state is RegisterDriverErrorState){
           toastShow(msg: state.error, state: toastStatus.ERROR);
         }
         if(state is RegisterDriverSuccessState)
         {
           toastShow(msg: 'account has successfully RegisterDrivered please Login in  ', state: toastStatus.SUCESS) ;
           navigatePushAndDelete(context,LoginDriverScreen());
         }
       },
        builder: (context,state){
         return Scaffold(
           appBar: AppBar(),
           body: Padding(
             padding: const EdgeInsets.only(top: 60.0,left: 15,right: 15),
             child: SingleChildScrollView(
               child: Form(
                 key: formkey,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text('RegisterDriver',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                       fontFamily: 'Billabong',
                       fontSize: 60
                     ),),
                     SizedBox(height: 40,),
                     defaultTextForm(
                         validate: (String? value)
                         {
                           if(value!.isEmpty)
                           {
                             return 'please enter your username';
                           }
                         },
                         controller: nameController,
                         type: TextInputType.name, label: 'UserName', prefix: Icons.drive_file_rename_outline) ,
                     SizedBox(height: 15),
                     defaultTextForm(
                         validate: (String? value)
                         {
                           if(value!.isEmpty)
                           {
                             return 'please enter your email address';
                           }
                         },
                         controller: emailController,
                         type: TextInputType.emailAddress, label: 'Email', prefix: Icons.email) ,
                     SizedBox(height: 15),
                     defaultTextForm(validate: (String? value){
                       if(value!.isEmpty)
                       {
                         return 'password is too short';
                       }

                     },
                       visblepass: (){

                       RegisterDriverCubit.get(context).changeVisibilty() ;} ,
                       isPassword: RegisterDriverCubit.get(context).isPassword,
                       controller: passwordController,
                       type: TextInputType.visiblePassword,
                       label: 'Password',
                       prefix: Icons.lock_outline,
                       suffix: RegisterDriverCubit.get(context).suffix ,

                     ) ,
                     SizedBox(height:15) ,
                     defaultTextForm(validate: (String? value){
                       if(value!.isEmpty)
                       {
                         return 'password is too short';
                       }

                     },
                       visblepass: (){

                         RegisterDriverCubit.get(context).changeVisibilty() ;} ,
                       isPassword: RegisterDriverCubit.get(context).isPassword,
                       controller: repasswordController,
                       type: TextInputType.visiblePassword,
                       label: 'Re enter password',
                       prefix: Icons.lock_outline,
                       suffix: RegisterDriverCubit.get(context).suffix ,
                     ) ,
                     SizedBox(height:15) ,
                     defaultTextForm(
                         validate: (String? value)
                         {
                           if(value!.isEmpty)
                           {
                             return 'please enter your PhoneNumber';
                           }
                         },
                         controller: phoneController,
                         type: TextInputType.phone, label: 'Phonenumber', prefix: Icons.phone) ,
                     SizedBox(height:40) ,
                     ConditionalBuilder(condition: state is !RegisterDriverLoadingState,
                         builder:(context)=> defaultButton(function: () {
                           if (formkey.currentState!.validate() &&repasswordController.text==passwordController.text){
                             RegisterDriverCubit.get(context).registerUser(
                                 name: nameController.text,
                                 email: emailController.text,
                                 password: passwordController.text,
                                 phone: phoneController.text);
                           }
                           if(repasswordController.text!=passwordController.text)
                             {
                               toastShow(msg: 'please enter the same password', state: toastStatus.ERROR);
                             }
                         }, text: 'RegisterDriver',radius: 5),
                         fallback:(context)=>Center(child: CircularProgressIndicator(),))
                   ],
                 ),
               ),
             ),
           ),
         );
        },
    ),
    );
  }
}
