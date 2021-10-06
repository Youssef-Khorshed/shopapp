class Register {
  Register();
  bool status =false;
  dynamic message ='';
  RegisterData data = new  RegisterData();

  Register.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? new RegisterData.fromJson(json['data']) : new  RegisterData());
  }

}

class RegisterData {
  RegisterData();
  String name ='';
  String phone ='';
  String email ='';
  int id =0;
  String image ='';
  String token ='';

  RegisterData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }

}
