import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiClient{

  final dioProvider = Provider((ref)=>Dio());
  static const String urlMovies = "https://api.themoviedb.org/3";
  static const apiKey = "c6aeee577586ba38e487b74dfede5deb";

  static Future get(
      String path,{
        Map<String,dynamic>? queryParameter,
        CancelToken? cancelToken
      })async{
//final configs = await ref.read(configurationsProvider.future);

//final timestamp = _getCurrentTimestamp();
    try {
      final result = await Dio().get<dynamic>(
          "$urlMovies$path",
          // cancelToken: cancelToken,
          queryParameters: {
            "api_key":apiKey,
            "language":"es"
          }
      );
      return result;
    }catch(e){
    }
    return null;

  }
}