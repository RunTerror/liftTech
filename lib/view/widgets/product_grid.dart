import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech/api/model/product_model.dart';
import 'package:tech/view/screens/product_detail.dart';

Widget productgrid(ProductModel productModel, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetailedScreen(productModel: productModel);
          },
        ));
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) {
                  return const Center(
                      child: SizedBox(
                          height: 180,
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                          )));
                },
                imageUrl: productModel.images!.first,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                productModel.title!,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                productModel.description!,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                maxLines: 2,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '\$${productModel.price}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }