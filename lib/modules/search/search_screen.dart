import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/component/componants.dart';

import 'cubit/cubit4.dart';
import 'cubit/states4.dart';

class SearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var formkey=GlobalKey<FormState>();
    var searchController=TextEditingController();
    return BlocProvider(
      create:(BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){} ,
        builder: (context,state){
          return Scaffold(
              appBar:AppBar() ,
              body:Form(
                key:formkey ,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children:
                    [
                      buildlogintextfield(
                          validator:(value){
                            if(value.toString().isEmpty)
                              {return 'field cant be empty';}
                            return null;
                          } ,
                          circle:0 ,
                          controller:searchController ,
                          lable:'search' ,
                          type:TextInputType.text,
                          prefix:Icons.search,
                          onsubmit: (value){
                            SearchCubit.get(context).search(value);
                          }
                      ),
                      SizedBox(height: 10,),
                      if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                      SizedBox(height: 10,),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context ,index)=> buildListProduct ( SearchCubit.get(context).model.data.data[index],context,isOldPrice: false),
                          separatorBuilder: (context ,index)=>SizedBox(height: 10,),
                          itemCount: SearchCubit.get(context).model.data.data.length,

                        ),
                      ),


                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
