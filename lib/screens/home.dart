import 'package:ecom/services/remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecom/services/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Consumer2<ProductProvider, RemoteConfigService>(
        builder: (context, productProvider, remoteConfig, child) {
          if (productProvider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productProvider.products.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];

              // Check if the remote config dictates to show the discounted price
              print(remoteConfig.showDiscountedPrice);
              final showDiscountedPrice = remoteConfig.showDiscountedPrice;
              final priceToShow = showDiscountedPrice
                  ? product.discountedPrice.toStringAsFixed(2)
                  : product.price.toStringAsFixed(2);

              return ListTile(
                leading: Image.network(product.thumbnail),
                title: Text(product.title),
                subtitle: Text(
                    '${product.price} \$$priceToShow'), // Display discounted or original price
              );
            },
          );
        },
      ),
    );
  }
}
