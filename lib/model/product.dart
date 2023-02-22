// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.name,
    required this.details,
    required this.price,
    required this.imageUrl,
    required this.endDate,
  });
  String? docId;
  String name;
  String details;
  double price;
  String imageUrl;
  String endDate;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["name"],
    details: json["details"],
    price: json["price"]?.toDouble(),
    imageUrl: json["imageUrl"],
    endDate: json["end date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "details": details,
    "price": price,
    "imageUrl": imageUrl,
    "end date": endDate,
  };
}
