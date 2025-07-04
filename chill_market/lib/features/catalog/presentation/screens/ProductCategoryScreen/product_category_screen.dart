import 'package:chill_market/core/Service/ThemeService/app_theme.dart';
import 'package:chill_market/features/cart/domain/entity/product.dart';
import 'package:chill_market/features/cart/domain/entity/product_cart.dart';
import 'package:chill_market/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:chill_market/features/cart/presentation/bloc/cart_event.dart';
import 'package:chill_market/features/catalog/domain/entity/product.dart';
import 'package:chill_market/features/catalog/presentation/screens/ProductCategoryScreen/bloc/category_bloc.dart';
import 'package:chill_market/features/catalog/presentation/screens/ProductCategoryScreen/bloc/category_event.dart';
import 'package:chill_market/features/catalog/presentation/screens/ProductCategoryScreen/bloc/category_state.dart';
import 'package:chill_market/features/catalog/presentation/screens/ProductsScreen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCategoryScreen extends StatelessWidget {
  const ProductCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        title: Center(
          child: Text(
            'Категории',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 28)),
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),

            sliver: SliverGrid.builder(
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 14,
                childAspectRatio: 1.47,
              ),
              itemBuilder: (context, index) {
                final Map<String, List<String>> categoryProducts = {
                  'Одежда': ['clothes', 'https://i.imgur.com/QkIa5tT.jpeg'],
                  'Электронника': [
                    'electronics',
                    'https://i.imgur.com/ZANVnHE.jpeg',
                  ],
                  'Мебель': ['furniture', 'https://i.imgur.com/Qphac99.jpeg'],
                  'Обувь': ['shoes', 'https://i.imgur.com/qNOjJje.jpeg'],
                  'Разнообразный': [
                    'miscellaneous',
                    'https://i.imgur.com/BG8J0Fj.jpg',
                  ],
                };
                final List<String> categoryName =
                    categoryProducts.keys.toList();
                final List<List<String>> categorySlug =
                    categoryProducts.values.toList();
                return InkWell(
                  onTap: () {
                    BlocProvider.of<CategoryBloc>(context).add(
                      CategorySearchBySlug(slug: categorySlug[index].first),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                categoryName[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.network(
                                height: 75,
                                width: 75,
                                categorySlug[index][1],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 23)),
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Отсортированные',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryInitial) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Выберите категорию',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is CategoryLoading) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 80),
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
                );
              } else if (state is CategoryLoaded) {
                return SliverPadding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  sliver: SliverGrid.builder(
                    itemCount: state.productsSort.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 7,
                      childAspectRatio: 0.67,
                    ),
                    itemBuilder: (context, index) {
                      final List<Product> products = state.productsSort;
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ProductScreen(id: products[index].id),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 169,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.network(
                                    products[index].images.first,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (_, __, ___) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              SizedBox(height: 7),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    products[index].title.length > 20
                                        ? "${products[index].title.substring(0, 16)}.."
                                        : products[index].title,
                                  ),
                                  Text(
                                    style: TextStyle(
                                      color: AppTheme.priceColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    products[index].price.toString().length > 5
                                        ? "${products[index].price.toString().substring(0, 5)}.."
                                        : '${products[index].price}\$',
                                  ),
                                ],
                              ),
                              Text(
                                products[index].description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 7),
                              SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<CartBloc>(context).add(
                                      AddProductEvent(
                                        productCart: ProductCart(
                                          id: products[index].id,
                                          product: ProductC(
                                            id: products[index].id,
                                            title: products[index].title,
                                            price: products[index].price,
                                            description:
                                                products[index].description,
                                            images:
                                                products[index].images.first,
                                          ),
                                          count: 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Заказать'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is CategoryError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(state.error)),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(child: Text('Перезапустите приложение')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
