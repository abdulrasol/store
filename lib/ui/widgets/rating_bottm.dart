// import 'package:custom_rating_bar/custom_rating_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// //import 'package:rating/rating.dart';
// import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
// import 'package:store/database/models/rating_model.dart';
// import 'package:store/database/services/items.dart';

// class PrintRatingController extends RatingController {
//   PrintRatingController(RatingModel ratingModel) : super(ratingModel);

//   @override
//   Future<void> ignoreForEverCallback() async {
//     //print('Rating ignored forever!');
//     await Future.delayed(const Duration(seconds: 3));
//   }

//   @override
//   Future<void> saveRatingCallback(
//       int rate, List<RatingCriterionModel> selectedCriterions) async {
//     //print('Rating saved!\nRate: $rate\nsSelectedItems: $selectedCriterions');
//     await Future.delayed(const Duration(seconds: 3));
//   }
// }

// Widget ratingBottomSheet(String productName, String productId, Map user) {
//   final textEditController = TextEditingController();
//   final btnController = RoundedLoadingButtonController();
//   const sizedBox = SizedBox(height: 10);
//   final GlobalKey<FormState> key = GlobalKey<FormState>();
//   double rating = 1;

//   return Form(
//     key: key,
//     child: Container(
//       // Add your bottom sheet content here
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('Rate and tell us your review about $productName'),
//           sizedBox,
//           SizedBox(
//             width: double.infinity,
//             child: Center(
//               child: RatingBar(
//                 filledIcon: CupertinoIcons.heart_fill,
//                 emptyIcon: CupertinoIcons.heart,
//                 alignment: Alignment.center,
//                 //isHalfAllowed: true,
//                 initialRating: rating,
//                 maxRating: 5,
//                 filledColor: Colors.black87,
//                 emptyColor: Colors.black12,
//                 onRatingChanged: (value) {
//                   rating = value;
//                 },
//               ),
//             ),
//           ),
//           sizedBox,
//           TextField(
//             decoration: InputDecoration(
//               label: const Text(
//                 'wirte your review here',
//                 style: TextStyle(color: Colors.black87),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius:
//                     BorderRadius.circular(10.0), // Set the border radius here
//                 borderSide: const BorderSide(
//                     color: Colors.black87,
//                     width: 2.0), // Set the border color and width here
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(
//                     10.0), // Set the border radius for the focused state
//                 borderSide: const BorderSide(
//                     color: Colors.black87,
//                     width:
//                         2.0), // Set the border color and width for the focused state
//               ),
//               focusColor: Colors.black87,
//             ),
//             controller: textEditController,
//             maxLines: 5,
//           ),

//           sizedBox,
//           RoundedLoadingButton(
//               controller: btnController,
//               color: Colors.black87,
//               successColor: Colors.green,
//               onPressed: () async {
//                 if (key.currentState!.validate()) {
//                   DateTime now = DateTime.now();
//                   await addReview(
//                     UserRatingModel(
//                       productId: productId,
//                       user: user,
//                       reviewText: textEditController.text,
//                       rating: rating,
//                       timestamp: now.millisecondsSinceEpoch.toString(),
//                     ),
//                   );
//                 }

//                 btnController.success();
//                 await Future.delayed(const Duration(seconds: 3));

//                 Get.back();
//               },
//               child: const Text('submet'))
//           // Add more widgets as needed
//         ],
//       ),
//     ),
//   );
// }

// final ratingModel = RatingModel(
//   id: 1,
//   title: null,
//   subtitle: 'Classifique nosso app:',
//   ratingConfig: RatingConfigModel(
//     id: 1,
//     ratingSurvey1: 'Em que podemos melhorar?',
//     ratingSurvey2: 'Em que podemos melhorar?',
//     ratingSurvey3: 'Em que podemos melhorar?',
//     ratingSurvey4: 'Em que podemos melhorar?',
//     ratingSurvey5: 'O que você mais gostou?',
//     items: [
//       RatingCriterionModel(id: 1, name: 'Qualidade do atendimento'),
//       RatingCriterionModel(id: 2, name: 'Competência dos atendentes'),
//       RatingCriterionModel(id: 3, name: 'Limpeza do ambiente'),
//       RatingCriterionModel(id: 4, name: 'Tempo de espera'),
//     ],
//   ),
// );
