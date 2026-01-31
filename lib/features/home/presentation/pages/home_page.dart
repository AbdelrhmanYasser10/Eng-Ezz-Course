import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/pages/fav_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/core/widgets/loading_widget.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/pages/login_page.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/product_cubit/product_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../features/profile/presentation/pages/profile_page.dart';
import '../manager/categories_cubit/categories_cubit.dart';
import '../widgets/category_widget.dart';
import '../widgets/products_grid_widget.dart';
import 'package:e_commerce_app_session_it_sharks/injection_container.dart' as di;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getUserData();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetUserDataError) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginPage()),
          );
        }
      },
      builder: (context, state) {
        if (state is GetUserDataLoading) {
          return Scaffold(body: LoadingWidget());
        } else if (state is GetUserDataSuccessfully) {
          context.read<ProductCubit>().getAllProducts();
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
              title: Image.asset(
                "assets/logo/logoipsum-255 1.png",
                width: 100.w,
                height: 100.h,
                fit: BoxFit.contain,
              ),
              centerTitle: true,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfilePage(
                          user: context.read<HomeCubit>().currentUser!,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 18.r,
                    backgroundImage: NetworkImage(
                      context.read<HomeCubit>().currentUser!.avatar ?? "",
                    ),
                  ),
                ),
                SizedBox(width: 2.w,),

                InkWell(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>FavPage()));
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.red ,
                    child: Icon(
                      Icons.favorite_border,
                      size: 18,
                      color:Colors.white ,
                    ),
                  ),
                ),
                SizedBox(width: 5.w,),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(20.0.r),
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
                        hintText: S.of(context).searchForProduct,
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
                    SizedBox(height: 10.0.h),
                    Text(
                      S.of(context).categories,
                      style: AppTextStyle.textStyleFont18BlackBold(),
                    ),
                    SizedBox(height: 10.0.h),
                    BlocProvider(
                      create:
                          (context) => di.sl<CategoriesCubit>()..getAllCategories(),
                      child: BlocBuilder<CategoriesCubit, CategoriesState>(
                        builder: (context, state) {
                          if (state is GetAllCategoriesLoading) {
                            return LinearProgressIndicator(
                              color: AppColors.kPrimaryColor,
                            );
                          } else if (state is GetAllCategoriesSuccessfully) {
                            // Show up category widget list
                            return SizedBox(
                              height: 100.0.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,

                                itemCount: state.allCategoreies.length,
                                itemBuilder: (context, index) {
                                  return CategoryWidget(
                                    value: context.read<ProductCubit>(),
                                    categoryModel:
                                        state.allCategoreies[index],
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
                    SizedBox(height: 10.0.h),
                    Center(
                      child: Text(
                        S.of(context).offers,
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
                        height: 120.h,
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
                    SizedBox(height: 10.0.h),
                    Text(
                      S.of(context).products,
                      style: AppTextStyle.textStyleFont18BlackBold(),
                    ),
                    SizedBox(height: 10.0.h),
                    ProductsGridWidget(
                      errorState: GetAllProductsError(),
                      loadingState: GetAllProductsLoading(),
                      type: ProductsType.HOME_PRODUCTS,
                      isScrollable: false,
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
    );
  }
}
