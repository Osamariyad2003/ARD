import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:nasa/companets/colors.dart';
import 'package:nasa/companets/constants.dart';
import 'package:nasa/models/message_model.dart';

class ChatDetails extends StatefulWidget {
  const ChatDetails({super.key});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {

  TextEditingController userController =TextEditingController();
  List<ChatModel> messages=[];
  var result="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            setState(() {
              messages=[];
            });

          }, icon: Icon(Icons.refresh,color: Colors.white,))
        ],
        title: Text('ChatBot',style: TextStyle(color: Colors.white),),
        backgroundColor: mainColor,
      ),

      body: Padding(padding: EdgeInsets.all(10),
        child:  Column(
          children: [
            Expanded(child:
            ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index) {
                     return MessageContent( role: messages[index].role, text: messages[index].text,);
                },
                separatorBuilder:(context,index) => SizedBox(height: 10,) ,
                itemCount: messages.length)
            ),
            Container(
                child: Row(
                  children: [
                    Expanded(
                        child:Container(
                          decoration: BoxDecoration(
                              color: fieldColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              children: [
                                TextFormField(

                                  style: TextStyle(color: mainColor),
                                  controller:userController ,
                                  decoration: InputDecoration(
                                    fillColor: fieldColor,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: 'What is in Your mind',
                                      border: InputBorder.none
                                  ),

                                ),
                              ],
                            ),
                          ),
                        )
                    ),

                    SizedBox(width: 6,),

                    Container(
                      height: 50,
                      width: 50,

                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child: MaterialButton(
                        onPressed: () async {

                          setState(() {
                            ChatModel userModel =ChatModel(role: 'user', text:userController.text,);
                            messages.add(userModel);
                          });
                          if(userController.text.trim().isNotEmpty){
                            result = await  getText(userController.text);
                            setState(() {
                              ChatModel promptModel =ChatModel(role: 'ai', text:result );
                              messages.add(promptModel);
                              userController.clear();

                            });}},
                        child: Icon(Icons.send,size: 16,color: Colors.white,),
                      ),
                    )

                  ],
                ))
          ],
        ),
      ),


    );
  }
}

Widget MessageContent({required role,required text}){
  return  Align(
    alignment:  role=="user"?AlignmentDirectional.centerEnd:AlignmentDirectional.centerStart,

    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:role=="user"? mainColor:fieldColor,
        borderRadius: BorderRadiusDirectional.only(
            bottomEnd: role =="user"?Radius.circular(0):Radius.circular(10),
            bottomStart: role =="user"?Radius.circular(10):Radius.circular(0),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10)
        ),
      ),
      child: Text(text,style: TextStyle(color: Colors.white),),
    ),
  );
}

Future<String> getText(String message) async {
  String result = '';
  try {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: token);
    final prompts = message;
    final content = [Content.text(prompts)];

    // Send request and get the response
    final response = await model.generateContent(content);

    // Log the response object
    log("AI Response: ${response.toString()}");

    // Check if the response contains text and log it
    result = response.text ?? '';
    if (result.isEmpty) {
      log("Empty response text from AI");
    } else {
      log("Generated text: $result");
    }

    return result;
  } catch (e) {
    log("Error in generating AI content: $e");
  }
  return 'Error generating response';
}


