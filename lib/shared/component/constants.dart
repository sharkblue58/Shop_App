
/*
defulttextbutton(text: 'Sign Out',function:(){
CacheHelper.removeData(key: 'token').then((value) => nevigateAndFinish(context,ShopLoginScreen()));
}),*/

// shop API "softagi" ---> https://www.getpostman.com/collections/94db931dc503afd508a5

import 'package:shop_app/shared/network/local/cache_helper.dart';

void printFullText(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
dynamic token='';