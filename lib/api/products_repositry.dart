import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tech/api/api.dart';
import 'package:tech/api/model/product_model.dart';

class ProductRepositry {

  final _api = Api();
  Future<List<ProductModel>?> fetchpost(int offset) async {
    try {
      final response = await _api.sendrequest.get(
        "/products?offset=$offset&limit=15",
      );
      List<dynamic> products = response.data;
      final productsmodel = products.map((product) => ProductModel.fromJson(product)).toList();
      return productsmodel;
    } on DioException catch (e) {
      log(e.message!);
    }
    return null;
  }
}
