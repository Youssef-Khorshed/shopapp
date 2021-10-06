import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop.layout/home_cubit/homecubit.dart';
import 'package:shopapp/layout/shop.layout/home_shop_sec/shop_sec.dart';
import 'package:shopapp/module/shop_register_sec/shop_login.dart';
import 'package:shopapp/shared/bloc_shopapp/shop_cubit.dart';
import 'package:shopapp/shared/bloc_shopapp/shop_states.dart';
import 'package:shopapp/shared/component/component.dart';
import 'package:shopapp/shared/endpoints/endpoints.dart';
import 'package:shopapp/shared/network/local/preferences.dart';

class Shop_login extends StatelessWidget {
 TextEditingController email = TextEditingController();
 TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,Shopstates>(builder: (context,state){
      ShopCubit shopCubit = ShopCubit.get(context);
      return  Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formkey
                ,child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Login',style
                      : Theme.of(context).textTheme.bodyText1)
                  ,SizedBox(height: 10,)
                  ,Text('Login to get our offers',
                    style:Theme.of(context).textTheme.overline ,)
                  ,SizedBox(height: 20,)
                  ,Container(
                    child: textformfield(pass: email
                        ,validator: (value){
                          if(value.toString().isEmpty) return 'Please enter  your email';
                          else if(!value.toString().endsWith('@gmail.com')) return 'Please enter  your gmail';
                        }
                        ,onsubmit: (value){}, prefix_icon: Icon(Icons.email), keyboard_type: TextInputType.emailAddress, text: 'Email'),
                  )
                  ,SizedBox(height: 15,)
                  ,Container(
                    child: textformfield(pass: password
                        ,validator: (value){
                          if(value.toString().isEmpty) return 'Enter Password please';
                          else if(value.toString().length < 6) return 'Password is too short';

                        }
                        ,onsubmit: (value){},suffix_hand:(){ shopCubit.switch_eye_password();},suffix_icon:ShopCubit.icon,password:ShopCubit.check , prefix_icon: Icon(Icons.lock), keyboard_type: TextInputType.number, text: 'Password'),
                  )
                  ,SizedBox(height: 10,)
                  ,BuildCondition(
                    fallback: (context)=>Center(child: CircularProgressIndicator()),
                    builder: (context)=>Container(child:
                    DefaultButton(controll: (){
                      if(formkey.currentState!.validate()){
                        ShopCubit.get(context).login(email: email.text, password: password.text );
                      }
                    }, text: 'Login')),
                    condition: state is! ShopLoginlstate ,
                  )
                  ,Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('Don\`t have Account'),
                      TextButton(onPressed: (){
                        nav(context:context,Widget:  Shop_register());
                      }, child: Text('Register now'))
                    ],
                  )
                ],
              ),
              ),
            ),
          ),
        ),
      );
    }, listener: (context,state){
      ShopCubit shopCubit = ShopCubit.get(context);
      if(state is ShopSucessLoginlstate )
        {
          if(shopCubit.shop_user.state == true ){

            toast(message: '${shopCubit.shop_user.message.toString()}', toaststate: Toaststate.success);
            Preference.put(key: 'token', value: shopCubit.shop_user.data.token);
            token = shopCubit.shop_user.data.token;
            ShopHomeCubit.get(context).getcategories();
            ShopHomeCubit.get(context).getuserdata();
            ShopHomeCubit.get(context).get_favourites();
            ShopHomeCubit.get(context).products_elec.clear();
            ShopHomeCubit.get(context).products_corona.clear();
            ShopHomeCubit.get(context).products_sport.clear();
            ShopHomeCubit.get(context).products_lights.clear();
            ShopHomeCubit.get(context).gethomedata();
            ShopHomeCubit.get(context).cart_get_data();





            navi(context: context, Widget: Shop());
          }
          else{

              toast(message: '${shopCubit.shop_user.message.toString()}', toaststate: Toaststate.warrning);


          }
        }
     else if(state is ShopErrorLoginstate ) {
        toast(message: '${shopCubit.shop_user.message.toString()}',
            toaststate: Toaststate.error);
      }
     } );
  }
}
