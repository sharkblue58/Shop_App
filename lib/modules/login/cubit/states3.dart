import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginStates {}
class ShopLoginIntialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{
final ShopLoginModel? shopLoginModel;

  ShopLoginSuccessState(this.shopLoginModel);
}
class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState({required this.error});
}
class ShopChangePasswordVisibiliyState extends ShopLoginStates{}