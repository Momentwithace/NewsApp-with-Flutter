
import 'package:rest_api/models/network/network_errors.dart';

typedef NetworkCallBack<R> =  R Function(dynamic);
typedef NetworkOnFailureCallBackWithMessage<R> = R Function(
  NetworkResponseErrorType, String
);