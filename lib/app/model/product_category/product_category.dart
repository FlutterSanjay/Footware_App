import 'package:json_annotation/json_annotation.dart';
part 'product_category.g.dart';

@JsonSerializable()
class Product_Category {
  @JsonKey(name: "key")
  String? id;

  @JsonKey(name: "name")
  String? name;
  Product_Category({
    this.id,
    this.name,
  });

  factory Product_Category.fromJson(Map<String, dynamic> json) =>
      _$Product_CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$Product_CategoryToJson(this);
}
