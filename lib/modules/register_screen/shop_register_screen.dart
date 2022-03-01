import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit3.dart';
import 'package:shop_app/shared/component/componants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'cubit/cubit3.dart';
import 'cubit/states3.dart';

class ShopRegisterScreen extends StatelessWidget {

  var namecontroller =TextEditingController();
  var emailcontroller =TextEditingController();
  var passwordcontroller =TextEditingController();
  var phonecontroller =TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener:(context,state){

          if(state is ShopRegisterSuccessState)
          {
            if(state.shopLoginModel!.state==true)
            {
              toast(message:'${state.shopLoginModel!.message.toString()}' ,toaststate:Toaststate.success ,);
              CacheHelper.saveData(key: 'token', value:state.shopLoginModel!.data.token);
              print(state.shopLoginModel!.data.token);
              token=state.shopLoginModel!.data.token;
              nevigateAndFinish(context, ShopLayout());

            }else
            {
              toast(message:'${state.shopLoginModel!.message.toString()}',toaststate:Toaststate.error );
              print(state.shopLoginModel!.message);

            }
          }
        },
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register',style:Theme.of(context).textTheme.headline4!.copyWith(color:Colors.black,),),
                        Text('Register now to get our hot offers',style:Theme.of(context).textTheme.bodyText1!.copyWith(color:Colors.grey),),
                        SizedBox(height:30 ,),
                        buildlogintextfield(
                            circle:0 ,
                            controller:namecontroller ,
                            lable:'name' ,
                            prefix:Icons.person ,
                            type:TextInputType.name,
                            validator: (value){

                              if (value!.isEmpty)
                              {
                                return 'name Must Not Be Empty';
                              }
                              return null;
                            }),
                        SizedBox(height: 15,),
                        buildlogintextfield(
                            circle:0 ,
                            controller:emailcontroller ,
                            lable:'Email Address' ,
                            prefix:Icons.email_outlined ,
                            type:TextInputType.emailAddress,
                            validator: (value){

                              if (value!.isEmpty)
                              {
                                return 'Email Must Not Be Empty';
                              }
                              return null;
                            }),
                        SizedBox(height: 15,)
                        ,
                        buildlogintextfield(
                            circle:0 ,
                            controller:passwordcontroller ,
                            lable:'Password' ,
                            prefix:Icons.lock_outlined ,
                            suffix:ShopRegisterCubit.get(context).suffix ,
                            type:TextInputType.visiblePassword,
                            ispassword:ShopRegisterCubit.get(context).ispassword ,
                            onsuffixpress:(){ShopRegisterCubit.get(context).changePasswordVisibility();},
                            onsubmit: (value){

                            },
                            validator: (value){

                              if (value!.isEmpty)
                              {
                                return 'password Must Not Be Short';
                              }
                              return null;
                            }),
                        SizedBox(height: 15,),
                        buildlogintextfield(
                            circle:0 ,
                            controller:phonecontroller ,
                            lable:'phone' ,
                            prefix:Icons.phone ,
                            type:TextInputType.phone,
                            validator: (value){

                              if (value!.isEmpty)
                              {
                                return 'phone Must Not Be Empty';
                              }
                              return null;
                            }),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition:state is !ShopRegisterLoadingState,
                          builder:(context)=>defultbutton(function:(){
                            if(formkey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                name:namecontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                phone: phonecontroller.text,
                              );
                            }
                          } , text: 'Register'),
                          fallback:(context)=>CircularProgressIndicator() ,
                        ),

                      ],
                    ),
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
