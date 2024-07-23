
import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  String? message;
  List<ProductList>? productList;

  ProductListModel({
    this.message,
    this.productList,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    message: json["message"],
    productList: List<ProductList>.from(json["product_list"].map((x) => ProductList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "product_list": List<dynamic>.from(productList!.map((x) => x.toJson())),
  };
}

class ProductList {
  String? productId;
  String? productName;
  String? productDescription;
  String? price;
  String? bannerImg;
  String? status;
  String? category;
  List<String>? images;
  String? imagesPath;
  String? bannerImgPath;

  ProductList({
    this.productId,
    this.productName,
    this.productDescription,
    this.price,
    this.bannerImg,
    this.status,
    this.category,
    this.images,
    this.imagesPath,
    this.bannerImgPath,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    productId: json["product_id"],
    productName: json["product_name"],
    productDescription: json["product_description"],
    price: json["price"],
    bannerImg: json["banner_img"],
    status: json["status"],
    category: json["category"],
    images: List<String>.from(json["images"].map((x) => x)),
    imagesPath: json["images_path"],
    bannerImgPath: json["banner_img_path"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "product_description": productDescription,
    "price": price,
    "banner_img": bannerImg,
    "status": status,
    "category": category,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "images_path": imagesPath,
    "banner_img_path": bannerImgPath,
  };
}
