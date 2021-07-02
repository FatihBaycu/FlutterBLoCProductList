import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/blocs/cart_bloc.dart';
import 'package:flutter_bloc_pattern/models/cart.dart';

class CartListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Cart"),),
      body: StreamBuilder(
        stream: cartBloc.getStream,
        initialData: cartBloc.getAll(),
        builder: (context,AsyncSnapshot snapshot){
          return buildCartItems(snapshot);
        },

      ),
    );
  }

buildCartItems(AsyncSnapshot snapshot){
    var carts=snapshot.data;
    return ListView.builder(
        itemCount: carts.length,
        itemBuilder: (context,index){
          var cart=carts[index];
          return ListTile(
            leading: CircleAvatar(child: Text(index.toString())),
            title: Text(cart.productModel.title),
            subtitle: Text(cart.quantity.toString()+" piece"),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart,color: Colors.red,),
              onPressed: (){
                cartBloc.removeToCart(cart);
              },
            ),
          );
        });
}



}