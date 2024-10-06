import 'package:flutter/material.dart';

import '../../../../constants.dart';

class ProductReturnsScreen extends StatelessWidget {
  final String returnPolicy;
  const ProductReturnsScreen({super.key, required this.returnPolicy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    child: BackButton(),
                  ),
                  Text(
                    "Return Policy",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            (returnPolicy.toString().toLowerCase().trim() ==
                    ('No return policy').toLowerCase().trim())
                ? const Text('No return policy')
                : Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Text(
                      "Our return policy allows you to return products within ${returnPolicy.split(' ').first} days of receiving your order. Items must be in their original packaging, unused, and with all tags attached. Please note that certain items, such as intimate apparel and personal care products, cannot be returned for hygiene reasons.\n\n"
                      "To initiate a return, please visit our website or app and follow the return instructions. You can also reach out to our customer support team for assistance. Once we receive your return and verify its condition, we will process your refund or exchange within 7-10 business days.\n\n"
                      "In case of defective or damaged items, we will cover the return shipping costs. However, if you are returning for other reasons, the return shipping costs will be borne by you. If you wish to exchange a product, please make sure to indicate the preferred item in your return request.\n\n"
                      "For any queries regarding our return policy, feel free to contact our customer support team. We are here to help!",
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
