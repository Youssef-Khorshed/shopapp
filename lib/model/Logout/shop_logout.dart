class LogoutShop {
  LogoutShop();
  bool status =false;
  String message= '';
  Shop_logoutData data = new Shop_logoutData();

  LogoutShop.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? new Shop_logoutData.fromJson(json['data']) : null)!;
  }

}

class Shop_logoutData {
  Shop_logoutData();
  int id =0;
  String token = '';

  Shop_logoutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
  }

}
