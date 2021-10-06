class Categories{
  Categories();
   bool? status;
   CategoriesData data = new CategoriesData();
   Categories.from({required Map<String,dynamic>map}){
     status = map['status'];
     data = CategoriesData.from(map['data']);
   }

}
class CategoriesData{
  CategoriesData();
  List<CatData> catData =[];
CategoriesData.from(Map<String,dynamic>map)
{
     map['data'].forEach((e){
     catData.add(CatData.from(e));
  });
}

}
class CatData{
  /*
  List<Map>data = [];
  CatData.from(List<dynamic> map)
  {
     map.forEach((element) {
         data.add(element);

     });
  }

   */
  CatData();
  int id = 0;
  String name ='',img='';
  CatData.from(Map<String,dynamic>map)
  {
    id=  map['id'];
    name=  map['name'];
    img=  map['image'];
  }
}