
class AddRemoveFavoriteItemModel{
  bool status = false;
  String message ="";
  AddRemoveFavoriteItemModel.fromJson(Map<String , dynamic> json){
    status= json['status'] ;
    message= json['message'];

  }
}

class FavoritesModel {
  bool? status;
  FavoritesData? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? FavoritesData.fromJson(json['data']) : null;
  }


}

class FavoritesData {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  double? nextPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;


  FavoritesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((value) {
        data!.add(Data.fromJson(value));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }


}

class Data {
  int? id;
  Product? product;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

}

class Product {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;


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
