import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/cubit3.dart';
import 'package:shop_app/modules/login/cubit/states3.dart';
import 'package:shop_app/modules/register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/component/componants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';


class  ShopLoginScreen extends StatelessWidget {

var emailcontroller =TextEditingController();
var passwordcontroller =TextEditingController();
var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener:(context,state){
          if(state is ShopLoginSuccessState)
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
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',style:Theme.of(context).textTheme.headline4!.copyWith(color:Colors.black,),),
                        Text('Login now to get our hot offers',style:Theme.of(context).textTheme.bodyText1!.copyWith(color:Colors.grey),),
                        SizedBox(height:30 ,),
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
                            suffix:ShopLoginCubit.get(context).suffix ,
                            type:TextInputType.visiblePassword,
                            ispassword:ShopLoginCubit.get(context).ispassword ,
                            onsuffixpress:(){ShopLoginCubit.get(context).changePasswordVisibility();},
                            onsubmit: (value){
                              if(formkey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            },
                            validator: (value){

                              if (value!.isEmpty)
                              {
                                return 'password Must Not Be Short';
                              }
                              return null;
                            }),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition:state is! ShopLoginLoadingState,
                          builder:(context)=>defultbutton(function:(){
                            if(formkey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                            }
                          } , text: 'login'),
                          fallback:(context)=>CircularProgressIndicator() ,
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ?'),
                            SizedBox(width:5,),
                            defulttextbutton(text:'Register now',function:(){
                              nevigateTo(context,ShopRegisterScreen());
                            } ),
                          ],
                        )
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
