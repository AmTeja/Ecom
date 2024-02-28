import 'package:ecom/shared/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.rating,
    required super.thumbnail,
  });

  factory ProductModel.fromJson(Map json) {
    return ProductModel(
      id: int.tryParse(json['id'].toString()) ?? -1,
      title: json['title'].toString(),
      description: json['description'].toString(),
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      thumbnail: json['thumbnail'].toString(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': super.id,
      'title': super.title,
      'description': super.description,
      'price': super.price,
      'rating': super.rating,
      'thumbnail': super.thumbnail,
    };
  }
}
