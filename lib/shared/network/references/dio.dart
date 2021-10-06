
import 'package:dio/dio.dart';
import 'package:shopapp/shared/endpoints/endpoints.dart';

class DioHelper{

  static Dio? dio;
  static intial()
  {
    dio = Dio(

        BaseOptions(
            baseUrl: URL,
            receiveDataWhenStatusError:  false,


        )
    );
  }
  static  Future<Response>  getdata({required String url,required dynamic map})
  async {
    dio!.options.headers = {
      'lang':'ar',
      'Content-Type':'application/json',
      'Authorization':'${token !=null? token: '' }'
    };
      return await dio!.get(url, queryParameters: map);

  }

  static Future<Response> post({required String path,Map<String,dynamic>? query,required dynamic data})
  async{
    dio!.options.headers = {
      'lang':'ar',
      'Content-Type':'application/json',
      'Authorization':'${token !=null? token: '' }'
    };
    return await dio!.post(path,data:data,queryParameters: query );
  }
  static Future<Response> put({required String path,Map<String,dynamic>? query,required dynamic data})
  async{
    dio!.options.headers = {
      'lang':'ar',
      'Content-Type':'application/json',
      'Authorization':'${token !=null? token: '' }'
    };
    return await dio!.put(path,data:data,queryParameters: query );
  }

}

