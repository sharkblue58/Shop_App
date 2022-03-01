
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states2.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';



class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  static AppCubit get (context)=>BlocProvider.of(context);

  bool isdark=false;
  void changeAppMode({ bool? fromshared})
  {
    if(fromshared!=null)
      {
        isdark=fromshared;
        emit(AppChangeModeState());
      }

    else{
      isdark=!isdark;
      CacheHelper.putBoolean(key: 'isdark', value: isdark).then((value) {emit(AppChangeModeState());});
    }

  }
}