import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;
  static init(){
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        headers: {
        'Content-Type':'application/json',
        'Accept':'application/json'
        }
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
  }) async {
    return await dio.get(url,queryParameters: query);
  }
  static Future<Response> postData({
    @required String url,
    Map<String,dynamic>query,
    @required Map<String,dynamic>data,
    
  }) async {
    return await dio.post(
    url,data:data,queryParameters:query);
  }
  
  static Future<Response> putData({
    @required String url,
    Map<String,dynamic>query,
    @required Map<String,dynamic>data,
    
  }) async {
    return await dio.put(url,data:data,queryParameters:query);
  }
  static Future<Response> deleteData({
    @required String url,
    Map<String,dynamic>query,
    @required Map<String,dynamic>data,
    
  }) async {
    return await dio.delete(url,data:data,queryParameters:query);
  }

}

