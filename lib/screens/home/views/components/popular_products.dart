import 'package:ecom/screens/product/views/product_details_screen.dart';
import 'package:ecom/services/product_service.dart';
import 'package:ecom/utils/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({
    super.key,
  });

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.fetchProducts(); // Fetch products after build
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Popular Products",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        // const ProductsSkelton(),
        SizedBox(
          height: 220,
          child: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                // Find demoPopularProducts on models/ProductModel.dart
                itemCount: productProvider.products.length,
                itemBuilder: (context, index) {
                  final demoPopularProducts = productProvider.products[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == productProvider.products.length - 1
                          ? defaultPadding
                          : 0,
                    ),
                    child: ProductCard(
                      image: demoPopularProducts.thumbnail,
                      brandName: demoPopularProducts.brand ?? '',
                      title: demoPopularProducts.title,
                      price: demoPopularProducts.price,
                      priceAfetDiscount: double.parse(demoPopularProducts
                          .discountedPrice
                          .toStringAsFixed(2)),
                      dicountpercent:
                          demoPopularProducts.discountPercentage.toInt(),
                      press: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              // bool isProductAvailable = settings.arguments as bool? ?? true;
                              return ProductDetailsScreen(
                                product: demoPopularProducts,
                              );
                            },
                            settings: RouteSettings(arguments: index.isEven),
                          ),
                        );
                      },
                    ),
                  );
                });
          }),
        )
      ],
    );
  }
}
