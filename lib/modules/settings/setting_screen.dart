import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/component/componants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class SettingsScreen extends StatelessWidget {
var formkey=GlobalKey<FormState>();
var nameConrtroller=TextEditingController();
var emailConrtroller=TextEditingController();
var phoneConrtroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){},
      builder:(context,state){
        var model=ShopCubit.get(context).userModel;
        nameConrtroller.text= model.data.name;
        emailConrtroller.text= model.data.email;
        phoneConrtroller.text= model.data.phone;

        return ConditionalBuilder(
          condition:ShopCubit.get(context).userModel!=null ,
          builder:(context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  SizedBox(height:20,),
                  buildlogintextfield(
                      validator:(dynamic value){
                        if(value.isEmpty){return 'field name must not be empty';}
                        return null;
                      } ,
                      circle: 0,
                      controller:nameConrtroller ,
                      lable: 'name',
                      prefix: Icons.person,
                      type:TextInputType.name
                  ),
                  SizedBox(height:20,),
                  buildlogintextfield(
                      validator:(dynamic value){
                        if(value.isEmpty){return 'field email must not be empty';}
                        return null;
                      } ,
                      circle: 0,
                      controller:emailConrtroller ,
                      lable: 'E-mail',
                      prefix: Icons.email,
                      type:TextInputType.emailAddress
                  ),
                  SizedBox(height:20,),
                  buildlogintextfield(
                      validator:(dynamic value){
                        if(value.isEmpty){return 'field phone must not be empty';}
                        return null;
                      } ,
                      circle: 0,
                      controller:phoneConrtroller ,
                      lable: 'phone',
                      prefix: Icons.phone,
                      type:TextInputType.phone
                  ),
                  SizedBox(height:20,),
                  defultbutton(function:(){
                    if(formkey.currentState!.validate())
                      {
                        ShopCubit.get(context).updateUserData(
                            name:nameConrtroller.text ,
                            email:emailConrtroller.text ,
                            phone:phoneConrtroller.text
                        );
                      }

                    } ,
                      text:'Update'
                  ),
                  SizedBox(height:20,),
                  defultbutton(function:(){signOut(context);} ,text:'Logout' ),
                ],
              ),
            ),
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
    }
    );
  }
}
