class FavoritesModel {
  FavoritesModel();
  bool? status;
  Null message;
  Data data = new Data();

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }


}

class Data {
  Data();
  int currentPage = 0;
  List<FavoritesData> data =[];
  String firstPageUrl = '';
  int from = 0;
  int lastPage = 0;
  String lastPageUrl = '';
  Null nextPageUrl;
  String path ='';
  int perPage = 0;
  Null prevPageUrl;
  int to = 0;
  dynamic total = 0;



  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new FavoritesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class FavoritesData {
  int id = 0;
  Product product = new Product();


  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    (json['product'] != null ? new Product.fromJson(json['product']) : null)!;
  }

}

class Product {
  Product();
  dynamic id =0, price =0, oldPrice =0, discount =0;
  String image= '';
  String name = '';
  String description ='';



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}

