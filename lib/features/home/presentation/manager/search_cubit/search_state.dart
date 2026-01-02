part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}
final class SearchedData extends SearchState {
  final List<ProductEntity> allResults;
    SearchedData(this.allResults);
}
final class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
