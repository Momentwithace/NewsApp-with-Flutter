 import 'package:flutter/material.dart';
import 'package:rest_api/models/article_models.dart';
import 'package:url_launcher/url_launcher.dart';



class ArticleWidget extends StatelessWidget {
   const ArticleWidget({super.key, required this.article});

   final Article article;
 
   @override
   Widget build(BuildContext context) {

    final Uri _url = Uri.parse(article.url!);
    final publishedAt = article.publishedAt?.split("T")[0];
     return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey,
            backgroundImage: article.imageUrl != null
            ? NetworkImage(article.imageUrl!) 
            : null,
          ),const SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.title!,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
                const SizedBox(
                  height: 12,
                ),
                 Text(article.author,
                style: const TextStyle(color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children:[
                    Expanded(
                      child: Text(article.source.name ?? "",
                       style:const TextStyle(color: Colors.grey),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.calendar_today_sharp,
                      size: 15
                    ),
                    const SizedBox(width: 8,),
                    Text(publishedAt ?? '',
                     style: const TextStyle(color: Colors.grey),
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                    )
                  ],
                )
              ],
            )
            ),
            const SizedBox(
              width: 16,
            ),
            IconButton(
              onPressed: () {
                _launchUrl(article.url!);
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined,
              color: Colors.grey,)
            )
        ],
      ),
     );
   }
 }

  Future<void> _launchUrl(String url) async{
    final Uri url0 = Uri.parse(url);
   if(!await launchUrl(url0)){
    throw Exception("Could not launch");
  }
 }
 