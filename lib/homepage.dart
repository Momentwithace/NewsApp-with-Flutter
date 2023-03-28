import 'package:flutter/material.dart';
import 'package:rest_api/article_widget.dart';
import 'package:rest_api/models/article_models.dart';
import 'package:rest_api/models/network/network_errors.dart';
import 'package:rest_api/models/network/network_helper.dart';
import 'package:rest_api/models/network/network_service.dart';
import 'package:rest_api/models/network/query_param.dart';
import 'package:rest_api/static/static_values.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Article"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot .hasData){

            final List<Article> article = snapshot.data as List<Article>;
            return ListView.builder(
            itemBuilder: (context, index){
              return ArticleWidget(
                article: article[index]);
            },
            itemCount: article.length,
            );
          }else if (snapshot.hasError){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 25,
                  ),
                  SizedBox(height: 10,),
                  Text("Something went wrong")
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        ),
    );
  }

  Future<List<Article>?> getData() async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get, 
      url: StaticValues.apiUrl,
      queryParam: QP.apiQP(
        apikey: StaticValues.apiKey,
        country: StaticValues.apiCountry
      )
    );
    print(response?.statusCode);

    return await NetworkHelper.filterResponse(
      callBack: _listOfArticleFromJson, 
      response: response, 
      parameterName: CallBackParameterName.articles,
      onFailureCallBackWithMessage: (errorType, msg){
        print("Error type-$errorType - Message $msg");
        return null;
      });
  }

  List<Article> _listOfArticleFromJson(json) => (json as List)
      .map((e) => Article.fromJson(e as Map<String, dynamic>))
      .toList();
}