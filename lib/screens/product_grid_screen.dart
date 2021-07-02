import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/blocs/cart_bloc.dart';
import 'package:flutter_bloc_pattern/blocs/product_bloc.dart';
import 'package:flutter_bloc_pattern/models/cart.dart';
import 'package:flutter_bloc_pattern/models/product_model.dart';

class ProductGridScreen extends StatelessWidget{

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products API"),
      actions: [
        IconButton(onPressed: ()=>Navigator.pushNamed(context, "cart-list"), icon: Icon(Icons.add_shopping_cart))
      ],),
      body:buildProductListGridView(),
    );
  }

    buildProductListGridView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: productBloc.getStream,
        initialData: productBloc.getAllFromApi(),
        builder: (context,AsyncSnapshot snapshot){
            return FutureBuilder<List<ProductModel>>(
              future: productBloc.getAllFromApi(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2/5,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context,int index){
                        var product=snapshot.data![index];
                        return SizedBox(
                          child: Card(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                    SizedBox(height: 250,child: Image.network(product.image,fit: BoxFit.contain,)),
                                  Text(product.category,style: TextStyle(fontStyle: FontStyle.italic),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(product.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                     child: Text("${product.price}  TL ", textAlign: TextAlign.center),
                                      decoration: BoxDecoration(
                                      border: Border.all(width: 2.0, color: Colors.orange.shade900),
                                      ),
                                    ),
                                      //Text(product.price.toString()),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),onPressed: (){cartBloc.addToCart(Cart(product,1));},child: Icon(Icons.add_shopping_cart,color: Colors.black,),),
                                      ElevatedButton(style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),onPressed: (){showMyDialog(context,product);},child: Text("Details"),),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  );

                }
                else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            );
        },
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context,ProductModel productModel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(productModel.title),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Image.network(productModel.image),
                Container(
                  color: Colors.orange,
                    child: Padding(padding:  EdgeInsets.all(8.0),
                      child: IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.white,size: 50,),
                          onPressed: (){
                        cartBloc.addToCart(Cart(productModel,1));
                        Navigator.pop(context);}
                      ),
                )),
                SizedBox(height: 30),
                Container(decoration: BoxDecoration(
                     border:Border.all(width: 2.0, color: Colors.blue.shade900), ),
                    child: Padding(padding:  EdgeInsets.all(8.0),
                      child: Text(productModel.price.toString()+" TL",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize:30,),),
                )),
                SizedBox(height: 30,),
                Container(
                    child: Padding(padding:  EdgeInsets.all(8.0),
                      child: Text(productModel.category,textAlign: TextAlign.center,style: TextStyle(fontSize:30,),),
                )),
                SizedBox(height: 30,),

                Container(decoration: BoxDecoration(border:Border.all(width: 2.0, color: Colors.orange.shade900),),
                    child: Padding(padding:  EdgeInsets.all(8.0),
                      child: Text("Description:\n"+productModel.description,style: TextStyle(fontSize:20),),
                )),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}



// buildProductList() {
//   return StreamBuilder(
//     stream: productBloc.getStream,
//     initialData: productBloc.getAllFromApi(),
//     builder: (context,AsyncSnapshot snapshot){
//         return FutureBuilder<List<ProductModel>>(
//           future: productBloc.getAllFromApi(),
//           builder: (context,snapshot){
//             if(snapshot.hasData){
//               return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (BuildContext context,int index){
//                     var product=snapshot.data![index];
//                     return ListTile(
//                       leading: CircleAvatar(child: Text(product.id.toString()),),
//                       title: Text(product.title),
//                       subtitle: Text(product.price.toString()),
//                       trailing: IconButton(
//                           onPressed: (){
//                             cartBloc.addToCart(Cart(product,1));
//                           },
//                           icon:Icon(Icons.add_shopping_cart)
//                       ),
//
//                     );
//                   }
//               );
//
//             }
//             else{
//               return Center(child: CircularProgressIndicator(),);
//             }
//           },
//         );
//     },
//   );
// }
