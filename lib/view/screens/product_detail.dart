import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech/api/model/product_model.dart';

class ProductDetailedScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailedScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 10,
          backgroundColor: const Color.fromARGB(255, 228, 223, 223),
          elevation: 0,
          title: const Text('Details'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(CupertinoIcons.back)),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: h,
              width: w,
            ),
            Positioned(
              top: 0, // Position the Swiper at the top
              left: 0,
              right: 0,
              child: Container(
                height: h / 2.3,
                width: w,
                color: const Color.fromARGB(255, 228, 223, 223),
              ),
            ),
            Positioned(
              top: 0,
              child: SizedBox(
                height: h / 2,
                width: w,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return CachedNetworkImage(
                      errorWidget: (context, url, error) {
                        return const Center(child: Icon(Icons.error, color: Colors.red,),);
                      },
                        imageUrl: productModel.images![index]);
                  },
                  itemCount: productModel.images!.length,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    // margin: EdgeInsets.only(right: 8.0, left: 8.0),
                    builder: DotSwiperPaginationBuilder(),
                  ),
                  control: const SwiperControl(),
                ),
              ),
            ),
            Positioned(
              top: h / 2 + 20,
              left: (w - w / 1.1) / 2,
              child: Container(
                width: w / 1.1,
                child: Column(
                  children: [
                    SizedBox(
                      width: w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${productModel.title}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // Spacer(),
                          Text(
                            '\$ ${productModel.price}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '${productModel.description}',
                      // maxLines: 10,
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
             Positioned(
              bottom: 10,
               child: Container(
                alignment: Alignment.center,
                        width: w / 1.1,
                        height: 50,
                        decoration:const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child:const Text('Buy now',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                      ),
             )
          ],
        ));
  }
}
