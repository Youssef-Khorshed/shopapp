class Shop_User{
    Shop_User();
    bool state = false;
    dynamic message= '';
   Shop_User_Data data = new Shop_User_Data();

  Shop_User.from({required Map<String,dynamic>map})
 {
  this.state = map['status'];
  this.message = map['message'];
  this.data = (map['data'] == null ? null: Shop_User_Data.from(map: map['data']))! ;
}
}
class Shop_User_Data{
  Shop_User_Data();
   String name ='',phone ='',email ='',image ='',token ='';
    int id = 0;
   Shop_User_Data.from({required Map<String,dynamic>map})
  {
    this.name = map['name'];
    this.phone = map['phone'];
    this.email = map['email'];
    this.image = map['image'];
    this.token = map['token'];
    this.id = map['id'];
  }
}