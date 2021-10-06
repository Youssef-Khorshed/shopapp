import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homecubit.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homestatus.dart';
import 'package:shopapp/model/ShopCategories/shopcategories.dart';
class Shop_categoryPage extends StatelessWidget {
  const Shop_categoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(builder: (context,state){
      Categories? categories = ShopHomeCubit.get(context).categories;
      return BuildCondition(
        builder: (context)=>Padding(
          padding: const EdgeInsets.all( 15),
          child: ListView.separated( physics: BouncingScrollPhysics(),itemBuilder: (context,index)=>category(categoreis: categories, index: index)
              , separatorBuilder: (context,index)=>SizedBox(height: 15,), itemCount: categories.data.catData.length),
        ),
        condition:categories != null ,
        fallback:(context)=> Center(child: CircularProgressIndicator()),
      );
    }, listener: (context,state){
    });
  }
  Widget category({required Categories categoreis,required int index})=>FilterChip(onSelected: (value){},label:
  Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
      CircleAvatar(backgroundColor: Colors.grey[100],radius: 30,backgroundImage: NetworkImage(categoreis.data.catData[index].img))
    ,SizedBox(width: 20,)
    ,Text(categoreis.data.catData[index].name)
    ,Spacer(),
    IconButton(onPressed: null, icon: Icon(Icons.arrow_forward))
    ],),backgroundColor: Colors.grey[100],);
}
