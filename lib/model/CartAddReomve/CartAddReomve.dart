class AddRemove {
  AddRemove();
  bool status= false;
  String message= '';
  AddRemoveData data =new AddRemoveData();

  AddRemove.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? new AddRemoveData.fromJson(json['data']) : null)!;
  }

}

class AddRemoveData {
  AddRemoveData();
  int id =0;
  int quantity = 0;
  AddRemvoeProduct product =new AddRemvoeProduct();


  AddRemoveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    (json['product'] != null ? new AddRemvoeProduct.fromJson(json['product']) : null)!;
  }

}

class AddRemvoeProduct {
  AddRemvoeProduct();
  int id= 0;
  dynamic price=0, oldPrice=0,discount=0;
  String image='';
  String? name;
  String? description;



  AddRemvoeProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
