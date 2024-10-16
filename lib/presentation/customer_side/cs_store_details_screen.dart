import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/product_model.dart';
import '../../data/models/store_model.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/productCard.dart';
import 'cs_product_details_screen.dart';
// Import your product model

class StoreDetailsScreen extends StatelessWidget {
  final Store store;

  const StoreDetailsScreen({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            // title: Text(store.name),
            ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[200],
                    // Optional: Background color for the avatar
                    child: store.image != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: store.image!,
                              height: 80,
                              // Set to double the radius for better coverage
                              width: 80,
                              // Set to double the radius for better coverage
                              fit: BoxFit.cover,
                              // Cover the CircleAvatar while maintaining aspect ratio
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )
                        : const Icon(Icons.store,
                            size: 40), // Use a smaller size for the icon
                  ),
                  const SizedBox(width: 16),
                  Text(
                    store.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text("${store.bio}"),
              const SizedBox(height: 8),
              Text("تواصل معنا: ${store.contactInfo} "),
              const SizedBox(height: 16),
              Text("منتجاتنا :",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(
                // Expand to take available space
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 3,
                    crossAxisCount: 2, // Number of columns
                    childAspectRatio: 0.82, // Aspect ratio for each card
                  ),
                  itemCount: store.products?.length ?? 0,
                  itemBuilder: (context, index) {
                    final product =
                        store.products![index]; // Get the Product object
                    return ProductCard(
                      productName: product.name,
                      price: product.price,
                      thumbnail: product.thumbnail,
                      onTap: () {
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
store: store,
                              ),
                            ),
                          );
                        }
                        ;
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
