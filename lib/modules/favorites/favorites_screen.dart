import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/component/componants.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){},
      builder:(context,state){

        return  ConditionalBuilder(
        condition: state is ! ShopLoadingGetFavoritesState,
          builder:  (context)=>ListView.separated(
            itemBuilder: (context ,index)=> buildListProduct (ShopCubit.get(context).favoritesModel.data.data[index].product,context),
            separatorBuilder: (context ,index)=>SizedBox(height: 10,),
            itemCount: ShopCubit.get(context).favoritesModel.data.data.length,

          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,

        );
      },
    );
  }

}
