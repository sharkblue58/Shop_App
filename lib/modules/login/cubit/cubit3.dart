import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states3.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginIntialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  IconData suffix =Icons.visibility_outlined;
  bool ispassword=true;
  ShopLoginModel loginmodel=new ShopLoginModel();

void userLogin({required String email,required String password}){
  emit(ShopLoginLoadingState());
  DioHelper.postData(
      url:Login ,
      data:{
        'email':email,
        'password':password
      }
  ).then((value){
    print(value.data);
    loginmodel=ShopLoginModel.fromJason(jason: value.data);
    emit(ShopLoginSuccessState(loginmodel));
  }).catchError((error){emit(ShopLoginErrorState(error: error.toString()));});
}

void changePasswordVisibility(){

  ispassword=!ispassword;
  suffix=ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
emit(ShopChangePasswordVisibiliyState());
}

}