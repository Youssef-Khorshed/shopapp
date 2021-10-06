
import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homecubit.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homestatus.dart';
import 'package:shopapp/model/ShopCategories/shopcategories.dart';
import 'package:shopapp/model/ShopHomePage/shophomepage.dart';
import 'package:shopapp/module/ShopPages/Category_page/categories.dart';
import 'package:shopapp/module/product_screen/product.dart';
import 'package:shopapp/shared/component/component.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Shop_homePage extends StatelessWidget {
  const Shop_homePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
        builder: (context,status){
          ShopHomeCubit shopHomeCubit = ShopHomeCubit.get(context);
         // ShopHomePage? shopHomePage = ShopHomeCubit.get(context).shopHome;
       //   Categories? categories = ShopHomeCubit.get(context).categories;

          return BuildCondition(
            condition:status is! ShopHomeLoadingState   ,
            fallback:(context)=> Center(child: CircularProgressIndicator()),
            builder:(context)=>item(shopHomeCubit: shopHomeCubit,context: context,shopHomePage: shopHomeCubit.shopHome,categoreis: shopHomeCubit.categories) ,
          );
        },
        listener: (context,status){
          ShopHomeCubit shopHomeCubit =ShopHomeCubit.get(context);
              if(status is ShopHomeErrorFavouriteState)
                {
                  toast(message: status.shopFavourite.message, toaststate: Toaststate.error);
                }
             else if(status is ShopHomeLoadingAddRemoveCartDataState)
              {
                toast(message: 'جاري التعديل', toaststate: Toaststate.warrning);
              }
            else  if(status is ShopHomeSucessAddRemoveCartDataState)
              {
                toast(message: '${shopHomeCubit.addRemove.message}', toaststate: Toaststate.success);
              }
              else  if(status is ShopHomeupdateCartState)
              {
                toast(message: '${status.message}', toaststate: Toaststate.success);
              }
              else  if(status is ShopHomeupdateErrorCartState)
              {
                toast(message: '${status.error}', toaststate: Toaststate.warrning);
              }
            else  if(status is ShopHomeErrorAddRemoveCartDataState)
              {
                toast(message: status.error, toaststate: Toaststate.error);
              }
             else if(status is ShopHomeSucessFavouriteState)
              {
                toast(message: status.shopFavourite.message, toaststate: Toaststate.success);
              }
              else if(status is ShopHomeInitialSucessFavouriteState)
              {
                toast(message: 'جاري التعديل' , toaststate: Toaststate.warrning);
              }

        });
  }
  List<Widget> getbanneritems({required ShopHomePage shopHomePage})
   {
  List<Widget> items= [];
  shopHomePage.data.banner.forEach((element) {
    items.add(Image(image:
    NetworkImage(element.image),width: double.infinity,fit: BoxFit.cover,));
  });
  return items;
}
  Widget getproductitems({ required context,required int counter,required int index,required ShopHomeCubit shopHomeCubit,required ShopHomePage shopHomePage})
   {

        return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
          [
            GestureDetector(
              onTap: (){
                nav(context: context,Widget:ProductScreen(index: index,) );
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(height: 200,image:
                  NetworkImage(shopHomePage.data.products[index].image),width: double.infinity,fit: BoxFit.fill,),
                  if( shopHomePage.data.products[index].discount.round() != 0)
                  Text('Discount ${shopHomePage.data.products[index].discount.round()}%'
                    ,overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: Colors.grey[300],backgroundColor:Colors.red),),
                ],
              ),
            )
          ,Text('${shopHomePage.data.products[index].name}',overflow: TextOverflow.ellipsis,maxLines: 2,),
         Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Text('${shopHomePage.data.products[index].price.round()}',overflow: TextOverflow.ellipsis,maxLines: 2,),
    SizedBox(width: 5,),
    if(shopHomePage.data.products[index].discount.round() != 0)
    Text('${shopHomePage.data.products[index].oldprice.round()}',overflow: TextOverflow.ellipsis,maxLines: 2,
      style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),),
    Spacer(),
    IconButton(onPressed: (){shopHomeCubit.post_favourite_state(shopHomePage.data.products[index].id);},icon: Icon(shopHomeCubit.favourites[shopHomePage.data.products[index].id]! ? Icons.favorite: Icons.favorite_outline  ),)


  ],
),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               IconButton(onPressed: (){
                 bool check = false;
                 shopHomeCubit.cart_get.data.cartItems.forEach((item) { if(item.product.id == shopHomePage.data.products[index].id){
                   check = true;
                   shopHomeCubit.update(id: item.id , quantity: shopHomeCubit.addcart[item.product.id]!);
                 }});

                 !check? shopHomeCubit.addtocart(id:  shopHomePage.data.products[index].id,qunatity:shopHomeCubit.counter ):null;
               },icon: Icon(Icons.add_shopping_cart_outlined),)

              ],
            )


      ],);

  }
  Widget category({required context,required Categories categoreis,required int index})=>FilterChip(onSelected: (value){
    nav(context: context,Widget: CategoriesPage(ind: categoreis.data.catData[index].id));
  },label:
  Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Text(categoreis.data.catData[index].name)
      ,SizedBox(width: 10,)
      ,CircleAvatar(backgroundColor: Colors.grey[300],radius: 20,backgroundImage: NetworkImage(categoreis.data.catData[index].img))
  ],)
  ,backgroundColor: Color(0xFFFDE8CC),
  );
  Widget item({required ShopHomeCubit shopHomeCubit,required  context,required ShopHomePage shopHomePage,required Categories categoreis})
  {
    return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(items: getbanneritems(shopHomePage: shopHomePage),
            options: CarouselOptions(
               height: 200,
              autoPlay: true,
              reverse: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayInterval: Duration(seconds: 2),
              viewportFraction: 1,
              scrollDirection: Axis.horizontal,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
              onPageChanged: (index,reason){
                shopHomeCubit.changesmooth(index);
              }

        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
children: [
  AnimatedSmoothIndicator(activeIndex: shopHomeCubit.pageitem,effect: WormEffect
    (
    radius:15 ,
      dotHeight: 15,
      dotWidth: 15,
      dotColor: Colors.grey.withOpacity(0.5),
      activeDotColor: Color(0xFFFDE8CC)

  ), count: shopHomePage.data.banner.length),

],        )
        ,SizedBox(height: 20,),

    Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Container(
                height: 100,
                child: ListView.separated( scrollDirection: Axis.horizontal,itemBuilder: (context,index)=>category(context: context,categoreis: categoreis, index: index)
                    , separatorBuilder: (context,index)=>SizedBox(width: 5,), itemCount: categoreis.data.catData.length),
              ),
              Container(height: 300,width: double.infinity,child: Image(image: NetworkImage('https://thumbs.dreamstime.com/b/special-offers-unique-fashion-color-company-brand-175291771.jpg'),))
              ,Text('Most Popular',style:
              TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
              SizedBox(height: 20,),
              Container(
                color: Color(0xFFFFFFFF),
                child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   childAspectRatio: 1/3,
                   mainAxisSpacing: 10,
                   crossAxisSpacing: 10,
                 ),
                itemBuilder:(context,index)=>getproductitems(context: context,counter:shopHomeCubit.counter,index: index,shopHomeCubit:shopHomeCubit ,shopHomePage: shopHomePage) ,
                itemCount: shopHomePage.data.products.length,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );

  }

}
