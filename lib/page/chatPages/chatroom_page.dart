import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/model/chatModels/chat_msg_entity.dart';
import 'package:testapp/model/chatModels/chatroom_model.dart';
import 'package:testapp/widget/inputbox_widget.dart';
import 'package:testapp/widget/triangle.dart';

class ChatRoomPage extends StatefulWidget {
  final String nickName;

  ChatRoomPage(this.nickName);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  ChatRoomModel _model;

  @override
  void initState() {
    super.initState();

    _model = ChatRoomModel();
    _model.setNickName(widget.nickName);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter聊天室"),
        ),
        body: Builder(
          builder: (ctx) {
            var model = ctx.watch<ChatRoomModel>();
            return InputBoxWidget(
              callback: (val) {
                // _model.sendMessage(val);
              },
              body: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  itemCount: model.msgList.length,
                  itemBuilder: (ctx, index) {
                    return _buildItem(model.msgList[index]);
                  }),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(ChatMsgData item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                child: Text(item.from[0]),
              ),
              TriangleWidget(
                width: 6,
                height: 12,
                color: Color(0xffe5eefe),
              ),
            ],
          ),
          Container(
              constraints: BoxConstraints(minHeight: 40),
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: Color(0xffe5eefe),
                  borderRadius: BorderRadius.circular(6)),
              child: item.type == "text"
                  ? Text(
                      item.content,
                      style: TextStyle(fontSize: 18),
                    )
                  : Image.network(item.content))
        ],
      ),
    );
  }
}
