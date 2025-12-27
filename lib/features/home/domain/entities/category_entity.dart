import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int? id;
  final String? name;
  final String? slug;
  final String? image;
  final String? creationAt;
  final String? updatedAt;

  const CategoryEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        slug,
        image,
        creationAt,
        updatedAt,
      ];
}
