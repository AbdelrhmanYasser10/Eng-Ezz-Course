import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/core/widgets/loading_widget.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/product_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged:  (value) {
                  context.read<SearchCubit>().searchForProductFunction(value);
                },
              ),
              SizedBox(height: 16),
              BlocBuilder<SearchCubit,SearchState>(

                builder: (context, state) {
                  if(state is SearchLoading){
                    return const LoadingWidget();
                  }
                  else if(state is SearchError){
                    return  Center(
                      child: Text(
                        "Err ${state.message}"
                      ),
                    );
                  }
                  else if (state is SearchedData){
                    var list = state.allResults;
                    if(list.isNotEmpty) {
                      return Expanded(
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.8,
                          ),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            var currProduct = list[index];
                            return ProductCard(productModel: currProduct);
                          },
                        ),
                      );
                    }
                    else{
                      return Center(
                        child: Text(
                          "No matched products",
                          style: AppTextStyle.textStyleFont20BlackBold(),
                        ),
                      );
                    }
                  }
                  else{
                    return const SizedBox();
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
