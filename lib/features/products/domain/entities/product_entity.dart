import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
  });
  const ProductEntity.test()
      : id = 1,
        title = 'iPhone 9',
        description = 'An apple mobile which is nothing like apple',
        price = 549,
        discountPercentage = 12.96,
        rating = 4.69,
        stock = 94,
        brand = 'Apple',
        category = 'smartphones',
        thumbnail = 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
        images = const [
          'https://i.dummyjson.com/data/products/1/1.jpg',
          'https://i.dummyjson.com/data/products/1/2.jpg',
          'https://i.dummyjson.com/data/products/1/3.jpg',
          'https://i.dummyjson.com/data/products/1/4.jpg',
          'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
        ];

  final int? id;
  final String? title;
  final String? description;
  final int? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final String? brand;
  final String? category;
  final String? thumbnail;
  final List<String>? images;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      price,
      discountPercentage,
      rating,
      stock,
      brand,
      category,
      thumbnail,
      images,
    ];
  }

  @override
  bool get stringify => true;
}
