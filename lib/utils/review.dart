import 'package:ecom/models.dart';

import 'package:ecom/screens/product/views/review_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../constants.dart';

class ReviewsScreen extends StatelessWidget {
//   const ReviewsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// class ReviewsScreen extends StatefulWidget {
  final Product product;
  const ReviewsScreen({super.key, required this.product});

//   @override
//   ReviewsScreenState createState() => ReviewsScreenState();
// }

// class ReviewsScreenState extends State<ReviewsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              centerTitle: true,
              title: Text(
                'Reviews',
                style: Theme.of(context).textTheme.titleSmall,
              ),
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
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  'Customer Reviews',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: blackColor,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final review = product.reviews[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.035),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 72,
                                  child: Text(
                                    review.reviewerName,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                                RatingBar.builder(
                                  initialRating: review.rating.toDouble(),
                                  itemSize: 16,
                                  itemPadding: const EdgeInsets.only(
                                      right: defaultPadding / 4),
                                  unratedColor: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.08),
                                  glow: false,
                                  allowHalfRating: true,
                                  ignoreGestures: true,
                                  onRatingUpdate: (value) {},
                                  itemBuilder: (context, index) =>
                                      SvgPicture.asset(
                                          "assets/icons/Star_filled.svg"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(review.comment),
                            const SizedBox(height: 4),
                            Text(
                              'Date: ${review.date}',
                              style: const TextStyle(color: greyColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: product.reviews.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: defaultPadding)),
          ],
        ),
      ),
    );
  }
}
