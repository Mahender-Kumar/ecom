import 'package:ecom/screens/product/views/product_details_screen.dart';
import 'package:ecom/services/product_service.dart';
import 'package:ecom/services/remote_config.dart';
import 'package:ecom/skleton/product/secondery_produts_skelton.dart';
import 'package:ecom/utils/product/secondary_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({
    super.key,
  });

  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
 
  @override
  Widget build(BuildContext context) {
    final remoteConfigService = Provider.of<RemoteConfigService>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Most popular",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        SizedBox(
          height: 114,
          child: FutureBuilder(
              future: Provider.of<ProductProvider>(context, listen: false)
                  .fetchProductList(category: 'mens-shoes'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SeconderyProductsSkelton();
                }
                final productList = snapshot.data ?? [];
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final demoPopularProducts = productList[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: defaultPadding,
                          right: index == productList.length - 1
                              ? defaultPadding
                              : 0,
                        ),
                        child: SecondaryProductCard(
                          image: demoPopularProducts.thumbnail,
                          brandName: demoPopularProducts.brand ?? '',
                          title: demoPopularProducts.title,
                          price: demoPopularProducts.price,
                          priceAfetDiscount: remoteConfigService
                                  .showDiscountedPrice
                              ? double.parse(demoPopularProducts.discountedPrice
                                  .toStringAsFixed(2))
                              : null,
                          dicountpercent: remoteConfigService
                                  .showDiscountedPrice
                              ? demoPopularProducts.discountPercentage.toInt()
                              : null,
                          press: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductDetailsScreen(
                                    product: demoPopularProducts,
                                  );
                                },
                                settings:
                                    RouteSettings(arguments: index.isEven),
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
