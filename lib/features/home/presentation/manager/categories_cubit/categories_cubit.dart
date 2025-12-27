import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/category_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/get_all_categories_use_case.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;

  CategoriesCubit({required this.getAllCategoriesUseCase})
      : super(CategoriesInitial());

  void getAllCategories() async {
    emit(GetAllCategoriesLoading());
    final result = await getAllCategoriesUseCase();
    result.fold(
      (failure) => emit(GetAllCategoriesError()),
      (categories) =>
          emit(GetAllCategoriesSuccessfully(allCategoreies: categories)),
    );
  }
}
