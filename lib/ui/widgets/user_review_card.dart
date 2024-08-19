import 'dart:convert';

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
    //print(review.user);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: review.user.containsKey('user_image')
                  ? MemoryImage(
                      base64Decode(review.user['user_image']),
                    )
                  : null,
              child: review.user.containsKey('user_image')
                  ? null
                  : const Icon(
                      CupertinoIcons.person,
                      size: 50,
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(review.user['user_name'] ?? ''),
                      const Expanded(child: sizedBox),
                      RatingBar.readOnly(
                        filledIcon: CupertinoIcons.heart_fill,
                        emptyIcon: CupertinoIcons.heart,
                        size: 28,
                        initialRating: review.rating,
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
