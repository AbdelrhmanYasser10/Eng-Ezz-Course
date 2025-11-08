import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  double result = 0;

  void add(double number1,double number2){
    result = number1 + number2;
    emit(AdditionState());
  }
  void subtract(double number1,double number2){
    result = number1 - number2;
    emit(SubtractState());
  }
  void multiplication(double number1,double number2){
    result = number1 * number2;
    emit(MultiplicationState());
  }
  void division(double number1,double number2){
    if(number2 == 0){
      emit(CannotApplyThisOperationState());
    }
    else {
      result = number1 / number2;
      emit(DivionState());
    }
  }

}
