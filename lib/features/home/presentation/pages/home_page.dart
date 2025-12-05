import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/core/widgets/loading_widget.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/product_cubit/product_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_colors.dart';
import '../manager/categories_cubit/categories_cubit.dart';
import '../widgets/category_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (kDebugMode) {
            print(state);
          }
        },
        builder: (context, state) {
          if (state is GetUserDataLoading) {
            return Scaffold(body: LoadingWidget());
          } else if (state is GetUserDataSuccessfully) {
            return Scaffold(
              backgroundColor: Color(0xffFDFDFD),
              appBar: AppBar(
                leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                title: Image.asset(
                  "assets/logo/logoipsum-255 1.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                centerTitle: true,
                actions: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      context.read<HomeCubit>().currentUser!.avatar!,
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "Search for product .....",
                          hintStyle: AppTextStyle.textStyleFont14GreyNormal(),
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            color: Color(0xffBBBBBB),
                          ),
                          suffixIcon: Icon(
                            Icons.mic_outlined,
                            color: Color(0xffBBBBBB),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Categories",
                        style: AppTextStyle.textStyleFont18BlackBold(),
                      ),
                      SizedBox(height: 10.0),
                      BlocProvider(
                        create:
                            (context) => CategoriesCubit()..getAllCategories(),
                        child: BlocBuilder<CategoriesCubit, CategoriesState>(
                          builder: (context, state) {
                            if (state is GetAllCategoriesLoading) {
                              return LinearProgressIndicator(
                                color: AppColors.kPrimaryColor,
                              );
                            } else if (state is GetAllCategoriesSuccessfully) {
                              return SizedBox(
                                height: 100.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,

                                  itemCount: state.allCategoreies.length,
                                  itemBuilder: (context, index) {
                                    return CategoryWidget(
                                      title: state.allCategoreies[index].name!,
                                      imageUrl:
                                          state.allCategoreies[index].image!,
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Text("err");
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Text(
                          "Offers",
                          style: AppTextStyle.textStyleFont18BlackBold(),
                        ),
                      ),
                      CarouselSlider(
                        items: [
                          CachedNetworkImage(
                            imageUrl:
                                "https://img.freepik.com/free-vector/hand-drawn-student-discount-sale-banner_23-2150594834.jpg?semt=ais_hybrid&w=740&q=80",
                            fit: BoxFit.cover,
                          ),
                        ],
                        options: CarouselOptions(
                          height: 120,
                          aspectRatio: 1.1 / 1.2,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(
                            milliseconds: 800,
                          ),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.2,
                          onPageChanged: (index, reason) {},
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Products",
                        style: AppTextStyle.textStyleFont18BlackBold(),
                      ),
                      SizedBox(height: 10.0),
                      BlocProvider(
                        create: (context) => ProductCubit()..getAllProducts(),
                        child: BlocBuilder<ProductCubit, ProductState>(
                          builder: (context, state) {
                            if(state is GetAllProductsLoading){
                              return const LoadingWidget();
                            }
                            else if(state is GetAllProductsSuccessfully) {
                              return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1/1.8
                                ),
                                itemCount: state.allProducts.length,
                                itemBuilder: (context, index) {
                                  var currProduct = state.allProducts[index];
                                  return ProductCard(
                                    productModel: currProduct,
                                  );
                                },
                              );
                            }
                            else{
                              return Center(
                                child: Text(
                                  "err",
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }
}
