// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_json_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductJsonModel _$ProductJsonModelFromJson(Map<String, dynamic> json) =>
    ProductJsonModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: json['price'] as int?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      stock: json['stock'] as int?,
      brand: json['brand'] as String?,
      category: json['category'] as String?,
      thumbnail: json['thumbnail'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
