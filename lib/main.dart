import 'package:e_commerce_app_session_it_sharks/logic/calculator_cubit/calculator_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/view/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalculatorCubit> ( // Widget
      create: (context) => CalculatorCubit(), // Business Logic Object

      child: MaterialApp(

        home: CalculatorScreen(),
      ),
    );
  }
}

