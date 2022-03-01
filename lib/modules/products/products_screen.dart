import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/component/componants.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/colors.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){
        if(state is ShopSuccessChangeFavoritesState)
        {
            if(!state.model.status)
              {
                toast(toaststate:Toaststate.error ,message:'${state.model.message}' );
              }
        }

        },
        builder:(context,state){
    return ConditionalBuilder(
      condition:(state is! ShopLoadingHomeDataState) &&( state is! ShopLoadingCategoriesState),
      builder: (context)=>builderWidget(ShopCubit.get(context).homemodel,ShopCubit.get(context).categoriesModel,context),
      fallback:(context)=>Center(child: CircularProgressIndicator()) ,
    );


    },
    );
}
  Widget builderWidget (HomeModel model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
           CarouselSlider(
             items: model.data.banners.map((e) => Image(
               image:NetworkImage('${e.image}') ,
               width:double.infinity,
               fit:BoxFit.cover ,
             )).toList(),
             options:CarouselOptions(
               height: 250,
               initialPage: 0,
               viewportFraction: 1,
               enableInfiniteScroll: true,
               reverse: false,
               autoPlay:true,
               autoPlayInterval:Duration(seconds:3),
               autoPlayAnimationDuration: Duration(seconds:1),
               autoPlayCurve: Curves.fastOutSlowIn,
               scrollDirection: Axis.horizontal,
             ),
           ),
        SizedBox(height:10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',style:TextStyle(fontSize:24,fontWeight:FontWeight.w800) ,),
              SizedBox(height:10,),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(width:10,),
                    itemCount: categoriesModel.data.data.length
                ),
              ),
              SizedBox(height:20,),
              Text('New Products',style:TextStyle(fontSize:24,fontWeight:FontWeight.w800) ,),
            ],
          ),
        ),
        SizedBox(height:10,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio:1/1.59 ,
            shrinkWrap: true,
              crossAxisCount: 2,
             children:
               List.generate(model.data.products.length, (index) => buildGridProduct(model.data.products[index],context),
               ),
          ),
        ),
      ],
    ),
  );
  Widget buildCategoryItem(DataModel model)=>Stack(
    alignment:AlignmentDirectional.bottomCenter ,
    children: [
      Image(
        image: NetworkImage(model.image),
        height:100 ,
        width:100 ,
        fit:BoxFit.cover,
      ),
      Container(
          color: Colors.black.withOpacity(0.8),
          width: 100,
          child: Text(model.name,style:TextStyle(color: Colors.white),textAlign:TextAlign.center,maxLines: 1,overflow:TextOverflow.ellipsis,)
      ),
    ],
  );
  Widget buildGridProduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Stack(
         alignment: AlignmentDirectional.bottomStart,
         children: [
           Image(
         image: NetworkImage(model.image),
         width:double.infinity,
         height: 200,

       ),
           if(model.discount!=0)
           Container(
             color:Colors.red ,
             padding:EdgeInsets.symmetric(horizontal: 5),
             child: Text('Discount',style: TextStyle(fontSize:8,color:Colors.white),),

           )
         ],
       ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}',maxLines:2,overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize:14.0,height:1.3),),
              Row(children:[
              Text('${model.price.round()}',style: TextStyle(fontSize:12.0,color:defaultColor),),
                SizedBox(width:5),
                if(model.discount!=0)
                Text('${model.oldprice.round()}',style: TextStyle(fontSize:10.0,color:Colors.grey,decoration:TextDecoration.lineThrough,),),
                Spacer(),
                IconButton(
                  onPressed: (){
                    ShopCubit.get(context).changeFavorites(model.id);
                    print(token);
                  },
                  icon:CircleAvatar(

                      backgroundColor:ShopCubit.get(context).favorites[model.id]??true?defaultColor:Colors.grey,
                      radius:15,
                      child: Icon(Icons.favorite,size:14 ,color:Colors.white,)
                  ),
                ),
              ],
              ),
            ],
          ),
        ),

      ],
    ),
  );


}