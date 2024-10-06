import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecom/services/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to delay the fetchProducts call until after the build phase.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (productProvider.products.isEmpty) {
            return Center(child: Text('No products available'));
          }

          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              return ListTile(
                leading: Image.network(product.thumbnail),
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
              );
            },
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:ecom/services/product_service.dart';
// import 'package:ecom/services/remote_config.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Use addPostFrameCallback to delay the fetchProducts call until after the build phase.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final productProvider = Provider.of<ProductProvider>(context, listen: false);
//       productProvider.fetchProducts();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product List'),
//       ),
//       body: Consumer2<ProductProvider, RemoteConfigService>(
//         builder: (context, productProvider, remoteConfig, child) {
//           if (productProvider.loading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (productProvider.products.isEmpty) {
//             return const Center(child: Text('No products available'));
//           }

//           return ListView.builder(
//             itemCount: productProvider.products.length,
//             itemBuilder: (context, index) {
//               final product = productProvider.products[index];

//               // Check if we should display the discounted price
//               final showDiscountedPrice = remoteConfig.showDiscountedPrice;
//               final priceToShow = showDiscountedPrice
//                   ? product.discountedPrice.toStringAsFixed(2)
//                   : product.price.toStringAsFixed(2);

//               return ListTile(
//                 leading: Image.network(product.thumbnail),
//                 title: Text(product.title),
//                 subtitle: Text('\$$priceToShow'), // Display appropriate price
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

