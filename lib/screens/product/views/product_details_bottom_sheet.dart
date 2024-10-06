import 'package:ecom/constants.dart';
import 'package:ecom/models.dart';
import 'package:flutter/material.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  final Product product;

  const ProductDetailsBottomSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 2,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Product Details",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              leading: const BackButton(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Handle favorite action
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 16, color: greyColor),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Price: \$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Dimensions: ${product.dimensions.width} x ${product.dimensions.height} x ${product.dimensions.depth} cm',
                      style: const TextStyle(fontSize: 16, color: greyColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Warranty: ${product.warrantyInformation}',
                      style: const TextStyle(fontSize: 16, color: greyColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Availability: ${product.availabilityStatus}',
                      style: const TextStyle(fontSize: 16, color: greyColor),
                    ),
                    const SizedBox(height: defaultPadding),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
