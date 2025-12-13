part of 'branches_cubit.dart';

@immutable
sealed class BranchesState {}

final class BranchesInitial extends BranchesState {}

final class GetLocationLoading extends BranchesState {}
final class GetCurrentLocation extends BranchesState {}
final class GetDefaultLocation extends BranchesState {}

final class GetAllLocationsLoading extends BranchesState {}
final class GetAllLocationSuccessfully extends BranchesState {}
final class GetAllLocationsError extends BranchesState {}

final class UpdateMyLocation extends BranchesState {}