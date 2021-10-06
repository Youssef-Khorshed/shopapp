import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homecubit.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homestatus.dart';
import 'package:shopapp/module/ShopPages/Cart/cart.dart';
import 'package:shopapp/shared/component/component.dart';

class Shop extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>
      (builder: (context,state)
    {
      ShopHomeCubit shopcubit = ShopHomeCubit.get(context);


      return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(iconSize: 35,onPressed: (){
                  nav(context: context, Widget: Cart());
                  shopcubit.cart_get_data();
                }, icon: Icon(Icons.shopping_cart_outlined)),
                if(shopcubit.cart_item!=0)
                CircleAvatar(backgroundColor: Colors.red,radius: 10,child: Text('${shopcubit.cart_item}'),)
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: shopcubit.index ,
        type: BottomNavigationBarType.fixed,
        items: shopcubit.items,
        onTap: (value){shopcubit.navigate(value);},
      ),

      body: shopcubit.pages[shopcubit.index],
    );

      },  listener: (context,state){});


  }
}
