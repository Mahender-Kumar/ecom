import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'product_card_skelton.dart';

class ProductsSkelton extends StatelessWidget {
  const ProductsSkelton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            left: defaultPadding,
            right: index == 4 ? defaultPadding : 0,
          ),
          child: const ProductCardSkelton(),
        ),
      ),
    );
  }
}

class GridProductsSkelton extends StatelessWidget {
  const GridProductsSkelton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.only(
              left: index % 2 == 0 ? defaultPadding : 0,
              right: defaultPadding,
            ),
            child: const ProductCardSkelton());
      },
    );
  }
}
