import 'dart:async';

import 'package:flutter_bloc_pattern/blocs/cart_bloc.dart';
import 'package:flutter_bloc_pattern/data/product_service.dart';
import 'package:flutter_bloc_pattern/models/product.dart';
import 'package:flutter_bloc_pattern/models/product_model.dart';


class ProductBloc{

  final productStreamController=StreamController.broadcast();

  Stream get getStream=>productStreamController.stream;

  void addProduct(Product product){
    ProductService.addProduct(product);
    productStreamController.sink.add(ProductService.getAll());
    productStreamController.sink.add(CartBloc().getAll());
  }

  void removeProduct(Product product){
    ProductService.removeProduct(product);
    productStreamController.sink.add(ProductService.getAll());
    productStreamController.sink.add(CartBloc().getAll());
  }

  List<Product> getAll(){
    return ProductService.getAll();

  }

  Future<List<ProductModel>> getAllFromApi(){
    return ProductService.getAllFromApi();
  }
}

final productBloc=ProductBloc();