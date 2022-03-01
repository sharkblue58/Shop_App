/*
class ShopLoginModel{
  late bool status;
  late String message;
   UserData? data;
  ShopLoginModel.fromJason(Map<String,dynamic>jason)
  {
    status=jason['status'];
    message=jason['message'];
    data=jason['email']!=null?UserData.fromJason(jason['data']):null;

  }
}
class UserData{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  int? points;
  int? credit;
  late String token;
  // UserData({required this.id,required this.email,required this.name,required this.phone,required this.image,this.credit,this.points,required this.token});
  UserData.fromJason(Map<String,dynamic>jason)
  {
     id=jason['id'];
     name=jason['name'];
     email=jason['email'];
     phone=jason['phone'];
     image=jason['image'];
     points=jason['points'];
     credit=jason['credit'];
     token=jason['token'];
  }
}*/

class ShopLoginModel{
  ShopLoginModel();
  bool state = false;
  dynamic message= '';
  UserData data = new UserData();

  ShopLoginModel.fromJason({required Map<String,dynamic>jason})
  {
    this.state = jason['status'];
    this.message = jason['message'];
    this.data = (jason['data'] == null ? null: UserData.fromJason(jason: jason['data']))! ;
  }
}
class UserData{
  UserData();
  String name ='',phone ='',email ='',image ='',token ='';
  int id = 0;
  UserData.fromJason({required Map<String,dynamic>jason})
  {
    this.name = jason['name'];
    this.phone = jason['phone'];
    this.email = jason['email'];
    this.image = jason['image'];
    this.token = jason['token'];
    this.id = jason['id'];
  }
}
