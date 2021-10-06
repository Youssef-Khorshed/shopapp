import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homecubit.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homestatus.dart';
import 'package:shopapp/module/shop_login_sec/shop_login.dart';
import 'package:shopapp/shared/component/component.dart';
import 'package:shopapp/shared/endpoints/endpoints.dart';

class Shop_settingsPage extends StatelessWidget {
  const Shop_settingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(builder: (context,state){
      TextEditingController user =TextEditingController();
      ShopHomeCubit shopHomeCubit = ShopHomeCubit.get(context);
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              height: 500,
                  decoration: BoxDecoration(color: Color(0xFFEEEDED) ,borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: user_profile(shopHomeCubit: shopHomeCubit,context: context,user: user),
            ),
          ),
        ),
      );
    },  listener: (context,state){

    });
  }

Widget user_profile({required ShopHomeCubit shopHomeCubit,required  context, required TextEditingController user})
{
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
        CircleAvatar(backgroundImage:NetworkImage(shopHomeCubit.shop_user.data.image) ,radius: 50,)
       ,SizedBox(height: 20,)
      , textformfield(pass: user, prefix_icon: Icon(Icons.supervised_user_circle)
           , keyboard_type: TextInputType.text
           , text: '${shopHomeCubit.shop_user.data.name}',enabled: false)
       ,SizedBox(height: 20,)
       , textformfield(pass: user, prefix_icon: Icon(Icons.email)
         , keyboard_type: TextInputType.text
         , text: '${shopHomeCubit.shop_user.data.email}',enabled: false)
       ,SizedBox(height: 20,)
       , textformfield(pass: user, prefix_icon: Icon(Icons.phone)
         , keyboard_type: TextInputType.text
         , text: '${shopHomeCubit.shop_user.data.phone}',enabled: false)
       ,Spacer()
       ,MaterialButton(color: Colors.blueGrey,onPressed: (){
         shopHomeCubit.my_logout();
         token ='';
         shopHomeCubit.index = 0;
         navi(context: context, Widget: Shop_login());
       },child: Text('Sing out',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25),),)
     ],
   );

}

}
