import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}
class ShopIntialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErorrHomeDataState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErorrCategoriesState extends ShopStates{}
class ShopLoadingCategoriesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates
{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErorrChangeFavoritesState extends ShopStates{}
class ShopChangeFavoritesState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErorrGetFavoritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel userModel;
  ShopSuccessUserDataState(this.userModel);

}
class ShopErorrUserDataState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{
  final ShopLoginModel userModel;
  ShopSuccessUpdateUserState(this.userModel);

}
class ShopErorrUpdateUserState extends ShopStates{}