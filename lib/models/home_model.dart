class HomeModel{

  late bool status;
    HomeDataModel data=new HomeDataModel();
  HomeModel();
  HomeModel.fromJason(Map<String,dynamic>jason)
  {
    status=jason['status'];
    data=HomeDataModel.fromJason(jason['data']);
  }
}
class HomeDataModel{
  HomeDataModel();
  List<BannerModel>banners=[];
  List<ProductModel>products=[];
  HomeDataModel.fromJason(Map<String,dynamic>jason)
  {
           jason['banners'].forEach((element) {
             banners.add(BannerModel.fromJason(element));
           });
           jason['products'].forEach((element) {
             products.add(ProductModel.fromJason(element));
           });
  }
}

class BannerModel{
  BannerModel();
   late int id ;
   late String image;
   BannerModel.fromJason(Map<String,dynamic>jason)
  {
     id=jason['id'];
     image=jason['image'];
  }

}
class ProductModel{
  ProductModel();
   late int id;
   dynamic oldprice;
   dynamic price;
   dynamic discount;
   late String image;
   late String name;
   late bool infavorites;
   late bool incart;
   ProductModel.fromJason(Map<String,dynamic>jason)
  {
    id=jason['id'];
    oldprice=jason['old_price'];
    price=jason['price'];
    discount=jason['discount'];
    image=jason['image'];
    name=jason['name'];
    infavorites=jason['in_favorites'];
    incart=jason['in_cart'];
  }

}

