import 'package:cached_network_image/cached_network_image.dart';
import 'package:craft_it/presentation/cutomer_side/store_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit/store_cubit.dart';
import '../../../bloc/state/store_state.dart';
import '../../../core/theme/app_colors.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
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
                    ? Color(0xFFEEEDED)
                    : AppColors.lightText,
              ),
              onPressed: () => {}, // Add functionality for the cart
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'المتاجر',
            style: TextStyle(
              fontSize: 20, // Adjust font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // BlocProvider.of<ProductCubit>(context).fetchProducts();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.cardsBackgroundDark
                            : AppColors.white,
                      ),
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(EdgeInsets.only(right: 12)),
                      constraints: BoxConstraints.tightFor(width: double.infinity, height: 40), // Use full width
                      controller: controller,
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      hintText: "أبحث عن المتاجر ",
                      leading: Icon(Icons.search),
                    );
                  },
                  suggestionsBuilder: (BuildContext context, SearchController controller) {
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
                  },
                ),
              ),
              // Store List
              Expanded(
                child: BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
                  if (state is StoreLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StoresLoaded) {
                    final stores = state.stores;
                    return ListView.builder(
                      padding: EdgeInsets.only(left: 10,right: 10),

                      itemCount: stores.length,
                      itemBuilder: (context, index) {
                        final store = stores[index];
                        return Card(
                          // Wrap the list item in a Card widget
                          elevation: 0, // Shadow effect for the card
                          margin: const EdgeInsets.symmetric(vertical: 8), // Margin between cards
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to store details when tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoreDetailsScreen(store: store),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0), // Rounded corners for store image
                                  child: store.image != null
                                      ? CachedNetworkImage(
                                    imageUrl: store.image.toString(),
                                    width: double.infinity, // Full width
                                    height: 150, // Height for the image
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                  )
                                      : const Icon(Icons.store, size: 150), // Fallback icon
                                ),
                                const SizedBox(height: 8), // Space between image and text
                                Padding(
                                  padding: const EdgeInsets.all(8.0), // Inner padding for text
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        store.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18, // Adjust font size as needed
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is StoreError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text("No stores available"));
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
