class Cart_get {
  bool status =false;
  CartData data= new CartData();
  Cart_get();

  Cart_get.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? new CartData.fromJson(json['data']) : null)!;
  }

}

class CartData {
  CartData();
  List<CartItems> cartItems =[];
  dynamic subTotal= 0, total =0;

  CartData.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      json['cart_items'].forEach((v) {
        cartItems.add(new CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }

}

class CartItems {
  CartItems();
  dynamic id =0,quantity =0;
  CartProduct product= new CartProduct();
  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = (json['product'] != null ? new CartProduct.fromJson(json['product']) : null)!;
  }

}

class CartProduct {
  dynamic id =0,price =0,oldPrice=0,discount=0;
  String image='';
  String name='';
  String description='';
  List<String> images =[];
  bool inFavorites= false;
  bool inCart =false;

  CartProduct();
  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}
