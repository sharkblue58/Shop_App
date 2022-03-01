import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/colors.dart';

void nevigateTo(context, Widget)=>Navigator.push(context, MaterialPageRoute(builder:(context)=> Widget,));
void nevigateAndFinish(context, Widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder:(context)=> Widget,),
      (route)=>false,
);
Widget buildlogintextfield(
    {
        required TextEditingController controller,
        required TextInputType type ,
        required String lable,
        required IconData prefix,
        IconData? suffix,
        required double circle,
        required var validator,
        var onsubmit ,
        var onchange,
        var onsuffixpress,
        bool ispassword=false,


    }
    )=> TextFormField(

    keyboardType:type,
    controller: controller,
    validator:validator ,
    obscureText: ispassword,
    decoration: InputDecoration(
        labelText: lable,
        prefixIcon:Icon(
            prefix,
        ),
        suffixIcon:IconButton(
          onPressed:onsuffixpress,
          icon:Icon(suffix) ,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(circle),
        ),

    ),
    onFieldSubmitted:onsubmit,
    onChanged:onchange,

);

Widget defultbutton ({
  double width=double.infinity,
  Color background=Colors.blue,
  required var function,
  required String text,
})=>Container(
  width:width,
  color:background,
  child: MaterialButton(
    onPressed:function
    ,
    child:Text(text.toUpperCase(),style:TextStyle(color:Colors.white),) ,

  ),
);

Widget defulttextbutton ({
  required var function,
  required String text,
})=>
TextButton(onPressed: function, child: Text(text));

Future<bool?> toast({
  required String message,
  required Toaststate toaststate
})=> Fluttertoast.showToast(
    msg:  '$message',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color(toaststate),
    textColor: Colors.black,
    fontSize: 16.0
);
enum Toaststate{success,error,warrning}
Color color(Toaststate state)
{
  switch(state)
  {
    case Toaststate.success:
      return Colors.green;
    case Toaststate.error:
      return Colors.red;
    case Toaststate.warrning:
      return Colors.yellow;
  }

}

void signOut(context){

  CacheHelper.removeData(key: 'token',).then((value) =>
{
  if(value){
    nevigateAndFinish(context,ShopLoginScreen())
  }

});
}

Widget buildListProduct( model,context,{bool isOldPrice=true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height:120 ,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              fit: BoxFit.cover,
              width:120,
              height: 120,

            ),
            if(model.discount!=0 && isOldPrice)
              Container(
                color:Colors.red ,
                padding:EdgeInsets.symmetric(horizontal: 5),
                child: Text('Discount',style: TextStyle(fontSize:8,color:Colors.white),),

              )
          ],
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name,maxLines:2,overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize:14.0,height:1.3),),
              Spacer(),
              Row(children:[
                Text(model.price.toString(),style: TextStyle(fontSize:12.0,color:defaultColor),),
                SizedBox(width:5),
                if(model.discount!=0 && isOldPrice)
                  Text(model.oldPrice.toString(),style: TextStyle(fontSize:10.0,color:Colors.grey,decoration:TextDecoration.lineThrough,),),
                Spacer(),
                IconButton(
                  onPressed: (){
                    ShopCubit.get(context).changeFavorites(model.id);

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
  ),
);
