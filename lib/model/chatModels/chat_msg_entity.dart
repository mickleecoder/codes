import 'package:testapp/json/base/json_convert_content.dart';

class ChatMsgEntity with JsonConvert<ChatMsgEntity> {
  String event;
  ChatMsgData data;

  ChatMsgEntity() : super();

  ChatMsgEntity.name(String nickname) {
    this.event = "name";
    this.data = ChatMsgData.text(nickname);
  }

  ChatMsgEntity.imageMsg(String content) {
    this.event = "message";
    this.data = ChatMsgData.image(content);
  }

  ChatMsgEntity.textMsg(String content) {
    this.event = "message";
    this.data = ChatMsgData.text(content);
  }
}

class ChatMsgData with JsonConvert<ChatMsgData> {
  String type;
  String content;
  String from;

  ChatMsgData() : super();

  ChatMsgData.text(this.content) {
    this.type = "text";
  }

  ChatMsgData.image(this.content) {
    this.type = "img";
  }
}
