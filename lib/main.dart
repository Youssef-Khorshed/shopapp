import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/bloc_shopapp/shop_cubit.dart';
import 'package:shopapp/shared/bloc_tracing/bloc_tst.dart';
import 'package:shopapp/shared/endpoints/endpoints.dart';
import 'package:shopapp/shared/network/local/preferences.dart';
import 'package:shopapp/shared/network/references/dio.dart';
import 'package:shopapp/shared/theme/themes.dart';
import 'package:shopapp/shared/todo_bloc/todo_cubit.dart';
import 'package:shopapp/shared/todo_bloc/todo_status.dart';

import 'layout/shop.layout/home_cubit/homecubit.dart';
import 'layout/shop.layout/home_shop_sec/shop_sec.dart';
import 'module/pageview/pageview.dart';
import 'module/shop_login_sec/shop_login.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.intial();
  await Preference.intial();
  Widget screen = Page_V();
  dynamic darkmode = Preference.get(key: 'id');
  dynamic splash   =  Preference.get(key: 'LoginScreen');
  token  =  Preference.get(key: 'token');
  print(token);
  if(splash !=null)
  {
    screen =  Shop_login();
    if(token !=null)
    {
      screen = Shop();
    }
  }

  runApp(MyApp(darkmode,screen));
}
class MyApp extends StatelessWidget
{
  bool? darkmode;
  Widget? splash ;
  MyApp(this.darkmode, this.splash);

  @override
  Widget build(BuildContext context) {

    return    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context)=>Todo_cubit()..switch_dark_light_mode(getid: darkmode)),
        BlocProvider(create:
            (context)=>ShopCubit()),
        BlocProvider(create:
            (context)=>ShopHomeCubit()..gethomedata()..get_favourites()..getcategories()..getuserdata()..cart_get_data()),
      ],child:BlocConsumer<Todo_cubit,Todo_status>(
      builder:(context,status){
        return  MaterialApp(
            debugShowCheckedModeBanner:  false,
            theme: lite_theme,
            darkTheme:dark_theme,
            themeMode: ThemeMode.light,
            home: splash  //Todo_cubit.get(context).id_sec? Page_V() : Shop_login() ,

        );
      } ,
      listener: (context,status){
      },
    ) ,
    );

  }

}
