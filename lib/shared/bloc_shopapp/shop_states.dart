abstract class Shopstates{}
class ShopIntialstate extends Shopstates{}
class ShopLoginlstate extends Shopstates{}
class ShopSucessLoginlstate extends Shopstates{}
class ShopErrorLoginstate extends Shopstates{
  String error;
  ShopErrorLoginstate({required this.error});
}
class ShopSiwtchPasswordstate extends Shopstates{}
class ShopRegisterlstate extends Shopstates{}
class ShopSucessRegisterlstate extends Shopstates{}
class ShopErrorRegisterstate extends Shopstates{
   String error;
  ShopErrorRegisterstate({required this.error});

}


