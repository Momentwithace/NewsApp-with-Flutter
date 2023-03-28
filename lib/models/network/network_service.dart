import 'package:http/http.dart' as http;
import 'package:rest_api/models/network/network_helper.dart';

enum RequestType { get, put, post}

class NetworkService{
  const NetworkService._();

  static Map<String, String> _getHeaders() => {
    'content-type' : 'application/json'
  };

  static Future<http.Response>? _createrequest({
    required RequestType requestType,
    required Uri uri,
    Map<String, String>? hearders,
    Map<String, dynamic>? body,
    }){
      if (requestType == RequestType.get){
        return http.get(uri, headers: hearders );
      }
    }

static Future<http.Response?>? sendRequest({
  required RequestType requestType,
  required String url,
  Map<String, dynamic>? body,
  Map<String, String>? queryParam,
  }) async{
    try {
      final _header = _getHeaders();
      final _url = NetworkHelper.concatUrlQP(url, queryParam);

      final response = await _createrequest(
        requestType: requestType,
        uri: Uri.parse(_url),
        hearders: _header,
        body: body
        );

        return response;
      } catch(e){
        print("Error - $e");
        return null;
      }
    } 
}