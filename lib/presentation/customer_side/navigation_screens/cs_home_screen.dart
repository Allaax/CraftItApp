import 'package:craft_it/core/theme/app_colors.dart';
import 'package:craft_it/widgets/productCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bloc/cubit/category_cubit.dart';
import '../../../bloc/cubit/product_cubit.dart'; // Import ProductCubit
import '../../../bloc/state/category_state.dart';
import '../../../bloc/state/product_state.dart';
import '../cart_screen.dart';
import '../cs_product_details_screen.dart'; // Import ProductState

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    // Fetch products when the HomeScreen is initialized
    BlocProvider.of<ProductCubit>(context).fetchProducts();
  }

  final Map<String, String> categoryIcons = {
    'مجوهرات': 'assets/icons/jewelry.svg',  // Custom jewelry icon
    'ديكور منزلي': 'assets/icons/decore.svg', // Custom home decor icon
    'منتجات العناية': 'assets/icons/care.svg', // Custom care products icon
    'كروشيه': 'assets/icons/yarn.svg', // Custom yarn (crochet) icon
    'شموع': 'assets/icons/candle.svg', // Custom candle icon
    // Add more categories and their corresponding icons here
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFFEEEDED)
                    : AppColors.lightText,
              ),
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()))
              },
            ),
          ),
        ],
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'الرئيسية',
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ProductCubit>(context).fetchProducts();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar section...
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 14),
                child: SearchAnchor(builder:
                    (BuildContext context, SearchController controller) {
                  return SearchBar(
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.dark
                        ? AppColors.cardsBackgroundDark
                        : AppColors.white,),
                    elevation: const MaterialStatePropertyAll(0),
                    padding: const MaterialStatePropertyAll(EdgeInsets.only(right: 12)),
                    constraints: const BoxConstraints.tightFor(width: 380 ,height: 40),
                    controller: controller,
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    hintText: "أبحث عن المنتجات ",
                    leading: const Icon(Icons.search),
                  );
                }, suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List.generate(5, (index) {
                    final String item = 'item $index ';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                }),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "الفئات",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "عرض الكل",
                      style: TextStyle(fontSize: 16, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              BlocBuilder<CategoryCubit, CategoryState>(
                // CategoryBlocBuilder
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoryLoaded) {
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          String category = state.categories[index];

                          return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? AppColors.avatarBackgrounddark
                                              : AppColors.cardsBackgroundLight,
                                      radius: 30,
                                      child:  SvgPicture.asset(
                                        categoryIcons[category] ??
                                            'assets/icons/default_icon.svg', // Fallback if category icon not found
                                        height: 30,
                                        width: 30,

                                        color: AppColors.primary, // Icon color
                                      ),
                                    ),
                                    Text(
                                      state.categories[index],
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    );
                  } else if (state is CategoryError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text("No categories available"));
                  }
                },
              ),


            const Padding(padding: EdgeInsets.only(right: 14 , bottom: 16 ,top: 10) ,child:   Text(
              "أخر العروض",
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),),
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
                    return Expanded(
                      // Expand to take available space
                      child: GridView.builder(

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 3,
                          crossAxisCount: 2, // Number of columns
                          childAspectRatio: 0.84, // Aspect ratio for each card

                        ),
                        itemCount: state.products.length,

                        itemBuilder: (context, index) {

                          final product = state.products[index];

                          return ProductCard(
                            productName: product.name,
                            price: product.price,
                            thumbnail: product.thumbnail,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    product: product,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  } else if (state is ProductError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text("No products available"));
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
