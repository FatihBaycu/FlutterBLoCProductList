import 'package:flutter_bloc_pattern/models/product.dart';
import 'package:flutter_bloc_pattern/models/product_model.dart';

class Cart{
  late ProductModel productModel;
  late int quantity;
  //late Product product;

  Cart(this.productModel, this.quantity);
}