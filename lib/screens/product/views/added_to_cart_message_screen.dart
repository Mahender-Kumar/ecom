import 'package:ecom/constants.dart';
import 'package:flutter/material.dart'; 

class AddedToCartMessageScreen extends StatelessWidget {
  const AddedToCartMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Text(
                "Added to cart",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: defaultPadding / 2),
              const Text(
                "Click the checkout button to complete the purchase process.",
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              OutlinedButton(
                onPressed: () {
                  // context.go('/');
                },
                child: const Text("Continue shopping"),
              ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Checkout"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
