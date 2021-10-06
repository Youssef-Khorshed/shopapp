import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/module/shop_login_sec/shop_login.dart';
import 'package:shopapp/shared/bloc_shopapp/shop_cubit.dart';
import 'package:shopapp/shared/bloc_shopapp/shop_states.dart';
import 'package:shopapp/shared/component/component.dart';

class Shop_register extends StatelessWidget {
 TextEditingController email = TextEditingController();
 TextEditingController password = TextEditingController();
 TextEditingController confirmpassword = TextEditingController();
 TextEditingController name = TextEditingController();
 TextEditingController phone = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,Shopstates>(builder: (context,state){
      ShopCubit shopCubit = ShopCubit.get(context);
      String pass_confirm ='';
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: formkey
              ,child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sing up',style: Theme.of(context).textTheme.bodyText1)
                ,SizedBox(height: 20,)
                ,Text('Sign up to get our offers',style:Theme.of(context).textTheme.bodyText2 ,)
                ,SizedBox(height: 20,)
                ,textformfield(pass: name,validator: (value){
                  if(value.toString().isEmpty) return 'Please enter  your name';
                }, prefix_icon: Icon(Icons.person), keyboard_type: TextInputType.text, text: 'Name')
                ,SizedBox(height: 20,)
                ,textformfield(pass: email,validator: (value){
                  if(value.toString().isEmpty) return 'Please enter  your email';
                  else if(!value.toString().endsWith('@gmail.com')) return 'Please enter  your gmail';

                }, prefix_icon: Icon(Icons.email), keyboard_type: TextInputType.emailAddress, text: 'Email')
                ,SizedBox(height: 20,)
                ,textformfield(pass: phone,validator: (value){
                  if(value.toString().isEmpty) return 'Please enter  your phone';
                  else if(value.toString().length !=11)  return 'phone is wrong';

                }, prefix_icon: Icon(Icons.phone), keyboard_type: TextInputType.number, text: 'Phone')
                ,SizedBox(height: 20,)
                ,textformfield(pass: password, prefix_icon: Icon(Icons.lock),suffix_hand: (){
                  shopCubit.switch_eye_password();
                },validator: (value){
                  if(value.toString().isEmpty) return 'password is wrong';
                  else if(value.toString().length !=6) return 'password is too short';
                  else {pass_confirm =value.toString();}

                },suffix_icon:ShopCubit.icon,password: ShopCubit.check, keyboard_type: TextInputType.number, text: 'Password')
                ,SizedBox(height: 20,)
                ,textformfield(pass: confirmpassword, prefix_icon: Icon(Icons.lock),suffix_hand: (){
                  shopCubit.switch_eye_password2();
                  },validator: (value){
                  if(value.toString().isEmpty) return 'Confirm password is wrong';
                  else if(pass_confirm!= value.toString() ){
                    return 'Confirm password does not match with password';
                  }
                  },suffix_icon: ShopCubit.icon2,password: ShopCubit.check2, keyboard_type: TextInputType.number, text: 'Confirm Password')
                ,SizedBox(height: 20,)
                ,BuildCondition(
                  fallback:(context)=> Center(child: CircularProgressIndicator(),),
                  condition: state is!ShopRegisterlstate,
                  builder: (context)=>Container(
                    child: DefaultButton(controll: (){
                      if(formkey.currentState!.validate()) {
                        shopCubit.registerationform(name: name.text, phone: phone.text, email: email.text, password: password.text);
                      }
                    }, text: 'Register'),
                  ),
                )
                ,Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('Already have Account'),
                    TextButton(onPressed: (){
                    }, child: Text('Sign in '))
                  ],
                )
              ],
            ),
            ),
          ),
        ),
      );

    }, listener: (context,state){

      ShopCubit shopCubit = ShopCubit.get(context);
      if(state is ShopSucessRegisterlstate)
      {
      if(shopCubit.register.status == true ) {
      toast(message: '${shopCubit.register.message}', toaststate: Toaststate.success);
      navi(context: context, Widget: Shop_login());
      }
      else
      {
      toast(message: '${shopCubit.register.message}', toaststate: Toaststate.warrning);
      }
      }
      else if(state is ShopErrorRegisterstate)
      {
      toast(message: '${state.error}', toaststate: Toaststate.error);

      }


    }) ;
  }
}
