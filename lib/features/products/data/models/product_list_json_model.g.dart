// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_json_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListJsonModel _$ProductListJsonModelFromJson(
        Map<String, dynamic> json,) =>
    ProductListJsonModel(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductJsonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
