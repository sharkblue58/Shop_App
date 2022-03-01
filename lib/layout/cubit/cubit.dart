
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/cateogries/cateogries_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/setting_screen.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopIntialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex =0;
  List<Widget>bottomScreen=[
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

void ChangeBottom(int index){
  currentIndex=index;
  emit(ShopChangeBottomNavState());
}
       Map<int,bool>favorites={};
      HomeModel homemodel=new HomeModel();
void getHomeData()async{

/*    emit(ShopLoadingHomeDataState());
  DioHelper.getData(
      url:Home,token:token  ).then((value){

    homemodel=HomeModel.fromJason(value.data);
    emit(ShopSuccessHomeDataState());
    }).catchError((error){print(error.toString());emit(ShopErorrHomeDataState());});*/

    try {
      emit(ShopLoadingHomeDataState());
    final value = await DioHelper.getData(
        url: Home, token: token);
    if(value != null) {
      homemodel =  HomeModel.fromJason( value.data);
      homemodel.data.products.forEach((element) {favorites.addAll({element.id:element.infavorites});});
      emit(ShopSuccessHomeDataState());
    }
  }catch(error){print(error.toString());emit(ShopErorrHomeDataState());}finally{print('This is the code in getHomeData function ');};
}

   CategoriesModel categoriesModel=new CategoriesModel();
  void getCategories()async{

/*
  DioHelper.getData(
      url:GET_CATEGORIES,token:token  ).then((value){

    categoriesModel=CategoriesModel.fromJason(value.data);
    emit(ShopSuccessCategoriesState());
    }).catchError((error){print(error.toString());emit(ShopErorrCategoriesState());});*/

    try {
      emit(ShopLoadingCategoriesState());
      final value = await DioHelper.getData(
          url: GET_CATEGORIES, token: token);
      if(value != null) {
        categoriesModel =  CategoriesModel.fromJason( value.data);
        emit(ShopSuccessCategoriesState());
      }
    }catch(error){print(error.toString());emit(ShopErorrCategoriesState());}finally{print('This is the code in getCategories function ');};
  }

  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId)async
  {

      if(favorites[productId]==true){favorites[productId]=false;}else if(favorites[productId]==false){favorites[productId]=true;};
      emit(ShopChangeFavoritesState());
      DioHelper.postData(
          url:FAVORITES ,
          data:{
            'product_id':productId
          },token: token,
      ).then((value){
        changeFavoritesModel=ChangeFavoritesModel.fromJason(value.data);
        print(value.data);
        if(!changeFavoritesModel.status)
        {
          if(favorites[productId]==true){favorites[productId]=false;}else if(favorites[productId]==false){favorites[productId]=true;};
        }else{getFavorites();}
        emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
      }).catchError((error)
      {
        emit(ShopErorrChangeFavoritesState());
        if(favorites[productId]==true)
        {
          favorites[productId]=false;}else if(favorites[productId]==false){favorites[productId]=true;
        };

      });

/*      try {
      dynamic value =await DioHelper.postData(url: FAVORITES, data: {'product_id':productId},token:token);
      if(value != null)
      {
      changeFavoritesModel=ChangeFavoritesModel.fromJason(value.data);
      print(value.data);
      emit(ShopSuccessChangeFavoritesState());
      }
    }catch(error){print(error.toString());emit(ShopErorrChangeFavoritesState());}finally{print('This is the code in changeFavorites function ');};
  }*/

}
  FavoritesModel favoritesModel=new FavoritesModel();
  void getFavorites()async{

/*
  DioHelper.getData(
      url:GET_CATEGORIES,token:token  ).then((value){

    categoriesModel=CategoriesModel.fromJason(value.data);
    emit(ShopSuccessCategoriesState());
    }).catchError((error){print(error.toString());emit(ShopErorrCategoriesState());});*/

    try {
      emit(ShopLoadingGetFavoritesState());
      final value = await DioHelper.getData(
          url: FAVORITES, token: token);
      if(value != null) {
        favoritesModel =  FavoritesModel.fromJson( value.data);

        emit(ShopSuccessGetFavoritesState());
      }
    }catch(error){print(error.toString());emit(ShopErorrGetFavoritesState());}finally{print('This is the code in getFavorites function ');};
  }

  ShopLoginModel userModel=new ShopLoginModel();
  void getUserData()async{

/*
  DioHelper.getData(
      url:GET_CATEGORIES,token:token  ).then((value){

    categoriesModel=CategoriesModel.fromJason(value.data);
    emit(ShopSuccessCategoriesState());
    }).catchError((error){print(error.toString());emit(ShopErorrCategoriesState());});*/

    try {
      emit(ShopLoadingUserDataState());
      final value = await DioHelper.getData(
          url: PROFILE, token: token);
      if(value != null) {
        userModel =  ShopLoginModel.fromJason(jason: value.data);
        print(userModel.data.name) ;
        emit(ShopSuccessUserDataState(userModel));
      }
    }catch(error){print(error.toString());emit(ShopErorrUserDataState());}finally{print('This is the code in getUserData function ');};
  }
  void updateUserData({required String name,required String email,required String phone,})async{

/*
  DioHelper.getData(
      url:GET_CATEGORIES,token:token  ).then((value){

    categoriesModel=CategoriesModel.fromJason(value.data);
    emit(ShopSuccessCategoriesState());
    }).catchError((error){print(error.toString());emit(ShopErorrCategoriesState());});*/

    try {
      emit(ShopLoadingUpdateUserState());
      final value = await DioHelper.putData(
          url: UPDATE_PROFILE, token: token, data: {
            'name':name,
            'email':email,
            'phone':phone,
      });
      if(value != null) {
        userModel =  ShopLoginModel.fromJason(jason: value.data);
        print(userModel.data.name) ;
        emit(ShopSuccessUpdateUserState(userModel));
      }
    }catch(error){print(error.toString());emit(ShopErorrUpdateUserState());}finally{print('This is the code in updateUserData function ');};
  }


}