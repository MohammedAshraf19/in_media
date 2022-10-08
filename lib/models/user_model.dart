class UserModel{
  String? name;
  String? phone;
  String? uId;
  String? email;
  String? image;
  String? cover;
  String? bio;

  UserModel({
    this.uId,
    this.email,
    this.phone,
    this.name,
    this.image,
    this.cover,
    this.bio,
  });

  UserModel.fromJson(Map<String,dynamic>json){
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    name=json['name'];
    image =json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
    };
  }
}