import 'dart:convert';

import 'package:rest_api/models/network/network_errors.dart';
import 'package:rest_api/models/network/network_typedef.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  const NetworkHelper._();

  static String concatUrlQP(String url, Map<String, String>? queryParam){
    if(url.isEmpty) return url;
    if(queryParam == null || queryParam.isEmpty){
      return url;
    }
    final StringBuffer stringBuffer = StringBuffer("$url?");
    queryParam.forEach((key, value) { 
      if(value.trim() == "") return;
      if(value.contains(" ")) throw Exception("Invalid Input Exception");
      stringBuffer.write("$key=$value&");
    });
    final result = stringBuffer.toString();
    return result.substring(0, result.length - 1);
  }

  static bool _isValidResponse(json){
    return json != null && 
    json['status'] != null && 
    json['status'] == 'ok' && 
    json['articles'] != null;
  }

  static R filterResponse<R>({
    required NetworkCallBack callBack,
    required http.Response? response,
    required NetworkOnFailureCallBackWithMessage onFailureCallBackWithMessage,
    CallBackParameterName parameterName = CallBackParameterName.all
  }){
    try {
      if(response == null || response.body.isEmpty){
        return onFailureCallBackWithMessage(NetworkResponseErrorType.responseEmpty, "Empty Response");
      }

      var json = jsonDecode(response.body);

      if(response.statusCode == 200){
        if(_isValidResponse(json)){
          return callBack(parameterName.getJson(json));
        }
      }else if (response.statusCode == 1700){
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.socket, "Socket");
      }return onFailureCallBackWithMessage(
          NetworkResponseErrorType.didNotSucceed, "unknown");
    }catch(e){
      return onFailureCallBackWithMessage(
        NetworkResponseErrorType.exception, 'Exception $e');
    }
  }
}