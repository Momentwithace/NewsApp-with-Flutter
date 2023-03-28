enum NetworkResponseErrorType{
  socket,
  exception,
  responseEmpty,
  didNotSucceed
}

enum CallBackParameterName{
  all,
  articles
}

extension CallBackParameterNameExtension on CallBackParameterName {
  dynamic getJson(json){
    if(json == null) return null;
    switch(this){
      case CallBackParameterName.all:
        return json;
      case CallBackParameterName.articles:
      return json['articles'];
    }
  }
}