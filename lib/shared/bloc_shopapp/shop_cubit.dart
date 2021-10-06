import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/Registeration/user_registeration.dart';
import 'package:shopapp/model/shopmodel/models.dart';
import 'package:shopapp/shared/bloc_shopapp/shop_states.dart';
import 'package:shopapp/shared/network/references/dio.dart';
class ShopCubit extends Cubit<Shopstates>
{
  ShopCubit():super(ShopIntialstate());
  static ShopCubit get(context)=> BlocProvider.of(context);
  Shop_User shop_user=  new Shop_User();
  void login({required String email,required String password})
  {
    emit(ShopLoginlstate());

    DioHelper.post(path: 'login',data:  {
      'email':'$email',
      'password':'$password'
    }, query: {
      'email':'$email',
      'password':'$password'
  }).then((value) {
    try {
      emit(ShopSucessLoginlstate());
     shop_user = Shop_User.from(map: value.data);
     print('token data  ${shop_user.data.token}');
    }catch(e){print(e);emit(ShopErrorLoginstate(error: e.toString())); }
    });

  }

 static bool check = true;
  static IconData icon =  Icons.remove_red_eye;
  void switch_eye_password()
  {
        check ? icon = Icons.visibility_off: icon =Icons.remove_red_eye ;
        check = !check;
        emit(ShopSiwtchPasswordstate());
  }
  static bool check2 = true;
  static IconData icon2 =  Icons.remove_red_eye;
  void switch_eye_password2()
  {
    check2 ? icon2 = Icons.visibility_off: icon =Icons.remove_red_eye ;
    check2 = !check2;
    emit(ShopSiwtchPasswordstate());
  }
Register register =new Register();
  void registerationform({required String name,required String phone,required String email,
    required String password})
  {
    emit(ShopRegisterlstate());
    DioHelper.post(path: 'register', data: {
      "name": "$name",
      "phone": "$phone",
      "email": "$email",
      "password": "$password",
      "image": "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"
    }).then((value) {
    register =Register.fromJson(value.data);
      print(value.data);
      emit(ShopSucessRegisterlstate());
    }).catchError((error){
      emit(ShopErrorRegisterstate(error: error.toString()));
      print(error);
    });
    
    
  }


}