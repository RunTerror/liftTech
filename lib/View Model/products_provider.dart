import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tech/api/model/product_model.dart';
import 'package:tech/api/products_repositry.dart';


enum Filters {title, name, price}

class ProductProvider extends ChangeNotifier {
  final ProductRepositry productRepositry = ProductRepositry();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  toogleloading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  List<ProductModel> _productmodel = [];
  List<ProductModel> get productmodel => _productmodel;

  // Status _loadmorestatus = Status.stable;
  // getLoadmoreStatus() => _loadmorestatus;

  // setLoadingstatus(Status status) {
  //   _loadmorestatus=status;
  //   notifyListeners();
  // }

  String filter = '';

  String _selectedfilter='';
  String get selectedfilter=> _selectedfilter;

  void updatefilter(String value){
    _selectedfilter=value;
    notifyListeners();
  }

  bool error=false;
  

  void fetchproducts(int offset) async {
    toogleloading();
    List<ProductModel>? products = await productRepositry.fetchpost(offset);
    if (products != null) {
      _productmodel.addAll(products);
      _filtered.addAll(products);
      log('${products.length}');
      notifyListeners();
    }
    else {
      error=true;
    }
    toogleloading();
  }

  List<ProductModel> _filtered = [];
  List<ProductModel> get filtered => _filtered;

  updateData() {
    _filtered.clear();
    if (filter == '') {
      _filtered.addAll(_productmodel);
    } else {
      if(_selectedfilter=='Title'){
        _filtered.addAll(_productmodel.where((product) => product.title.toString().toLowerCase().startsWith(filter.toLowerCase())));
      }
      else if(_selectedfilter=='Name'){
        _filtered.addAll(_productmodel.where((product) => product.category!.name.toString().toLowerCase().startsWith(filter.toLowerCase())));
      }
      else if(_selectedfilter=='Price'){
        _filtered.addAll(_productmodel.where((product) => product.price.toString().toLowerCase().startsWith(filter.toLowerCase())));
      }
    }
    notifyListeners();
  }

  void filterProduct(String starts) {
    filter = starts;
    updateData();
  }
}
