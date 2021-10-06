import 'package:flutter/material.dart';
import 'package:shopapp/module/shop_login_sec/shop_login.dart';
import 'package:shopapp/shared/component/component.dart';
import 'package:shopapp/shared/network/local/preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Item{
   String photo,title,body;
   Item({required this.photo,required this.title,required this.body,});
}
class Page_V extends StatefulWidget {
  @override
  State<Page_V> createState() => _Page_VState();
}

class _Page_VState extends State<Page_V> {

List<Item>page_items = [
  Item(title: 'Welcome',body: 'We make it simple to order the item you choice',photo: 'assets/22.png'),
  Item(title: 'Choose your favourite item',body: 'When you order you can get many offers',photo: 'assets/24.png'),
  Item(title: 'Deliver at home',body: 'We prepare  your order fast and deliver it in time',photo: 'assets/23.png'),
];

PageController moveitems = PageController();

void screen_state()
{
  navi(context: context, Widget: Shop_login());
  Preference.put(key: 'LoginScreen', value: true);
}
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(
      actions: [
        TextButton(onPressed: (){
          setState(() {
         screen_state();
          });
        },child: Text('Skip',style: TextStyle(fontSize: 17),))
      ],
    ),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child:PageView.builder(itemBuilder: (context,index)=>items(page_items[index],index)
        ,itemCount: page_items.length,
          physics: BouncingScrollPhysics(),
         controller:moveitems ,
        ) ,
      ),
    );
  }

  Widget items(Item iteme , int index)=>Column(
  children: [
    Expanded(child: Image( fit: BoxFit.fill,image: AssetImage(iteme.photo))),
    Text(iteme.title,textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
    Text(iteme.body,style:TextStyle(fontSize: 15,color: Colors.grey[400]), ),
    Spacer(),
    Row(
      children: [
        SmoothPageIndicator(controller: moveitems, count: page_items.length
        ,effect: ExpandingDotsEffect(
            dotColor: Colors.grey,
            dotWidth: 15,
            expansionFactor: 5,
            dotHeight: 15,
            radius: 20,
            activeDotColor: Colors.blue,

          ),
        ),
        Spacer(),
        FloatingActionButton(onPressed: (){
          setState(() {
            if(page_items.length-1 == index){
            screen_state();
            }

          });
          moveitems.nextPage(duration: Duration(
           milliseconds: 200
          ), curve:Curves.bounceIn );
        }
          ,heroTag: 'homebtn'
          ,child: Icon(Icons.arrow_forward),)
      ],
    ),
    SizedBox(height: 10,)
  ],
);
}
