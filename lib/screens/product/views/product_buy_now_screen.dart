import 'package:ecom/utils/cart_button.dart';
import 'package:ecom/utils/custom_modal_bottom_sheet.dart';
import 'package:ecom/models.dart';
import 'package:ecom/screens/product/views/added_to_cart_message_screen.dart';
import 'package:ecom/screens/product/views/components/product_list_tile.dart'; 
import 'package:ecom/utils/network_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../constants.dart';
import 'components/product_quantity.dart';
import 'components/selected_colors.dart';
import 'components/selected_size.dart';
import 'components/unit_price.dart';

class ProductBuyNowScreen extends StatefulWidget {
  final Product product;
  const ProductBuyNowScreen({super.key, required this.product});

  @override
  ProductBuyNowScreenState createState() => ProductBuyNowScreenState();
}

class ProductBuyNowScreenState extends State<ProductBuyNowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CartButton(
        price: widget.product.price,
        title: "Add to cart",
        subTitle: "Total price",
        press: () {
          customModalBottomSheet(
            context,
            isDismissible: false,
            child: const AddedToCartMessageScreen(),
          );
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2, vertical: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Text(
                  widget.product.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset("assets/icons/Bookmark.svg",
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: AspectRatio(
                      aspectRatio: 1.05,
                      child: NetworkImageWithLoader(widget.product.images[0]),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            price: widget.product.price,
                            priceAfterDiscount: widget.product.discountedPrice,
                          ),
                        ),
                        ProductQuantity(
                          numOfItem: 2,
                          onIncrement: () {},
                          onDecrement: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider()),
                SliverToBoxAdapter(
                  child: SelectedColors(
                    colors: const [
                      Color(0xFFEA6262),
                      Color(0xFFB1CC63),
                      Color(0xFFFFBF5F),
                      Color(0xFF9FE1DD),
                      Color(0xFFC482DB),
                    ],
                    selectedColorIndex: 2,
                    press: (value) {},
                  ),
                ),
                SliverToBoxAdapter(
                  child: SelectedSize(
                    sizes: const ["S", "M", "L", "XL", "XXL"],
                    selectedIndex: 1,
                    press: (value) {},
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  sliver: ProductListTile(
                    title: "Size guide",
                    svgSrc: "assets/icons/Sizeguid.svg",
                    isShowBottomBorder: true,
                    press: () {
                     
                    },
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: defaultPadding / 2),
                        Text(
                          "Store pickup availability",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        const Text(
                            "Select a size to check store availability and In-Store pickup options.")
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  sliver: ProductListTile(
                    title: "Check stores",
                    svgSrc: "assets/icons/Stores.svg",
                    isShowBottomBorder: true,
                    press: () {
                     
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding))
              ],
            ),
          )
        ],
      ),
    );
  }
}
