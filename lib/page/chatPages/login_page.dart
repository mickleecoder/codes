import 'package:flutter/material.dart';
import 'package:testapp/page/chatPages/chatroom_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("聊天室登录"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: "请输入昵称"),
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text("进入房间"),
              textColor: Colors.white,
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (cxt) => ChatRoomPage(_controller.text),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
