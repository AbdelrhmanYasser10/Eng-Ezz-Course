import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/product_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/search_for_product.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchForProduct searchForProduct;
  SearchCubit({required this.searchForProduct}) : super(SearchInitial());

  void searchForProductFunction(String productName) async {
    emit(SearchLoading());
    final result = await searchForProduct(productName);
    result.fold(
      (l) => emit(SearchError(l.message)),
      (r) => emit(SearchedData(r)),
    );
  }
}
