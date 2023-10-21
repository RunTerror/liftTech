import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:
               ClipRRect(
                  borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child:  FractionallySizedBox(
                // heightFactor: 0.99,
                widthFactor: 1,
                child:CachedNetworkImage(
                    fadeInCurve: Curves.bounceIn,
                    placeholder: (context, url) {
                      return Shimmer.fromColors(baseColor: Colors.black, highlightColor: Colors.grey, child: Container());
                    },
                    filterQuality: FilterQuality.low,
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
                ),),
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


   Widget shimmer(var w, var h) {
    return SizedBox(
      width: w / 2.2,
      height: h / 3,
      child: Shimmer.fromColors(
          baseColor:const Color.fromARGB(255, 58, 56, 56).withOpacity(0.25),
          highlightColor: Colors.white.withOpacity(0.25),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            height: h / 2,
            width: w / 2.2,
          )),
    );
  }