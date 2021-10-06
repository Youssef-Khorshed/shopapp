import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homecubit.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homestatus.dart';
import 'package:shopapp/model/ShopHomePage/shophomepage.dart';
import 'package:shopapp/module/ShopPages/Cart/cart.dart';
import 'package:shopapp/shared/component/component.dart';

class CategoriesPage extends StatelessWidget {
  int ind = 0;
  List<Products>list= [];
  CategoriesPage({required int this.ind});
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        builder: (context, state) {
          ShopHomeCubit cubit = ShopHomeCubit.get(context);
          ShopHomePage shopHomePage =cubit.shopHome;
          list = cubit.products_elec;
          if(ind ==43){list = cubit.products_corona;}
          else if(ind ==42){list = cubit.products_sport;}
          else if(ind ==40){list = cubit.products_lights;}

          return BuildCondition(
            condition: state is! ShopHomeLoadingGetCartDataState ,
            fallback:(context)=>Center(child: CircularProgressIndicator()) ,
            builder:(context)=> Scaffold(
              appBar: AppBar(
                title: Text('Categories'),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          IconButton(iconSize: 35,onPressed: (){
                            nav(context: context, Widget: Cart());
                            cubit.cart_get_data();
                          }, icon: Icon(Icons.shopping_cart_outlined)),
                          if(cubit.cart_item!=0)
                            CircleAvatar(backgroundColor: Colors.red,radius: 10,child: Text('${cubit.cart_item}'),)
                        ],
                      ),
                    )
                  ]
              ),
              body:list.length!=0? item(cubit: cubit) : Center(child: Image(image: NetworkImage('https://cdn.dribbble.com/users/1231865/screenshots/11157048/media/bc9427646c632ded563ee076fdc5dfda.jpg'),),),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget griditems({required int index,required ShopHomeCubit shopHomeCubit,required ShopHomePage shopHomePage}) {

    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal:  10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.bottomLeft,
            children: [
              Image(height: 300,
                image: NetworkImage(list[index].image),
              ),
              if(list[index].discount!=0)
                Text('Discount${list[index].discount} %',style: TextStyle(backgroundColor: Colors.red,color:Colors.white),),

            ],
          ),
          Text('${list[index].name}',overflow: TextOverflow.ellipsis,maxLines: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('${list[index].price}'),
              SizedBox(width: 10,),
              if(list[index].discount !=0)
                Text(
                  '${list[index].oldprice}',
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
            ],
          ),


        ],
      ),
    );
  }
  Widget item({required ShopHomeCubit cubit}){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1/ 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),

              itemBuilder:(context,inde)=> griditems(shopHomePage:cubit.shopHome ,index:inde,shopHomeCubit: cubit),
              itemCount: list.length,
            ),

          ),
        ],
      ),
    );
  }
}
