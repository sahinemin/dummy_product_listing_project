import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_json_model.g.dart';

@JsonSerializable(createToJson: false)
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

  //Map<String, dynamic> toJson() => _$ProductJsonModelToJson(this);
}
