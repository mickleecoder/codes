import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testapp/model/chatModels/chat_msg_entity.dart';
import 'package:testapp/utils/websocket_util.dart';

class ChatRoomModel extends ChangeNotifier {
// json编解码器
  final JsonCodec json = JsonCodec();
  // 字符串的utf-8编解码器
  final Utf8Codec utf8 = Utf8Codec();
  //融合两种编码器
  Codec msgCodec;

  // ignore: deprecated_member_use
  List<ChatMsgData> _msgList = List<ChatMsgData>();

  List<ChatMsgData> get msgList => UnmodifiableListView(_msgList);

  WebSocketUtils _utils;

  ChatRoomModel() {
    msgCodec = json.fuse(utf8);
    _utils = WebSocketUtils();
    try {
      _utils.connect();
      _utils.stream.listen((event) {
        _handleMessage(msgCodec.decode(event));
      });
    } catch (e, s) {
      print(s);
    }
  }

  void setNickName(String nickname) {
    debugPrint("setNickName");
    _utils.send(msgCodec.encode(ChatMsgEntity.name(nickname).toJson()));
  }

  void _handleMessage(Map data) {
    switch (data["event"]) {
      case "message":
        var itemData = ChatMsgEntity().fromJson(data).data;
        _msgList.add(itemData);
        notifyListeners();
        break;
      case "name_ack":
        debugPrint("name_ack....");
        // Fluttertoast.showToast(
        //     msg:"进入聊天室",
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );
        break;
      case "keepalive":
        // var key = data["data"];
        // // 从映射中取出时间戳对应的任务完成
        // if(_taskMap.containsKey(key)){
        //   _taskMap[key].complete(null);
        //   _taskMap.remove(key);
        // } else{
        //   // TODO:心跳异常处理
        // }
        break;
      default:
    }
  }

  void sendMessege(String context) {
    //1、创建实体类
    //2、实体类转json对象（Map）
    //3、Map对象 转二进制字节流
    var byte = msgCodec.encode(ChatMsgEntity.textMsg(context).toJson());
    _utils.send(byte);
  }

  void sendImage() {}
}
