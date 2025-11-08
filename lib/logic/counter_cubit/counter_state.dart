part of 'counter_cubit.dart';

@immutable
sealed class CounterState {}

final class CounterInitial extends CounterState {}

final class IncrementState extends CounterState {}
final class DecrementState extends CounterState {}
