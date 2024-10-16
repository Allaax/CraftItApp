import 'package:carousel_slider/carousel_slider.dart';
import 'package:craft_it/data/models/store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/cubit/auth_cubit.dart';
import '../../bloc/cubit/cart_cubit.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final Store? store;

  const ProductDetailScreen({Key? key, this.store, required this.product})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;
  String? selectedSize;
  String? selectedColor;
  int _quantity = 1; // default quantity

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthCubit>(context).currentUser;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            // title: Text(widget.product.name),
            ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Carousel
                CarouselSlider.builder(
                  itemCount: widget.product.images.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.product.images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 300,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                // Image Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.product.images.map((url) {
                    int index = widget.product.images.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentImageIndex == index
                            ? AppColors.primary
                            : AppColors.lightGrey,
                      ),
                    );
                  }).toList(),
                ),
                // Product Details

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Spacer(),

                      Text(
                        "${widget.product.price.toStringAsFixed(2)} د.ل",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      // Rating placeholder (if needed)
                      // const Icon(Icons.star, color: Colors.amber, size: 24),
                      // const Text(
                      //   '4.5',
                      //   style: TextStyle(fontSize: 16),
                      // ),
                    ],
                  ),
                ),
                // Product description
                Divider(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'عن المنتج :',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Text('المادة : '),
                      Text(widget.product.material, style: TextStyle()),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text('الفئة : '),
                      Text(
                        widget.product.category,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        " / ${widget.product.subcategory} ",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: widget.store != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              Text('من صنع : '),
                              TextButton(
                                onPressed: () {},
                                child: Text(widget.store!.name,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      // Add any style here
                                    )),
                              )
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Text('مدة الإنشاء : '),
                      Text(widget.product.timeToBeCreated, style: TextStyle()),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                    padding: const EdgeInsets.only(top: 10, right: 8.0),
                    child: Text(
                      'وصف للمنتج : ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )),

                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8.0),
                  child: Text(
                    widget.product.description,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                // Size selection
                // const Text(
                //   'Select Size',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(height: 8),
                // Wrap(
                //   spacing: 8.0,
                //   children: ['S', 'M', 'L', 'XL', 'XXL'].map((size) {
                //     return ChoiceChip(
                //       label: Text(size),
                //       selected: selectedSize == size,
                //       onSelected: (selected) {
                //         setState(() {
                //           selectedSize = selected ? size : null;
                //         });
                //       },
                //     );
                //   }).toList(),
                // ),
                // const SizedBox(height: 16),
                // Color selection
                Divider(),

                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8),
                  child: Text(
                    'أختر اللون',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    children: widget.product.colors.map((color) {
                      return ChoiceChip(
                        labelPadding:
                            EdgeInsets.only(left: 6, right: 6, bottom: 2),
                        selectedColor: AppColors.selected,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        label: Text(
                          color,
                          style: TextStyle(),
                        ),
                        selected: selectedColor == color,
                        onSelected: (selected) {
                          setState(() {
                            selectedColor = selected ? color : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                // Add to Cart Button
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(bottom: 8.0, right: 16, left: 16, top: 10),
          child: ElevatedButton(
            onPressed: () {
              context
                  .read<CartCubit>()
                  .addToCart(user!.id, widget.product.id, _quantity);
              Fluttertoast.showToast(
                msg: "تمت إضافة المنتج إلى السلة بنجاح",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.lightBackground
                    : AppColors.darkBackground,
                textColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.lightText
                    : AppColors.darkText,
                fontSize: 16.0,

              );
              // _showAddToCartDialog(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16.0,
              ),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'أضف إلى السلة',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
// void _showAddToCartDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Directionality(
//         textDirection: TextDirection.rtl,
//         child: AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           title: Center(
//             child: Text('تمت الإضافة إلى السلة بنجاح !' ,
//             style: TextStyle(
//               fontSize: 18
//             ),),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Close the dialog and continue shopping
//                 Navigator.of(context).pop();
//               },
//               child: Text('الاستمرار بالتسوق'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigate to the cart page
//                 Navigator.of(context).pop();
//                 // Navigator.pushNamed(context, '/cart'); // Assuming your cart route is named '/cart'
//               },
//               child: Text('الذهاب إلى السلة'),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
}
