import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/style/themes.dart';
import 'block_observer.dart';
import 'cubit/cubit.dart';
import 'cubit/cubit2.dart';
import 'cubit/states2.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/products/products_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isdark= CacheHelper.getData(key: 'isdark');
  dynamic onboarding = CacheHelper.getData(key: 'onBoarding');
   token =  CacheHelper.getData(key: 'token');
   print(token);
  Widget widget;
  Bloc.observer = MyBlocObserver();
 if(onboarding!=null)
 {
   if(token!=null)
   {
       widget=ShopLayout();
   }else{widget=ShopLoginScreen();}
 }else{widget=OnBoardingScreen();}

  runApp( MyApp(isdark:isdark,startwidget:widget));
}

class MyApp extends StatelessWidget {

  final bool? isdark;
  final Widget startwidget;
  MyApp({this.isdark,required this.startwidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(create: (BuildContext context)=>AppCubit()..changeAppMode(fromshared: isdark,),),
        BlocProvider(create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){} ,
        builder:(context,state){
          var cubit= AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            //darkTheme:darkTheme,
            themeMode: AppCubit.get(context).isdark?ThemeMode.dark:ThemeMode.light,
            home:startwidget,
          );
        } ,
      ),
    );
  }
}


