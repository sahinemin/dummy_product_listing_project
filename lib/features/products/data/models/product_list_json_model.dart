import 'package:dummy_clean_project/features/products/data/models/product_json_model.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_list_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_list_json_model.g.dart';

@JsonSerializable(createToJson: false)
class ProductListJsonModel extends ProductListEntity {
  const ProductListJsonModel({
    super.products,
  });

  factory ProductListJsonModel.fromJson(Map<String, dynamic> json) =>
      _$ProductListJsonModelFromJson(json);

  //Map<String, dynamic> toJson() => _$ProductListJsonModelToJson(this);
}
