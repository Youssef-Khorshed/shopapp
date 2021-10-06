import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/shared/bloc_counter/cubit.dart';
import 'package:shopapp/shared/colors/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget DefaultButton(
{
  double width = double.infinity,
  Color text_color =  Colors.white,
  FontWeight text_font_weight = FontWeight.bold,
  required VoidCallback controll,
  required String text,
  double radius = 0.0}
    )=>  Container(
  width: width,
  decoration: BoxDecoration(color: shopbtncolor,borderRadius: BorderRadius.circular(radius)),
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: MaterialButton(
    onPressed: controll ,
      child: Text(
        '$text',
        style: TextStyle(
            color: text_color, fontWeight: text_font_weight),
      )),
);
//----------------------------------------------
Widget textformfield(  {
  required TextEditingController pass,
  required Icon prefix_icon ,
  IconData ? suffix_icon,
  required TextInputType keyboard_type,
  bool password = false,
  required String text,
   double radius = 0.0,
  FormFieldValidator<String>? validator,
  VoidCallback? suffix_hand,
  GestureTapCallback? ontap,
  Function(String)? onchange,
  Function(String)? onsubmit,
  bool? enabled


})=>                  TextFormField(
controller: pass,
validator: validator,
keyboardType: keyboard_type,
obscureText: password,
onTap: ontap,
onFieldSubmitted: onsubmit,
onChanged: onchange,
enabled: enabled ,
decoration: InputDecoration(
labelText: '$text',
border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(radius),
),
prefixIcon: prefix_icon,
suffixIcon: IconButton(onPressed: suffix_hand, icon: Icon(suffix_icon),),

),
);


//
Widget Check_tasks()=> Center(child: Container(
  child: Column(
    mainAxisSize:MainAxisSize.min ,
    children: [
      Icon(Icons.menu,size: 100,color: Colors.blueGrey,),
      Text('No Tasks',style: TextStyle(fontSize: 50,color: Colors.blueGrey),)
    ],
  ),
));


Widget news_item(context,business_list)=>Padding(
  padding: const EdgeInsets.all(20),
  child: InkWell(
    onTap: (){
     // nav(context: context, Widget: Web(u: business_list['url']));
    },
    child: Container(
      height: 150,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image(image:
NetworkImage(business_list['urlToImage'] != null ? business_list['urlToImage']  : 'https://cdn.cnn.com/cnnnext/dam/assets/210917234709-covid-hospital-florida-0825-super-tease.jpg')
                ,width: 150,height: 150,fit: BoxFit.fill,),
            ),
          ),
          SizedBox(width: 15,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(business_list['title'] != null ?business_list['title'] : 'no title' ,maxLines: 1
                  ,overflow: TextOverflow.ellipsis,
                   style:Theme.of(context).textTheme.bodyText2 ,
                ),
                SizedBox(height: 4,),
                Text(business_list['description'] !=null ? business_list['description']:'no description'
                  ,maxLines: 3,overflow: TextOverflow.ellipsis,
                  style:Theme.of(context).textTheme.bodyText1 ,
                ),
                SizedBox(height: 5,),

                Text(business_list['publishedAt'] !=null ? business_list['publishedAt'] : 'no date'
                  ,  style:Theme.of(context).textTheme.overline ,maxLines: 1,overflow: TextOverflow.ellipsis,

          )
              ],
            ),
          )
        ],
      ),
    ),
  ),
);

Widget item(
    {context,index,business_list,required Cubitc cubitc,
    })=>Padding(
  padding: const EdgeInsets.all(20),
  child: Container(
    height: 150,
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(image:
            NetworkImage('${cubitc.images[index]}')
              ,width: 150,height: 150,fit: BoxFit.fill,),
          ),
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${cubitc.title[index]}' ,maxLines: 1
                ,overflow: TextOverflow.ellipsis,
                style:Theme.of(context).textTheme.bodyText2 ,
              ),
              SizedBox(height: 4,),
              Text('no description'
                ,maxLines: 3,overflow: TextOverflow.ellipsis,
                style:Theme.of(context).textTheme.bodyText1 ,
              ),
              SizedBox(height: 5,),

            ],
          ),
        ),
     Column(
       children: [
         Row(children: [
           FloatingActionButton(heroTag: 'age++',onPressed: (){cubitc.plus(index); },mini: true,child: Icon(Icons.add_circle),)
           , SizedBox(width: 10,),
           Text('${business_list[index]}',style: Theme.of(context).textTheme.bodyText1,),
            SizedBox(width: 10,),
           FloatingActionButton(heroTag: 'age--',onPressed: (){cubitc.minus(index);},mini: true,child: Icon(Icons.remove_circle),)

         ],)
       ,  IconButton(onPressed: (){
         cubitc.add_cart(index,cubitc.title[index]);
         }, icon: Icon(Icons.add_shopping_cart)),

       ],
     )
      ],
    ),
  ),
);




Widget line()=> Padding(
  padding: const EdgeInsets.only(left: 15),
  child: Container(height: 1,color: Colors.grey,),
);


void nav({required context,required Widget})=> Navigator.push(context,
    MaterialPageRoute(builder: (context)=>Widget));
void navi({required context,required Widget})=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=> Widget), (route) => false);
Future<bool?> toast({
  required String message,
  required Toaststate toaststate
})=> Fluttertoast.showToast(
msg:  '$message',
toastLength: Toast.LENGTH_SHORT,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 1,
backgroundColor: color(toaststate),
textColor: Colors.black,
fontSize: 16.0
);
enum Toaststate{success,error,warrning}
Color color(Toaststate state)
{
  switch(state)
  {
    case Toaststate.success:
      return Colors.green;
    case Toaststate.error:
      return Colors.red;
    case Toaststate.warrning:
      return Colors.yellow;
  }

}