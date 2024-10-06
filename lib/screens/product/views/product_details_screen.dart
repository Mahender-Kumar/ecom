import 'package:ecom/screens/product/views/product_details_bottom_sheet.dart';
import 'package:ecom/utils/cart_button.dart';
import 'package:ecom/constants.dart';
import 'package:ecom/utils/custom_modal_bottom_sheet.dart';
import 'package:ecom/models.dart';
import 'package:ecom/screens/product/views/product_returns_screen.dart';
import 'package:ecom/screens/product/views/review_card.dart';
import 'package:ecom/services/product_service.dart';
import 'package:ecom/skleton/product/products_skelton.dart';
import 'package:ecom/utils/product/product_card.dart';
import 'package:ecom/utils/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'components/product_images.dart';
import 'components/product_info.dart';
import 'components/product_list_tile.dart';
import 'product_buy_now_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen(
      {super.key, this.isProductAvailable = true, required this.product});

  final bool isProductAvailable;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CartButton(
        price: product.price,
        press: () {
          customModalBottomSheet(
            context,
            height: MediaQuery.of(context).size.height * 0.92,
            child: ProductBuyNowScreen(
              product: product,
            ),
          );
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/icons/Bookmark.svg",
                  ),
                ),
              ],
            ),
            ProductImages(
              images: [
                ...product.images,
              ],
            ),
            ProductInfo(
              brand: product.brand ?? '',
              title: product.title,
              isAvailable: isProductAvailable,
              description: product.description,
              rating: product.getAverageRating(),
              numOfReviews: product.reviews.length,
            ),
            ProductListTile(
              svgSrc: "assets/icons/Product.svg",
              title: "Product Details",
              press: () {
                customModalBottomSheet(context,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ProductDetailsBottomSheet(
                      product: product,
                    ));
              },
            ),
            ProductListTile(
              svgSrc: "assets/icons/Delivery.svg",
              title: "Shipping Information",
              press: () {},
            ),
            ProductListTile(
              svgSrc: "assets/icons/Return.svg",
              title: "Returns",
              isShowBottomBorder: true,
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ProductReturnsScreen(
                    returnPolicy: product.returnPolicy,
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ReviewCard(
                  rating: product.getAverageRating(),
                  numOfReviews: product.reviews.length,
                  numOfFiveStar: product.countRatings()[5] ?? 0,
                  numOfFourStar: product.countRatings()[4] ?? 0,
                  numOfThreeStar: product.countRatings()[3] ?? 0,
                  numOfTwoStar: product.countRatings()[2] ?? 0,
                  numOfOneStar: product.countRatings()[1] ?? 0,
                ),
              ),
            ),
            ProductListTile(
              svgSrc: "assets/icons/Chat.svg",
              title: "Reviews",
              isShowBottomBorder: true,
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ReviewsScreen(
                    product: product,
                  ),
                );
              },
            ),
            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "You may also like",
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: FutureBuilder(
                    future: Provider.of<ProductProvider>(context, listen: false)
                        .fetchProductList(category: product.category),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ProductsSkelton();
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
                                  right: index == 4 ? defaultPadding : 0),
                              child: ProductCard(
                                image: demoPopularProducts.thumbnail,
                                brandName: demoPopularProducts.brand ?? '',
                                title: demoPopularProducts.title,
                                price: demoPopularProducts.price,
                                priceAfetDiscount: double.parse(
                                    demoPopularProducts.discountedPrice
                                        .toStringAsFixed(2)),
                                dicountpercent: demoPopularProducts
                                    .discountPercentage
                                    .toInt(),
                                press: () {},
                              ),
                            );
                          });
                    }),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}
