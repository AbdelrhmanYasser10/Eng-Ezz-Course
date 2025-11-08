import 'package:e_commerce_app_session_it_sharks/logic/calculator_cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _firstNumberController = TextEditingController();
  final _secondNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalculatorCubit, CalculatorState>(
      listener: (context, state) {
        if(state is CannotApplyThisOperationState){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("You cannot apply division by 0"),backgroundColor: Colors.red,)
          );
        }
      },
      builder: (context, state) {
        CalculatorCubit cubit = BlocProvider.of<CalculatorCubit>(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "${cubit.result}",
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Divider(
                  height: 4,
                ),

                TextFormField(
                  controller: _firstNumberController,
                  decoration: InputDecoration(
                    labelText: "Enter first number",
                  ),
                  keyboardType: TextInputType.number,

                ),
                TextFormField(
                  controller: _secondNumberController,
                  decoration: InputDecoration(
                      labelText: "Enter second number"
                  ),
                  keyboardType: TextInputType.number,

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          validateBeforeSend(
                          _firstNumberController.text,
                            _secondNumberController.text,
                            cubit,
                            "+"
                          );
                        },
                        child: Icon(Icons.add),
                    ),
                    ElevatedButton(onPressed: () {
                      validateBeforeSend(
                          _firstNumberController.text,
                          _secondNumberController.text,
                          cubit,
                          "-"
                      );
                    }, child: Icon(Icons.remove)),
                    ElevatedButton(onPressed: () {
                      validateBeforeSend(
                          _firstNumberController.text,
                          _secondNumberController.text,
                          cubit,
                          "*"
                      );
                    }, child: Text("*")),
                    ElevatedButton(onPressed: () {
                      validateBeforeSend(
                          _firstNumberController.text,
                          _secondNumberController.text,
                          cubit,
                          "/"
                      );
                    }, child: Text("/")),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void validateBeforeSend(String firstNumberText,String secondNumberText, CalculatorCubit cubit, String op){
    try{
      double fNumber = double.parse(_firstNumberController.text);
      double SNumber = double.parse(_secondNumberController.text);
      switch(op){
        case "+":
          cubit.add(fNumber, SNumber);
          break;
        case "-":
          cubit.subtract(fNumber, SNumber);
          break;
        case "*":
          cubit.multiplication(fNumber, SNumber);
          break;
        case "/":
          cubit.division(fNumber, SNumber);
          break;
      }
    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("There's a wrong number"),backgroundColor: Colors.red,)
      );
    }
  }
}
