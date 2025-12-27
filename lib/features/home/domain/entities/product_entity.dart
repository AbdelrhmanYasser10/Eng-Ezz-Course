import 'package:equatable/equatable.dart';
import 'category_entity.dart';

class ProductEntity extends Equatable {
  final int? id;
  final String? title;
  final String? slug;
  final int? price;
  final String? description;
  final CategoryEntity? category;
  final List<String>? images;
  final String? creationAt;
  final String? updatedAt;

  const ProductEntity({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        slug,
        price,
        description,
        category,
        images,
        creationAt,
        updatedAt,
      ];
}
