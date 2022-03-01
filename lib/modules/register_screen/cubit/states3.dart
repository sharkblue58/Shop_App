import 'package:shop_app/models/login_model.dart';

abstract class ShopRegisterStates {}
class ShopRegisterIntialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
final ShopLoginModel? shopLoginModel;

  ShopRegisterSuccessState(this.shopLoginModel);
}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState({required this.error});
}
class ShopRegisterChangePasswordVisibiliyState extends ShopRegisterStates{}