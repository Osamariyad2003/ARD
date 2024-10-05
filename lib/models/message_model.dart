class ChatModel{
  late String role;
  late String text;

  ChatModel({
    required this.role,
    required this.text,
  });

  ChatModel.fromJson(Map<String ,dynamic> json ){
    role = json["role"];
    text = json["text"];
  }
}