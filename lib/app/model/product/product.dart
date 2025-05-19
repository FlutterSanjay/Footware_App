import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "price")
  String? price;

  @JsonKey(name: "image_url")
  String? imageUrl;

  @JsonKey(name: "category")
  String? category;

  @JsonKey(name: "brand")
  String? brand;

  @JsonKey(name: "offer")
  String? offer;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.imageUrl,
      this.category,
      this.brand,
      this.offer});
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
