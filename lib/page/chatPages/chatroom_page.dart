import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final String nickName;
  ChatRoomPage(this.nickName);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("聊天室"),
      ),
      body: Text("${widget.nickName}"),
    );
  }
}
