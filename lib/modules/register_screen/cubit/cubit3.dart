import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states3.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/modules/register_screen/cubit/states3.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterIntialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  IconData suffix =Icons.visibility_outlined;
  bool ispassword=true;
  ShopLoginModel loginmodel=new ShopLoginModel();

void userRegister({required String name,required String email,required String password,required String phone}){
  emit(ShopRegisterLoadingState());
  DioHelper.postData(
      url:REGISTER ,
      data:{
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      }
  ).then((value){
    print(value.data);
    loginmodel=ShopLoginModel.fromJason(jason: value.data);
    emit(ShopRegisterSuccessState(loginmodel));
  }).catchError((error){emit(ShopRegisterErrorState(error: error.toString()));});
}

void changePasswordVisibility(){

  ispassword=!ispassword;
  suffix=ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
emit(ShopRegisterChangePasswordVisibiliyState());
}

}