import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/product_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/get_all_products_use_case.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/get_category_products_use_case.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetCategoryProductsUseCase getCategoryProductsUseCase;

  ProductCubit({
    required this.getAllProductsUseCase,
    required this.getCategoryProductsUseCase,
  }) : super(ProductInitial());

  List<ProductEntity> homeProducts = [];
  List<ProductEntity> categoryProducts = [];

  Future<void> getAllProducts() async {
    emit(GetAllProductsLoading());
    final result = await getAllProductsUseCase();
    result.fold(
      (failure) => emit(GetAllProductsError()),
      (products) {
        homeProducts = products;
        emit(GetAllProductsSuccessfully());
      },
    );
  }

  void getCategoryProducts(int categoryId) async {
    emit(GetCategoryProductsLoading());
    final result = await getCategoryProductsUseCase(categoryId);
    result.fold(
      (failure) => emit(GetCategoryProductsError()),
      (products) {
        categoryProducts = products;
        emit(GetCategoryProductsSuccessfully());
      },
    );
  }
}
