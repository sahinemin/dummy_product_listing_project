import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_json_model.g.dart';

@JsonSerializable()
class ProductJsonModel extends ProductEntity {
  const ProductJsonModel({
    super.id,
    super.title,
    super.description,
    super.price,
    super.discountPercentage,
    super.rating,
    super.stock,
    super.brand,
    super.category,
    super.thumbnail,
    super.images,
  });
  factory ProductJsonModel.fromJson(Map<String, dynamic> json) =>
      _$ProductJsonModelFromJson(json);
  const ProductJsonModel.test()
      : this(
          id: 1,
          title: 'iPhone 9',
          description: 'An apple mobile which is nothing like apple',
          price: 549,
          discountPercentage: 12.96,
          rating: 4.69,
          stock: 94,
          brand: 'Apple',
          category: 'smartphones',
          thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
          images: const [
            'https://i.dummyjson.com/data/products/1/1.jpg',
            'https://i.dummyjson.com/data/products/1/2.jpg',
            'https://i.dummyjson.com/data/products/1/3.jpg',
            'https://i.dummyjson.com/data/products/1/4.jpg',
            'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
          ],
        );
  ProductJsonModel copyWith({
    int? id,
    String? title,
    String? description,
    int? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    String? brand,
    String? category,
    String? thumbnail,
    List<String>? images,
  }) {
    return ProductJsonModel(
      id: id ?? super.id,
      title: title ?? super.title,
      description: description ?? super.description,
      price: price ?? super.price,
      discountPercentage: discountPercentage ?? super.discountPercentage,
      rating: rating ?? super.rating,
      stock: stock ?? super.stock,
      brand: brand ?? super.brand,
      category: category ?? super.category,
      thumbnail: thumbnail ?? super.thumbnail,
      images: images ?? super.images,
    );
  }

  Map<String, dynamic> toJson() => _$ProductJsonModelToJson(this);
}
