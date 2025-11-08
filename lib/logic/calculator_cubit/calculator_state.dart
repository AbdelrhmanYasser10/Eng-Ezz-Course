part of 'calculator_cubit.dart';

@immutable
sealed class CalculatorState {}

final class CalculatorInitial extends CalculatorState {}

final class AdditionState extends CalculatorState {}
final class SubtractState extends CalculatorState {}
final class MultiplicationState extends CalculatorState {}
final class DivionState extends CalculatorState {}
final class CannotApplyThisOperationState extends CalculatorState {}
