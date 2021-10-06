import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homecubit.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homestatus.dart';
import 'package:shopapp/model/ShopHomePage/shophomepage.dart';
import 'package:shopapp/module/ShopPages/Cart/cart.dart';
import 'package:shopapp/shared/component/component.dart';

class ProductScreen extends StatelessWidget {
   int index= 0;
  ProductScreen({required this.index});
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(builder: (context,state){
      ShopHomeCubit shopHomeCubit =ShopHomeCubit.get(context);
      ShopHomePage shopHomePage = shopHomeCubit.shopHome;
      return Scaffold(
      appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(iconSize: 35,onPressed: (){
                    nav(context: context, Widget: Cart());
                    shopHomeCubit.cart_get_data();
                  }, icon: Icon(Icons.shopping_cart_outlined)),
                  if(shopHomeCubit.cart_item!=0)
                    CircleAvatar(backgroundColor: Colors.red,radius: 10,child: Text('${shopHomeCubit.cart_item}'),)
                ],
              ),
            )
          ]
      ),
      body: getproductitems(shopHomeCubit: shopHomeCubit,shopHomePage: shopHomePage),
    );}, listener: (context,state){});
  }

   Widget getproductitems({ required ShopHomeCubit shopHomeCubit,required ShopHomePage shopHomePage})
   {

     return  Padding(
       padding: const EdgeInsets.all(30.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children:
         [
           Stack(
             alignment: Alignment.bottomLeft,
             children: [
               Image(height: 200,image:
               NetworkImage(shopHomePage.data.products[index].image),width: double.infinity,fit: BoxFit.fill,),
               if( shopHomePage.data.products[index].discount.round() != 0)
                 Text('Discount ${shopHomePage.data.products[index].discount.round()}%'
                   ,overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: Colors.grey[300],backgroundColor:Colors.red),),
             ],
           )
           ,Text('${shopHomePage.data.products[index].name}',overflow: TextOverflow.ellipsis,maxLines: 2,),
           Text('${shopHomePage.data.products[index].description}',overflow: TextOverflow.ellipsis,maxLines: 2,)

           ,Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Text('${shopHomePage.data.products[index].price.round()}',overflow: TextOverflow.ellipsis,maxLines: 2,),
               SizedBox(width: 5,),
               if(shopHomePage.data.products[index].discount.round() != 0)
                 Text('${shopHomePage.data.products[index].oldprice.round()}',overflow: TextOverflow.ellipsis,maxLines: 4,
                   style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),),
               Spacer(),
               IconButton(onPressed: (){shopHomeCubit.post_favourite_state(shopHomePage.data.products[index].id);},icon: Icon(shopHomeCubit.favourites[shopHomePage.data.products[index].id]! ? Icons.favorite: Icons.favorite_outline  ),)


             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               SizedBox(width: 5,)
               ,Container(color: Color(0xFFFAFAFA),child: TextButton(onPressed: (){
                 shopHomeCubit.pluscounter(shopHomePage.data.products[index].id);
                 // toast(message: '${shopHomeCubit.addcart[shopHomePage.data.products[index].id]}', toaststate: Toaststate.success);
               },child: Icon(Icons.add),))
               ,SizedBox(width: 5,)
               , Text('${shopHomeCubit.addcart[shopHomePage.data.products[index].id]}',overflow: TextOverflow.ellipsis,maxLines: 2,)
               , Container(
                 color: Color(0xFFFAFAFA),
                 child: TextButton(onPressed: (){
                   shopHomeCubit.addcart[shopHomePage.data.products[index].id]!=0 ?  shopHomeCubit.mincounter(shopHomePage.data.products[index].id): shopHomeCubit.addcart[shopHomePage.data.products[index].id];
                   //   toast(message: '${shopHomeCubit.addcart[shopHomePage.data.products[index].id]}', toaststate: Toaststate.success);
                 },child: Icon(Icons.remove),),
               )
               ,Spacer()
             ,               IconButton(onPressed: (){
                 bool check = false;
                 shopHomeCubit.cart_get.data.cartItems.forEach((item) { if(item.product.id == shopHomePage.data.products[index].id){
                   check = true;
                   shopHomeCubit.update(id: item.id , quantity: shopHomeCubit.addcart[item.product.id]!);
                 }});

                 !check? shopHomeCubit.addtocart(id:  shopHomePage.data.products[index].id,qunatity:shopHomeCubit.counter ):null;
               },icon: Icon(Icons.add_shopping_cart_outlined),)
             ],
           ),


         ],),
     );

   }
}
