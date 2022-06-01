class MessageModel {
  String? dateTime;
  String? senderId;
  String? recieverId;
  String? content;

  MessageModel({
    this.dateTime,
    this.recieverId,
    this.senderId,
    this.content,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    dateTime = json["dateTime"];
    recieverId = json["recieverId"];
    senderId = json["senderId"];
    content = json["content"];
  }

  Map<String, dynamic> toMap() => {
        'dateTime': dateTime,
        'recieverId': recieverId,
        'senderId': senderId,
        'content': content,
      };
}
