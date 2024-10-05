import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasa/companets/routing.dart';
import 'package:nasa/modules/chats/chat_details.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      buildChatItem("https://www.simplilearn.com/ice9/free_resources_article_thumb/Types_of_Artificial_Intelligence.jpg", "Ai", context),
      SizedBox(height: 20,),
      buildChatItem("", "Farmers Coummity", context),
    ],);
  }


  Widget buildChatItem(String image,String name,BuildContext context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetails());
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:
        [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              '$image',
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            '$name',
            style: TextStyle(
              height: 1.4,
            ),
          ),
        ],//
      ),
    ),
  );

}
