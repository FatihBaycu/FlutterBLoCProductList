import 'dart:convert';
import 'dart:core';
import 'package:flutter_bloc_pattern/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc_pattern/models/product.dart';

class ProductService{
   static List<Product> products=<Product>[];
   static List<ProductModel> productsModel=<ProductModel>[];

   static ProductService _singleton=ProductService._internal();

   factory ProductService(){return _singleton;}

   ProductService._internal();

   static List<Product> getAll(){
     products.add(new Product(1, "Bilgisayar", 20));
     products.add(new Product(2, "Klavye", 30));
     products.add(new Product(3, "Mouse", 40));
     products.add(new Product(4, "Kitap", 2));
     return products;
   } 
   
   static Future<List<ProductModel>> getAllFromApi() async{
        
    var response=await http.get(Uri.parse("https://fakestoreapi.com/products"));
      var result=(json.decode(response.body)as List).map((e) => ProductModel.fromJson(e)).toList();

    productsModel=result;
     return productsModel;
   }

   static void addProduct(Product product){
     products.add(product);
   }

   static void removeProduct(Product product){
     products.remove(product);
   }

}