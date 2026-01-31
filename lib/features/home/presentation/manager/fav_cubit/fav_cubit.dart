import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/save_product_in_favourite.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/get_favourite_products.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/product_entity.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  final SaveProductInFavourite saveProductInFavourite;
  final GetFavouriteProducts getFavouriteProducts;

  FavCubit({
    required this.saveProductInFavourite,
    required this.getFavouriteProducts,
  }) : super(FavInitial());

  Map<int, bool> isInFavourite = {};
  List<ProductEntity> allProducts = [];

  void getFavProducts() async {
    emit(GetFavouritesLoading());
    final response = await getFavouriteProducts();
    response.fold((l) => emit(GetFavouritesError()), (r) {
      allProducts = r;
      for (var element in r) {
        isInFavourite[element.id!] = true;
      }
      emit(GetFavouritesSuccessfully());
    });
  }

  void saveToFav(ProductEntity product) async {
    if (isInFavourite.containsKey(product.id)) {
      isInFavourite[product.id!] = !isInFavourite[product.id]!;
    } else {
      isInFavourite[product.id!] = true;
    }
    emit(ChangeProductFavourite());
    final response = await saveProductInFavourite(product);
    response.fold(
      (l) {
        log("Fail");
        print(l.message);
        isInFavourite[product.id!] = !isInFavourite[product.id]!;
        emit(ChangeProductFavourite());
      },
      (r) {
        if (isInFavourite[product.id!] == false) {
          allProducts.remove(product);
        }
        emit(ChangeProductFavourite());
      },
    );
  }
}
