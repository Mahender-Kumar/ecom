// import 'package:ecom/constants.dart';
// import 'package:ecom/services/product_service.dart';
// import 'package:ecom/skleton/product/products_skelton.dart';
// import 'package:ecom/utils/product/product_card.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CategoryProduct extends StatelessWidget {
//   final String? category;
//   final String? categoryName;
//   final List<String>? tags;
//   const CategoryProduct(
//       {super.key, this.category, this.tags, this.categoryName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               floating: true,
//               title: Text(categoryName ?? ''),
//             ),
//             SliverToBoxAdapter(
//               child: SizedBox(
//                 height: 220,
//                 child: FutureBuilder(
//                     future: Provider.of<ProductProvider>(context, listen: false)
//                         .fetchProductList(category: category),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const ProductsSkelton();
//                       }
//                       final productList = snapshot.data ?? [];

//                       return ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: productList.length,
//                           itemBuilder: (context, index) {
//                             final demoPopularProducts = productList[index];
//                             return Padding(
//                               padding: EdgeInsets.only(
//                                   left: defaultPadding,
//                                   right: index == 4 ? defaultPadding : 0),
//                               child: ProductCard(
//                                 image: demoPopularProducts.thumbnail,
//                                 brandName: demoPopularProducts.brand ?? '',
//                                 title: demoPopularProducts.title,
//                                 price: demoPopularProducts.price,
//                                 priceAfetDiscount: double.parse(
//                                     demoPopularProducts.discountedPrice
//                                         .toStringAsFixed(2)),
//                                 dicountpercent: demoPopularProducts
//                                     .discountPercentage
//                                     .toInt(),
//                                 press: () {},
//                               ),
//                             );
//                           });
//                     }),
//               ),
//             ),
//             const SliverToBoxAdapter(
//               child: SizedBox(height: defaultPadding),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:ecom/constants.dart';
import 'package:ecom/screens/product/views/product_details_screen.dart';
import 'package:ecom/services/product_service.dart';
import 'package:ecom/skleton/product/products_skelton.dart';
import 'package:ecom/utils/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProduct extends StatelessWidget {
  final String? category;
  final String? categoryName;
  final List<String>? tags;

  const CategoryProduct({
    super.key,
    this.category,
    this.tags,
    this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              title: Text(categoryName ?? ''),
            ),
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: Provider.of<ProductProvider>(context, listen: false)
                    .fetchProductList(category: category),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const GridProductsSkelton();
                  }
                  final productList = snapshot.data ?? [];

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: defaultPadding,
                      mainAxisSpacing: defaultPadding,
                    ),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final demoPopularProducts = productList[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: index % 2 == 0 ? defaultPadding : 0,
                          right: defaultPadding,
                        ),
                        child: ProductCard(
                          image: demoPopularProducts.thumbnail,
                          brandName: demoPopularProducts.brand ?? '',
                          title: demoPopularProducts.title,
                          price: demoPopularProducts.price,
                          priceAfetDiscount: double.parse(
                            demoPopularProducts.discountedPrice
                                .toStringAsFixed(2),
                          ),
                          dicountpercent:
                              demoPopularProducts.discountPercentage.toInt(),
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
                    },
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            ),
          ],
        ),
      ),
    );
  }
}
