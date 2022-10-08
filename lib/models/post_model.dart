class PostModel{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? postImage;
  String? text;

  PostModel({
    this.uId,
    this.name,
    this.postImage,
    this.image,
    this.text,
    this.dateTime,
  });
  PostModel.fromJson(Map<String,dynamic>json){
    postImage=json['postImage'];
    text=json['text'];
    uId=json['uId'];
    name=json['name'];
    dateTime = json['dateTime'];
    image =json['image'];
  }

  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'dateTime':dateTime,
      'text':text,
      'uId':uId,
      'postImage':postImage,
      'image':image,
    };
  }
}