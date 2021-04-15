import 'package:testapp/model/chatModels/chat_msg_entity.dart';

chatMsgEntityFromJson(ChatMsgEntity data, Map<String, dynamic> json) {
  if (json['event'] != null) {
    data.event = json['event']?.toString();
  }
  if (json['data'] != null) {
    data.data = new ChatMsgData().fromJson(json['data']);
  }
  return data;
}

Map<String, dynamic> chatMsgEntityToJson(ChatMsgEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['event'] = entity.event;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  return data;
}

chatMsgDataFromJson(ChatMsgData data, Map<String, dynamic> json) {
  if (json['type'] != null) {
    data.type = json['type']?.toString();
  }
  if (json['content'] != null) {
    data.content = json['content']?.toString();
  }
  if (json['from'] != null) {
    data.from = json['from']?.toString();
  }
  return data;
}

Map<String, dynamic> chatMsgDataToJson(ChatMsgData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['type'] = entity.type;
  data['content'] = entity.content;
  data['from'] = entity.from;
  return data;
}
