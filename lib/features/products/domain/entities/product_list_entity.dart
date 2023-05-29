import 'package:dummy_clean_project/features/products/data/models/product_json_model.dart';
import 'package:equatable/equatable.dart';

class ProductListEntity extends Equatable {
  const ProductListEntity({this.products});
  final List<ProductJsonModel>? products;

  @override
  List<Object?> get props => [products];
  @override
  bool get stringify => true;
}
