import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/component/componants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder:(context,state){
        var cubit =ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla',
            ),
            actions: [
              IconButton(onPressed: (){nevigateTo(context,SearchScreen());}, icon: Icon(Icons.search))
            ],
          ),
          body:cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            onTap:(index){
              cubit.ChangeBottom(index);
            },
            currentIndex:cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
          ),
        );

      } ,
    );
  }
}
