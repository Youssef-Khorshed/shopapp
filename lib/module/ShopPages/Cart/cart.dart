import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homecubit.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homestatus.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        builder: (context, state) {
          ShopHomeCubit cubit = ShopHomeCubit.get(context);
          return BuildCondition(
            condition: state is! ShopHomeLoadingGetCartDataState ,
            fallback:(context)=>Center(child: CircularProgressIndicator()) ,
            builder:(context)=> Scaffold(
              appBar: AppBar(
                title: Text('Cart'),
              ),
              body: item(cubit: cubit),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget griditems({required int index,required ShopHomeCubit cubit}) {

  return   Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomLeft,
              children: [
               Image(height: 200,
                  image: NetworkImage(cubit.cart_get.data.cartItems[index].product.image),
                ),
                 if(cubit.cart_get.data.cartItems[index].product.discount!=0)
                Text('Discount${cubit.cart_get.data.cartItems[index].product.discount} %',style: TextStyle(backgroundColor: Colors.red,color:Colors.white),),

              ],
            ),
            Text('${cubit.cart_get.data.cartItems[index].product.name}',overflow: TextOverflow.ellipsis,maxLines: 3,),
            Row(
              children: [
                Text('${cubit.cart_get.data.cartItems[index].product.price}'),
                SizedBox(width: 5,),
                if(cubit.cart_get.data.cartItems[index].product.discount !=0)
                Text(
                  '${cubit.cart_get.data.cartItems[index].product.oldPrice}',
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
            SizedBox(height: 10,)
            ,Row(
              children: [
                Expanded(child: Text('Quantity: ${cubit.cart_get.data.cartItems[index].quantity}',overflow: TextOverflow.ellipsis,maxLines: 2,)),
              ],
            ),
            IconButton(onPressed: (){
              cubit.addtocart( id: cubit.cart_get.data.cartItems[index].product.id,qunatity: 0);
            }, icon: Icon(Icons.delete))
          ],
        ),
     );
  }
  Widget item({required ShopHomeCubit cubit}){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 20,
                ),

                itemBuilder:(context,inde)=> griditems(index:inde,cubit: cubit),
              itemCount: cubit.cart_get.data.cartItems.length,
              ),

            ),
           Row(
           children: [
           Expanded(child: Text('Total Price : ${cubit.cart_get.data.total}',maxLines:1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20),))
  ,        TextButton(onPressed: (){}
  ,child:Text('Buy Now',style: TextStyle(fontSize: 20),),)
    ],
           )
          ],
        ),
      ),
    );
  }
}
