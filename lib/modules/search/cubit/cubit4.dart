
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states4.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model =new SearchModel();
  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url:SEARCH ,
        data:{
           'text':text
        },token: token,
    ).then((value){
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){emit(SearchErorrState());print(error.toString());});
}

}