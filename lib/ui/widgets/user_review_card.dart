import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/database/models/rating_model.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';

class ReviewCard extends StatelessWidget {
  final UserRatingModel review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              child: Icon(
                CupertinoIcons.person,
                size: 50,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(review.user['name']),
                      const Expanded(child: sizedBox),
                      const RatingBar.readOnly(
                        filledIcon: CupertinoIcons.heart_fill,
                        emptyIcon: CupertinoIcons.heart,
                        size: 28,
                        initialRating: 2.5,
                        maxRating: 5,
                        filledColor: Colors.black87,
                        emptyColor: Colors.black12,
                      ),
                    ],
                  ),
                  sizedBox,
                  Text(review.reviewText),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
