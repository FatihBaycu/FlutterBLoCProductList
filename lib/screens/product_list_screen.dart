import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/blocs/cart_bloc.dart';
import 'package:flutter_bloc_pattern/blocs/product_bloc.dart';
import 'package:flutter_bloc_pattern/models/cart.dart';

class ProductListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, "cart-list");}, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: buildProductList(),
    );
  }

  buildProductList() {
    return StreamBuilder(
      initialData: productBloc.getAll(),
      stream: productBloc.getStream,
      builder: (context,AsyncSnapshot snapshot){
        if (snapshot.data!.length>0) {
          return buildProductListItems(snapshot);
        } else {
          return Center(child: CircularProgressIndicator(),);
        }

      },
    );
  }

  buildProductListItems(AsyncSnapshot snapshot) {
    var products=snapshot.data;
    return ListView.builder(
        itemCount: products!.length,
        itemBuilder: (context,index){
          var product=products[index];
          return ListTile(
            leading: CircleAvatar(child: Text(product.id.toString()),),
            title: Text(product.title),
            subtitle: Text(product.price.toString()),
            trailing: IconButton(
                onPressed: (){
                  cartBloc.addToCart(Cart(product,1));
                },
                icon:Icon(Icons.add_shopping_cart)
            ),

          );
        }
    );
  }




}