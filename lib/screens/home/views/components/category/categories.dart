import 'package:ecom/screens/home/views/components/category/components/category_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constants.dart';

class CategoryModel {
  final String name;
  final String category;
  final List<String>? tags;
  final String? svgSrc, route;

  CategoryModel({
    this.tags,
    required this.name,
    required this.category,
    this.svgSrc,
    this.route,
  });
}

List<CategoryModel> demoCategories = [
  CategoryModel(name: "All Categories", category: ''),
  CategoryModel(
      name: "Kitchen",
      svgSrc: "assets/icons/kitchen.svg",
      category: 'kitchen-accessories'),
  CategoryModel(
      name: "Decoration",
      svgSrc: "assets/icons/decoration.svg",
      category: 'home-decoration'),
  CategoryModel(
      name: "Furniture",
      svgSrc: "assets/icons/furniture.svg",
      category: 'furniture'),
  CategoryModel(
      name: "Electronics",
      svgSrc: "assets/icons/electronics.svg",
      category: 'laptops',
      tags: ['mobile,laptop']),
  CategoryModel(
      name: "MotorCycles",
      svgSrc: "assets/icons/motorcycle.svg",
      category: 'motorcycle'),
  CategoryModel(
      name: "Sports",
      svgSrc: "assets/icons/sports.svg",
      category: 'sports-accessories'),
  CategoryModel(
    name: "Accessories",
    svgSrc: "assets/icons/Man.svg",
    category: '',
  ),
  CategoryModel(
    name: "Beauty",
    svgSrc: "assets/icons/beauty.svg",
    category: 'beauty',
  ),
  CategoryModel(
    name: "Skin Care",
    svgSrc: "assets/icons/beauty.svg",
    category: "skin-care",
  ),
  CategoryModel(
      name: "Woman's",
      svgSrc: "assets/icons/Woman.svg",
      category: 'woman',
      tags: ['woman']),
  CategoryModel(
      name: "Man's",
      svgSrc: "assets/icons/Man.svg",
      category: 'man',
      tags: ['man']),
  CategoryModel(
      name: "Groceries",
      svgSrc: "assets/icons/groceries.svg",
      category: 'groceries'),
];
// End For Preview

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            demoCategories.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? defaultPadding : defaultPadding / 2,
                  right:
                      index == demoCategories.length - 1 ? defaultPadding : 0),
              child: CategoryBtn(
                category: demoCategories[index].name,
                svgSrc: demoCategories[index].svgSrc,
                isActive: index == 0,
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CategoryProduct(
                          category: demoCategories[index].category,
                          categoryName: demoCategories[index].name,
                        );
                      },
                      settings: RouteSettings(arguments: index.isEven),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    required this.category,
    this.svgSrc,
    required this.isActive,
    required this.press,
  });

  final String category;
  final String? svgSrc;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.transparent,
          border: Border.all(
              color: isActive
                  ? Colors.transparent
                  : Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            if (svgSrc != null)
              SvgPicture.asset(
                svgSrc!,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
            if (svgSrc != null) const SizedBox(width: defaultPadding / 2),
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
