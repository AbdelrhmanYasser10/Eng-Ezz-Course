import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../widgets/product_card.dart';


class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavCubit>().getFavProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).favourite,
          style: AppTextStyle.textStyleFont24BlackBold(),
        ),
      ),
      body: BlocBuilder<FavCubit, FavState>(
        builder: (context, state) {
          if (state is GetFavouritesLoading) {
            return const LoadingWidget();
          } else if (state is GetFavouritesError) {
            return Text("err");
          } else {
            var cubit = context.read<FavCubit>();
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.8,
              ),
              itemCount: cubit.allProducts.length,
              itemBuilder: (context, index) {
                var currProduct = cubit.allProducts[index];
                return ProductCard(productModel: currProduct);
              },
            );
          }
        },
      ),
    );
  }
}
