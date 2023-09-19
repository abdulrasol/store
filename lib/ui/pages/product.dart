import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/models/item_card.dart';
import 'package:store/database/models/prodect_model.dart';
import 'package:store/database/services/items.dart';
import 'package:store/ui/widgets/rating_bottm.dart';
import 'package:store/ui/widgets/small_widget.dart';
import '../../database/services/controller.dart';
import '../widgets/generic_app_bar.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProductPage extends StatelessWidget {
  final ProdectModel product;
  final btnController = RoundedLoadingButtonController();

  ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double quantity = product.increaseAmount;
    const sizedBox = SizedBox(height: 10);
    final controller = Get.put(Controller());
    void updateQuantityValueFromClass(double newQuantity) {
      quantity = newQuantity;
    }

    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    productImage(context),
                    productDetails(context, sizedBox),
                    sectionTitle('Order Quantities'),
                    UpdateCount(
                      product: product,
                      quantity: quantity,
                      updateOrginalValue: updateQuantityValueFromClass,
                    ),
                    sizedBox,
                    // users reviews sections
                    sectionTitle('Users Reviews'),
                    const Column(
                      children: [
                        //ReviewCard(review: review),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  child: Icon(
                                    CupertinoIcons.person,
                                    size: 50,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('User Name'),
                                          Expanded(child: sizedBox),
                                          RatingBar.readOnly(
                                            filledIcon:
                                                CupertinoIcons.heart_fill,
                                            emptyIcon: CupertinoIcons.heart,
                                            size: 28,
                                            initialRating: 3.5,
                                            maxRating: 5,
                                            filledColor: Colors.black87,
                                            emptyColor: Colors.black12,
                                          ),
                                        ],
                                      ),
                                      sizedBox,
                                      Text(
                                          'Commodi quam quo nulla id veritatis non. Totam unde qui molestias consequatur hic repellendus odio. Tenetur aliquid officiis consectetur. Reiciendis porro aut. Libero qui incidunt nemo at corporis et. Dolorem dolores facere optio non optio modi.'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
            // add to cart button
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // add to cart button
                    RoundedLoadingButton(
                        controller: btnController,
                        color: Colors.black87,
                        onPressed: () async {
                          // to check if user was loging in before or not!
                          if (controller.user.value == null) {
                            logingCheckingSnakBar;
                            btnController.reset();
                          } else {
                            var adding = await addCartToCart(CartItemModel(
                                item: product, quantity: quantity, id: ''));
                            if (adding == null) {
                              btnController.success();
                            } else {
                              btnController.error();
                            }
                          }
                        },
                        child: const Text('add to cart'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column productDetails(BuildContext context, SizedBox sizedBox) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'product code: BUK1231',
          //style: const TextStyle(),
        ),
        const SizedBox(height: 10),
        // read only rating bar
        starsRatingAndAddReview(context), // add reviews and stars
        sizedBox,
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${product.price} \$ ',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'per ${product.sellUnit}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]!,
                ),
              )
            ],
          ),
        ),
        //sizedBox,
        sectionTitle('Product descrption'),
        Text(
          product.description,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Row starsRatingAndAddReview(BuildContext context) {
    return Row(
      children: [
        const RatingBar.readOnly(
          filledIcon: CupertinoIcons.heart_fill,
          emptyIcon: CupertinoIcons.heart,
          size: 28,
          initialRating: 3.5,
          maxRating: 5,
          filledColor: Colors.black87,
          emptyColor: Colors.black12,
        ),
        const Expanded(child: SizedBox()),
        TextButton(
          onPressed: () {
            if (controller.user.value != null) {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => BottomSheet(
                      onClosing: () {},
                      builder: (context) {
                        return ratingBottomSheet(product.name, product.id, {
                          'user_id': controller.user.value!.uid,
                          'user_name': controller.user.value!.displayName,
                        });
                      }));
            } else {
              showloginRequiredAlert();
            }
          },
          child: const Text(
            'Add your review',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        )
      ],
    );
  }

  SizedBox productImage(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Image.memory(
            base64.decode(product.image)) //Image.network(item.image),
        );
  }

  AppBar appBar(BuildContext context) {
    return genericAppBar(
      title: product.name,
      withBackAction: true,
      showSearchIcon: false,
      centerTitle: true,
      context: context,
    );
  }

  Padding sectionTitle(String sectionTitlle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Row(
        children: [
          Text(sectionTitlle),
          const SizedBox(width: 10),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class UpdateCount extends StatefulWidget {
  UpdateCount(
      {Key? key,
      required this.product,
      required this.quantity,
      required this.updateOrginalValue})
      : super(key: key);
  final ProdectModel product;
  final Function updateOrginalValue;
  double quantity;

  @override
  // ignore: library_private_types_in_public_api
  _UpdateCountState createState() => _UpdateCountState();
}

class _UpdateCountState extends State<UpdateCount> {
  double? price;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget.quantity =
                      widget.quantity + widget.product.increaseAmount;
                  widget.updateOrginalValue(widget.quantity);
                });
              },
              icon: const Icon(CupertinoIcons.plus_circle),
            ),
            Text(
              '${widget.quantity.toStringAsFixed(2)} kg',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(
                  () {
                    if (widget.quantity > widget.product.increaseAmount) {
                      widget.quantity =
                          widget.quantity - widget.product.increaseAmount;
                      widget.updateOrginalValue(widget.quantity);
                    }
                  },
                );
              },
              icon: const Icon(CupertinoIcons.minus_circle),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text(
              'Total Price ',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Expanded(child: sizedBox),
            Text(
              '${(widget.product.price * widget.quantity).toStringAsFixed(2)}\$',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    );
  }
}
