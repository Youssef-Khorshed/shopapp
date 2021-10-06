class ShopFavourite{
  ShopFavourite();
  bool state = false;
  String message= '';
  ShopFavourite.from({required Map<String,dynamic>map}){
    state = map['status'];
    message = map['message'];
  }
}