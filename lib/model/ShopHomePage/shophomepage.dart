class ShopHomePage{

  bool state = false;
  ShopHomeData data = new ShopHomeData();
  ShopHomePage();
  ShopHomePage.fromdata({ required Map<String,dynamic>map}){
    state = map['status'];
    data = ShopHomeData.fromdata(map:  map['data']);
  }

}
class ShopHomeData{
  ShopHomeData();
  List<Banners>banner =[];
  List <Products>products= [];
  ShopHomeData.fromdata({ required Map<String,dynamic>map}){
    map['banners'].forEach((e){
      banner.add(Banners.from(element: e));
    });
     map['products'].forEach((e){
       products.add(Products.from(element: e));
     });

  }

}
class Products  {
  Products();
  String description ='',image = '',name = '';
  bool favourite =false,incart = false;
  dynamic id = 0,discount = 0, price = 0,oldprice= 0;
  Products.from({required Map<String,dynamic> element})
  {
     image = element['image'];
     discount  = element['discount'];
     name =  element['name'];
     price = element['price'];
     oldprice =  element['old_price'];
     id =  element['id'];
     favourite =  element['in_favorites'];
     incart =  element['in_cart'];
     description =  element['description'];

  }
}
class Banners {
  Banners();
  String image ='';
  Banners.from({required Map<String,dynamic> element})
    {
      image = element['image'];
    }
}