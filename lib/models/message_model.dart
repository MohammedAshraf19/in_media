class MessageModel{
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.text,
    this.dateTime,
  });
  MessageModel.fromJson(Map<String,dynamic>json){
    senderId=json['senderId'];
    text=json['text'];
    receiverId=json['receiverId'];
    dateTime = json['dateTime'];
  }
  Map<String,dynamic>toMap(){
    return{
      'receiverId':receiverId,
      'dateTime':dateTime,
      'text':text,
      'senderId':senderId,
    };
  }
}