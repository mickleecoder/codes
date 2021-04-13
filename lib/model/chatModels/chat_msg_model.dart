class ChatMsgModel {
  String type;
  String content;
  String from;

  ChatMsgModel({this.type, this.content, this.from});

  ChatMsgModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content = json['content'];
    from = json['from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['content'] = this.content;
    data['from'] = this.from;
    return data;
  }
}
