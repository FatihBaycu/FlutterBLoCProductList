import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/screens/cart_list_screen.dart';
import 'package:flutter_bloc_pattern/screens/product_grid_screen.dart';
import 'package:flutter_bloc_pattern/screens/product_list_screen.dart';

void main()=>runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{
        "/":(context)=>ProductListScreen(),
        "cart-list":(context)=>CartListScreen(),
        "product-add":(context)=>ProductGridScreen(),
      } ,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "product-add",

    );
  }
}
