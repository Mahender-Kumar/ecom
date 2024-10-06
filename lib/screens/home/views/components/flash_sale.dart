import 'package:ecom/constants.dart';
import 'package:ecom/screens/product/views/product_details_screen.dart';
import 'package:ecom/services/product_service.dart';
import 'package:ecom/skleton/product/products_skelton.dart';
import 'package:ecom/utils/Banner/M/banner_m_with_counter.dart';
import 'package:ecom/utils/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BannerMWithCounter(
          duration: const Duration(hours: 8),
          text: "Super Flash Sale \n50% Off",
          press: () {},
        ),
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Flash sale",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(
          height: 220,
          child: FutureBuilder(
              future: Provider.of<ProductProvider>(context, listen: false)
                  .fetchProductList(category: 'womens-dresses'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ProductsSkelton();
                }
                return Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                  final productList = snapshot.data ?? [];
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        final demoFlashSaleProducts = productList[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            left: defaultPadding,
                            right: index == productProvider.products.length - 1
                                ? defaultPadding
                                : 0,
                          ),
                          child: ProductCard(
                            image: demoFlashSaleProducts.thumbnail,
                            brandName: demoFlashSaleProducts.brand ?? "",
                            title: demoFlashSaleProducts.title,
                            price: demoFlashSaleProducts.price,
                            priceAfetDiscount: double.parse(
                                demoFlashSaleProducts.discountedPrice
                                    .toStringAsFixed(2)),
                            dicountpercent: demoFlashSaleProducts
                                .discountPercentage
                                .toInt(),
                            press: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    // bool isProductAvailable = settings.arguments as bool? ?? true;
                                    return ProductDetailsScreen(product: demoFlashSaleProducts,);
                                  },
                                  settings:
                                      RouteSettings(arguments: index.isEven),
                                ),
                              );
                            },
                          ),
                        );
                      });
                });
              }),
        ),
      ],
    );
  }
}
