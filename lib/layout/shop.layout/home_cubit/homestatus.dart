
import 'package:shopapp/model/ShopFavourite/favourite.dart';

abstract class ShopHomeStates{}
class ShopHomeInitialState extends ShopHomeStates{}
class ShopHomeLoadingState extends ShopHomeStates{}
class ShopHomeNavigationState extends ShopHomeStates{}
class ShopHomeSucessDataState extends ShopHomeStates{}
class ShopHomeInitialSucessFavouriteState extends ShopHomeStates{}
class ShopHomeSucessFavouriteState extends ShopHomeStates{
  ShopFavourite shopFavourite ;
  ShopHomeSucessFavouriteState({ required this.shopFavourite});
}
class ShopHomeErrorFavouriteState extends ShopHomeStates{
   ShopFavourite shopFavourite ;
  ShopHomeErrorFavouriteState({ required this.shopFavourite});
}
class ShopHomeLoadingGetFavouriteState extends ShopHomeStates{}
class ShopHomeSucessGetFavouriteState extends ShopHomeStates{}
class ShopHomeErrorGetFavouriteState extends ShopHomeStates{}
class ShopHomesmoothState extends ShopHomeStates{}
class ShopHomeGotoCartState extends ShopHomeStates{}
class ShopHomeLoadingGetCartDataState extends ShopHomeStates{}
class ShopHomeSucessGetCartDataState extends ShopHomeStates{}
class ShopHomeErrorGetCartDataState extends ShopHomeStates{
  String error;
  ShopHomeErrorGetCartDataState({required this.error});

}
class ShopHomeLoadingAddRemoveCartDataState extends ShopHomeStates{}
class ShopHomeSucessAddRemoveCartDataState extends ShopHomeStates{}
class ShopHomeErrorAddRemoveCartDataState extends ShopHomeStates{
  String error;
  ShopHomeErrorAddRemoveCartDataState({required this.error});
}
class ShopHomecounterchangeState extends ShopHomeStates{}
class ShopHomeupdateCartState extends ShopHomeStates{
  String message ='';
  ShopHomeupdateCartState({required this.message});
}
class ShopHomeupdateErrorCartState extends ShopHomeStates{
  String error ='';
  ShopHomeupdateErrorCartState({required this.error});
}




